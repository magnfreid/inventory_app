import 'package:app_ui/app_ui.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_repository/image_repository.dart';
import 'package:intl/intl.dart';
import 'package:inventory_app/l10n/l10n.dart';
import 'package:inventory_app/part_details/bloc/part_details_bloc.dart';
import 'package:inventory_app/part_details/bloc/part_details_state.dart';
import 'package:inventory_app/part_details/widgets/delete_image_sheet.dart';
import 'package:inventory_app/part_details/widgets/delete_part_sheet.dart';
import 'package:inventory_app/part_details/widgets/image_picker_sheet.dart';
import 'package:inventory_app/part_details/widgets/in_stock_list.dart';
import 'package:inventory_app/part_details/widgets/restock_sheet.dart';
import 'package:inventory_app/part_details/widgets/use_stock_sheet.dart';
import 'package:inventory_app/part_editor/view/part_editor_page.dart';
import 'package:inventory_app/shared/extensions/show_snack_bar_extensions.dart';
import 'package:inventory_app/shared/widgets/recycled_icon.dart';
import 'package:inventory_app/shared/widgets/tags_row.dart';
import 'package:inventory_app/use_cases/part_presentation.dart/models/part_presentation.dart';
import 'package:inventory_app/use_cases/part_presentation.dart/models/stock_presentation.dart';
import 'package:inventory_app/use_cases/part_presentation.dart/watch_single_part_presentation.dart';
import 'package:part_repository/part_repository.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:stock_repository/stock_repository.dart';
import 'package:storage_repository/storage_repository.dart';

enum _MenuAction { edit, deletePart, deleteImage }

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
        actions: const [_PopUpMenu()],
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<PartDetailsBloc, PartDetailsState>(
            listenWhen: (previous, current) => current.deleteStatus == .done,
            listener: (context, state) =>
                Navigator.of(context).popUntil((route) => route.isFirst),
          ),
          BlocListener<PartDetailsBloc, PartDetailsState>(
            listenWhen: (previous, current) => previous.error != current.error,
            listener: (context, state) {
              final error = state.error;
              if (error != null) context.showErrorSnackBar(error);
            },
          ),
        ],
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
                    _Image(
                      onAddImagePressed: () => _showAddImageSheet(context),
                    ),
                    _Details(part: part),
                    const SizedBox(height: 32),
                    InStockList(
                      part: part,
                      onStockSelected: (stock) =>
                          _showUseStockSheet(context, stock, part.name),
                      textStyle: _variantTextStyle(context),
                    ),
                  ],
                ),
              );
            },
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
}

Future<void> _showAddImageSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    useSafeArea: true,
    showDragHandle: true,
    // isScrollControlled: true,
    context: context,
    builder: (_) => BlocProvider.value(
      value: context.read<PartDetailsBloc>(),
      child: const ImagePickerSheet(),
    ),
  );
}

class _Details extends StatelessWidget {
  const _Details({required this.part});

  final PartPresentation part;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final description = part.description;
    return Padding(
      padding: const .symmetric(vertical: 8),
      child: Column(
        children: [
          _DetailField(
            title: l10n.formFieldDetailNumberLabelText,
            trailing: part.detailNumber.isEmpty ? '-' : part.detailNumber,
          ),
          _DetailField(
            title: l10n.formFieldRecycledStatusLabelText,
            trailing: part.isRecycled
                ? l10n.formFieldRecycledLabelText
                : l10n.formFieldNewLabelText,
            icon: part.isRecycled ? const RecycledIcon() : null,
          ),
          _DetailField(
            title: l10n.formFieldPriceLabelText,
            trailing: NumberFormat.currency(
              locale: 'sv_SE',
              symbol: 'kr',
              decimalDigits: 2,
            ).format(part.price),
          ),
          if (description != null && description.isNotEmpty)
            Padding(
              padding: const .symmetric(vertical: 8),
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Text(
                    context.l10n.formFieldDescriptionLabelText,
                  ),
                  const SizedBox(
                    height: 4,
                    width: double.infinity,
                  ),
                  Text(
                    description,
                    style: TextStyle(
                      color: context.colors.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _DetailField extends StatelessWidget {
  const _DetailField({required this.title, required this.trailing, this.icon});

  final String title;
  final String trailing;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const .symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          Text(title),
          Row(
            spacing: 4,
            children: [
              ?icon,
              Text(
                trailing,
                style: TextStyle(color: context.colors.onSurfaceVariant),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Image extends StatelessWidget {
  const _Image({required this.onAddImagePressed});

  final VoidCallback onAddImagePressed;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PartDetailsBloc, PartDetailsState>(
      builder: (context, state) {
        final imagePath = state.part.imgPath;
        return state.imageStatus == .loading
            ? const _ImageFrame(
                child: Center(child: CircularProgressIndicator.adaptive()),
              )
            : switch (imagePath) {
                String() => _ImageFrame(
                  hideBorder: true,
                  child: CachedNetworkImage(
                    imageUrl: imagePath,
                    fit: BoxFit.fitWidth,
                    placeholder: (context, url) => Shimmer(
                      duration: const Duration(seconds: 4),
                      color: context.colors.onSurface,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: .circular(6),
                          color: context.colors.surface,
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => const Center(
                      child: Column(
                        mainAxisSize: .min,
                        children: [
                          Icon(Icons.image_not_supported),
                          Text('Image could not be loaded.'),
                        ],
                      ),
                    ),
                  ),
                ),
                null => _ImageFrame(
                  child: Center(
                    child: TextButton.icon(
                      icon: const Icon(Icons.add),
                      onPressed: onAddImagePressed,
                      label: const Text('Add image'),
                    ),
                  ),
                ),
              };
      },
    );
  }
}

class _ImageFrame extends StatelessWidget {
  const _ImageFrame({required this.child, this.hideBorder = false});

  final Widget child;
  final bool hideBorder;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Container(
        decoration: hideBorder
            ? null
            : BoxDecoration(
                border: .all(color: context.colors.onSurface, width: 0.5),
                borderRadius: .circular(6),
              ),
        child: child,
      ),
    );
  }
}

class _PopUpMenu extends StatelessWidget {
  const _PopUpMenu();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return PopupMenuButton<_MenuAction>(
      onSelected: (value) => switch (value) {
        .edit => Navigator.push(
          context,
          PartEditorPage.route(
            part: context.read<PartDetailsBloc>().state.part,
          ),
        ),
        .deletePart => showModalBottomSheet<void>(
          context: context,
          builder: (_) => BlocProvider.value(
            value: context.read<PartDetailsBloc>(),
            child: DeletePartSheet(
              partId: context.read<PartDetailsBloc>().state.part.partId,
            ),
          ),
        ),
        _MenuAction.deleteImage => showModalBottomSheet<void>(
          context: context,
          builder: (_) => BlocProvider.value(
            value: context.read<PartDetailsBloc>(),
            child: DeleteImageSheet(
              part: context.read<PartDetailsBloc>().state.part,
            ),
          ),
        ),
      },
      itemBuilder: (_) {
        return [
          PopupMenuItem(
            value: _MenuAction.edit,
            child: Row(
              children: [
                const Icon(Icons.edit),
                const SizedBox(width: 16),
                Text(l10n.edit),
              ],
            ),
          ),
          const PopupMenuItem(
            value: _MenuAction.deleteImage,
            child: Row(
              children: [
                Icon(Icons.delete),
                SizedBox(width: 16),
                Text('Delete picture'),
              ],
            ),
          ),
          const PopupMenuDivider(),

          PopupMenuItem(
            value: _MenuAction.deletePart,
            child: Row(
              children: [
                Icon(Icons.block, color: context.colors.error),
                const SizedBox(width: 16),
                Text(
                  l10n.delete,
                  style: TextStyle(color: context.colors.error),
                ),
              ],
            ),
          ),
        ];
      },
    );
  }
}

TextStyle _variantTextStyle(BuildContext context) {
  return TextStyle(
    color: context.colors.onSurfaceVariant,
  );
}
