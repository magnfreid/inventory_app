import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/part_details/bloc/part_details_bloc.dart';
import 'package:inventory_app/part_details/bloc/part_details_state.dart';
import 'package:inventory_app/part_details/widgets/part_details_in_stock.dart';
import 'package:inventory_app/part_details/widgets/part_details_info.dart';
import 'package:inventory_app/part_details/widgets/part_details_restock.dart';
import 'package:inventory_app/part_editor/view/part_editor_page.dart';
import 'package:inventory_app/use_cases/part_presentation.dart/models/part_presentation.dart';
import 'package:inventory_app/use_cases/watch_single_part_presentation/watch_single_part_presentation.dart';
import 'package:stock_repository/stock_repository.dart';
import 'package:storage_repository/storage_repository.dart';

class PartDetailsPage extends StatelessWidget {
  const PartDetailsPage({required this.part, super.key});

  final PartPresentation part;

  static MaterialPageRoute<void> route({
    required PartPresentation item,
  }) => MaterialPageRoute<void>(
    builder: (context) => PartDetailsPage(
      part: item,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PartDetailsBloc(
        partId: part.partId,
        watchSinglePartPresentation: context
            .read<WatchSinglePartPresentation>(),
        stockRepository: context.read<StockRepository>(),
        storageRepository: context.read<StorageRepository>(),
      ),
      child: PartDetailsView(part: part),
    );
  }
}

class PartDetailsView extends StatelessWidget {
  const PartDetailsView({required this.part, super.key});

  final PartPresentation part;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: BlocBuilder<PartDetailsBloc, PartDetailsState>(
          builder: (context, state) {
            final part = state.part;
            final title = part == null ? '' : part.name;
            return Text(title);
          },
        ),
        actions: [
          IconButton(
            //TODO(magnfreid): Add delete dialog
            onPressed: () => {},
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
          IconButton(
            onPressed: () => Navigator.push(
              context,
              PartEditorPage.route(part: part),
            ),
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
      body: BlocBuilder<PartDetailsBloc, PartDetailsState>(
        builder: (context, state) {
          final part = state.part;
          return part == null
              ? const Center(
                  child: CircularProgressIndicator.adaptive(),
                )
              : Padding(
                  padding: const .symmetric(vertical: 16, horizontal: 32),
                  child: Column(
                    children: [
                      const _SegmentedButton(),
                      const SizedBox(height: 20),
                      Expanded(
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 200),
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
                    ],
                  ),
                );
        },
      ),
    );
  }
}

class _SegmentedButton extends StatelessWidget {
  const _SegmentedButton();

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<PartDetailsContent>(
      segments: const [
        ButtonSegment<PartDetailsContent>(
          value: .details,
          label: Text('Detaljer'),
          icon: Icon(Icons.list_alt),
        ),
        ButtonSegment<PartDetailsContent>(
          value: .inStock,
          label: Text('I lager'),
          icon: Icon(Icons.search),
        ),
        ButtonSegment<PartDetailsContent>(
          value: .restock,
          label: Center(child: Text('Fyll på')),
          icon: Icon(Icons.shelves),
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
