import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/part_details/bloc/part_details_bloc.dart';
import 'package:inventory_app/part_details/bloc/part_details_state.dart';
import 'package:inventory_app/part_details/widgets/part_details_info.dart';
import 'package:inventory_app/part_editor/view/part_editor_page.dart';
import 'package:inventory_app/use_cases/part_presentation.dart/models/part_presentation.dart';
import 'package:inventory_app/use_cases/watch_single_part_presentation/watch_single_part_presentation.dart';

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
        title: BlocBuilder<PartDetailsBloc, PartDetailsState>(
          builder: (context, state) {
            final part = state.part;
            final title = part == null ? '' : part.name;
            return Text(title);
          },
        ),
        actions: [
          IconButton(
            onPressed: () =>
                Navigator.push(context, PartEditorPage.route(part: part)),
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
      body: BlocBuilder<PartDetailsBloc, PartDetailsState>(
        builder: (context, state) {
          final part = state.part;
          return part == null
              ? const Center(
                  child: Text('Loading...'),
                )
              : Column(
                  children: [
                    const SizedBox(height: 20),
                    PartDetailsInfo(part),
                  ],
                );
        },
      ),
    );
  }
}
