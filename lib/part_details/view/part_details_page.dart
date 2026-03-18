import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/l10n/l10n.dart';
import 'package:inventory_app/part_details/bloc/part_details_bloc.dart';
import 'package:inventory_app/part_details/bloc/part_details_state.dart';
import 'package:inventory_app/part_details/utils/bone_mock_part_presentation.dart';
import 'package:inventory_app/part_details/widgets/part_details_in_stock.dart';
import 'package:inventory_app/part_details/widgets/part_details_info.dart';
import 'package:inventory_app/part_details/widgets/part_details_restock.dart';
import 'package:inventory_app/part_editor/view/part_editor_page.dart';
import 'package:inventory_app/use_cases/part_presentation.dart/watch_single_part_presentation.dart';
import 'package:part_repository/part_repository.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:stock_repository/stock_repository.dart';
import 'package:storage_repository/storage_repository.dart';

class PartDetailsPage extends StatelessWidget {
  const PartDetailsPage({required this.partId, super.key});

  final String partId;

  static MaterialPageRoute<void> route({
    required String partId,
  }) => MaterialPageRoute<void>(
    builder: (context) => PartDetailsPage(
      partId: partId,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PartDetailsBloc(
        partId: partId,
        watchSinglePartPresentation: context
            .read<WatchSinglePartPresentation>(),
        stockRepository: context.read<StockRepository>(),
        storageRepository: context.read<StorageRepository>(),
        partRepository: context.read<PartRepository>(),
      ),
      child: PartDetailsView(
        partId: partId,
      ),
    );
  }
}

class PartDetailsView extends StatelessWidget {
  const PartDetailsView({required this.partId, super.key});

  final String partId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: BlocBuilder<PartDetailsBloc, PartDetailsState>(
          buildWhen: (prev, curr) => prev.part != curr.part,
          builder: (context, state) {
            final title = state.part?.name ?? BoneMock.title;
            return Skeletonizer(enabled: state.isLoading, child: Text(title));
          },
        ),
        actions: [
          BlocBuilder<PartDetailsBloc, PartDetailsState>(
            buildWhen: (prev, curr) => prev.part != curr.part,
            builder: (context, state) {
              return Skeletonizer(
                enabled: state.isLoading,
                child: _DeleteButton(partId: partId),
              );
            },
          ),
          BlocBuilder<PartDetailsBloc, PartDetailsState>(
            buildWhen: (prev, curr) => prev.part != curr.part,
            builder: (context, state) {
              return Skeletonizer(
                enabled: state.isLoading,
                child: const _EditButton(),
              );
            },
          ),
        ],
      ),
      body: BlocListener<PartDetailsBloc, PartDetailsState>(
        listenWhen: (previous, current) => current.deleteStatus == .success,
        listener: (context, state) =>
            Navigator.of(context).popUntil((route) => route.isFirst),
        child: BlocBuilder<PartDetailsBloc, PartDetailsState>(
          builder: (context, state) {
            final part = state.part ?? boneMockPartPresentation;
            return Skeletonizer(
              enabled: state.isLoading,
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  const Skeleton.ignore(child: _SegmentedButton()),
                  const SizedBox(height: 24),
                  Expanded(
                    child: Padding(
                      padding: const .symmetric(
                        horizontal: 28,
                      ),
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 50),

                        child: switch (state.content) {
                          .details => PartDetailsInfo(
                            key: const ValueKey('details'),
                            part,
                          ),
                          .inStock => PartDetailsInStock(
                            key: const ValueKey('stock'),
                            part: part,
                          ),
                          .restock => const PartDetailsRestock(
                            key: ValueKey('restock'),
                          ),
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _EditButton extends StatelessWidget {
  const _EditButton();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => Navigator.push(
        context,
        PartEditorPage.route(
          part: context.read<PartDetailsBloc>().state.part,
        ),
      ),
      icon: const Icon(Icons.edit),
    );
  }
}

class _DeleteButton extends StatelessWidget {
  const _DeleteButton({required this.partId});

  final String partId;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return IconButton(
      onPressed: () => showModalBottomSheet<void>(
        context: context,
        builder: (_) => SafeArea(
          child: Padding(
            padding: const .all(24),
            child: Column(
              spacing: 20,
              mainAxisSize: .min,
              children: [
                Text(
                  l10n.deletePartSheetTitleText,
                  style: context.text.bodyLarge,
                ),
                Row(
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    AppButton.elevated(
                      width: .wrap,
                      onPressed: () => Navigator.pop(context),
                      label: l10n.cancel,
                    ),
                    AppButton(
                      width: .wrap,
                      onPressed: () => context.read<PartDetailsBloc>().add(
                        ConfirmDeleteButtonPressed(partId: partId),
                      ),
                      label: l10n.delete,
                      buttonStyle: ElevatedButton.styleFrom(
                        backgroundColor: context.colors.error,
                      ),
                      textStyle: context.text.bodyMedium?.copyWith(
                        color: context.colors.onError,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      icon: const Icon(
        Icons.delete,
      ),
    );
  }
}

class _SegmentedButton extends StatelessWidget {
  const _SegmentedButton();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return SegmentedButton<PartDetailsContent>(
      segments: [
        ButtonSegment<PartDetailsContent>(
          value: .details,
          label: Text(
            l10n.partDetailsSelectorDetails,
            style: context.text.bodySmall,
          ),
          icon: const Icon(Icons.list_alt),
        ),
        ButtonSegment<PartDetailsContent>(
          value: .inStock,
          label: Text(
            l10n.partDetailsSelectorInStock,
            style: context.text.bodySmall,
          ),
          icon: const Icon(Icons.search),
        ),
        ButtonSegment<PartDetailsContent>(
          value: .restock,
          label: Center(
            child: Text(
              l10n.partDetailsSelectorRestock,
              style: context.text.bodySmall,
            ),
          ),
          icon: const Icon(Icons.shelves),
        ),
      ],
      selected: {context.watch<PartDetailsBloc>().state.content},
      onSelectionChanged: (selection) => context.read<PartDetailsBloc>().add(
        ButtonSegmentPressed(
          content: selection.first,
        ),
      ),
    );
  }
}
