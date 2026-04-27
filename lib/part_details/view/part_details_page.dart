import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_repository/image_repository.dart';
import 'package:inventory_app/l10n/l10n.dart';
import 'package:inventory_app/part_details/bloc/part_details_bloc.dart';
import 'package:inventory_app/part_details/bloc/part_details_state.dart';
import 'package:inventory_app/part_details/widgets/part_details_image.dart';
import 'package:inventory_app/part_details/widgets/part_details_in_stock.dart';
import 'package:inventory_app/part_details/widgets/part_details_info_display.dart';
import 'package:inventory_app/part_details/widgets/part_details_pop_up_menu.dart';
import 'package:inventory_app/part_details/widgets/sheets/image_picker_sheet.dart';
import 'package:inventory_app/part_details/widgets/sheets/restock_sheet.dart';
import 'package:inventory_app/part_details/widgets/sheets/transfer_sheet.dart';
import 'package:inventory_app/part_details/widgets/sheets/use_stock_sheet.dart';
import 'package:inventory_app/shared/constants/layout.dart';
import 'package:inventory_app/shared/extensions/show_snack_bar_extensions.dart';
import 'package:inventory_app/shared/widgets/tags_row.dart';
import 'package:inventory_app/use_cases/part_presentation.dart/models/part_presentation.dart';
import 'package:inventory_app/use_cases/part_presentation.dart/models/stock_presentation.dart';
import 'package:inventory_app/use_cases/part_presentation.dart/watch_single_part_presentation.dart';
import 'package:part_repository/part_repository.dart';
import 'package:stock_repository/stock_repository.dart';
import 'package:storage_repository/storage_repository.dart';

class PartDetailsPage extends StatelessWidget {
  const PartDetailsPage({required this.initialPart, super.key});

  final PartPresentation initialPart;

  static MaterialPageRoute<void> route({
    required PartPresentation part,
  }) => MaterialPageRoute<void>(
    builder: (_) => PartDetailsPage(initialPart: part),
  );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PartDetailsBloc(
        initialPart: initialPart,
        watchSinglePartPresentation: context
            .read<WatchSinglePartPresentation>(),
        stockRepository: context.read<StockRepository>(),
        storageRepository: context.read<StorageRepository>(),
        partRepository: context.read<PartRepository>(),
        imageRepository: context.read<ImageRepository>(),
      ),
      child: const PartDetailsView(),
    );
  }
}

class PartDetailsView extends StatelessWidget {
  const PartDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(context.watch<PartDetailsBloc>().state.part.name),
        actions: const [PartDetailsPopUpMenu()],
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<PartDetailsBloc, PartDetailsState>(
            listenWhen: (previous, current) => current.deleteStatus == .done,
            listener: (context, state) =>
                Navigator.of(context).popUntil((route) => route.isFirst),
          ),
          BlocListener<PartDetailsBloc, PartDetailsState>(
            listenWhen: (previous, current) =>
                previous.imageStatus != current.imageStatus &&
                current.imageStatus == .done,
            listener: (context, state) {
              if (state.error == null) {
                context.showSuccessSnackBar(
                  context.l10n.snackbarImageUpdated,
                );
              }
            },
          ),
          BlocListener<PartDetailsBloc, PartDetailsState>(
            listenWhen: (previous, current) => previous.error != current.error,
            listener: (context, state) {
              final error = state.error;
              if (error != null) context.showErrorSnackBar(error);
            },
          ),
        ],
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: kContentMaxWidth),
            child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: BlocBuilder<PartDetailsBloc, PartDetailsState>(
            builder: (context, state) {
              final part = state.part;
              return Padding(
                padding: const .fromLTRB(24, 8, 24, 100),
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    Row(
                      mainAxisAlignment: .spaceBetween,
                      children: [
                        TextButton.icon(
                          icon: const Icon(Icons.add),
                          onPressed: () => _showRestockSheet(context),
                          label: Text(l10n.partDetailsSelectorRestock),
                        ),
                        TagsRow(
                          part: part,
                          textStyle: context.text.bodyMedium?.copyWith(
                            color: context.colors.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                    PartDetailsImage(
                      onAddImagePressed: () => _showAddImageSheet(context),
                    ),
                    PartDetailsInfoDisplay(part: part),
                    const SizedBox(height: 32),
                    PartDetailsInStock(
                      part: part,
                      onStockSelected: (stock) =>
                          _showUseStockSheet(context, stock, part.name),
                      onTransferSelected: (stock) =>
                          _showTransferSheet(context, stock),
                      textStyle: _variantTextStyle(context),
                    ),
                    if (part.generalTags.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      const Divider(),
                      Wrap(
                        spacing: 8,
                        runSpacing: 4,
                        children: part.generalTags
                            .map(
                              (tag) => Chip(
                                avatar: Icon(
                                  Icons.tag,
                                  size: 14,
                                  color: tag.color,
                                ),
                                label: Text(tag.label),
                                visualDensity: .compact,
                                labelStyle: _variantTextStyle(context),
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ],
                ),
              );
            },
          ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showUseStockSheet(
    BuildContext context,
    StockPresentation stock,
    String partName,
  ) {
    return showModalBottomSheet<void>(
      useSafeArea: true,
      showDragHandle: true,
      isScrollControlled: true,
      context: context,
      builder: (_) => BlocProvider.value(
        value: context.read<PartDetailsBloc>(),
        child: UseStockSheet(stock: stock),
      ),
    );
  }

  Future<void> _showRestockSheet(BuildContext context) {
    return showModalBottomSheet<void>(
      useSafeArea: true,
      showDragHandle: true,
      isScrollControlled: true,
      context: context,
      builder: (_) => BlocProvider.value(
        value: context.read<PartDetailsBloc>(),
        child: const RestockSheet(),
      ),
    );
  }

  Future<void> _showTransferSheet(
    BuildContext context,
    StockPresentation sourceStock,
  ) {
    return showModalBottomSheet<void>(
      useSafeArea: true,
      showDragHandle: true,
      isScrollControlled: true,
      context: context,
      builder: (_) => BlocProvider.value(
        value: context.read<PartDetailsBloc>(),
        child: TransferSheet(sourceStock: sourceStock),
      ),
    );
  }
}

Future<void> _showAddImageSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    useSafeArea: true,
    showDragHandle: true,
    context: context,
    builder: (_) => BlocProvider.value(
      value: context.read<PartDetailsBloc>(),
      child: const ImagePickerSheet(),
    ),
  );
}

TextStyle _variantTextStyle(BuildContext context) {
  return TextStyle(
    color: context.colors.onSurfaceVariant,
  );
}
