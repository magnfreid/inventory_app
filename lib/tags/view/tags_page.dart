import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/tags/bloc/tags_bloc.dart';
import 'package:inventory_app/tags/bloc/tags_state.dart';
import 'package:inventory_app/tags/widgets/tags_bottom_sheet.dart';
import 'package:tag_repository/tag_repository.dart';

class TagsPage extends StatelessWidget {
  const TagsPage({super.key});

  static MaterialPageRoute<TagsPage> route() =>
      MaterialPageRoute(builder: (context) => const TagsPage());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          TagsBloc(tagRepository: context.read<TagRepository>()),
      child: const TagsView(),
    );
  }
}

class TagsView extends StatelessWidget {
  const TagsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your tags')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showModalBottomSheet<void>(
          context: context,
          builder: (_) => BlocProvider.value(
            value: context.read<TagsBloc>(),
            child: const TagsBottomSheet(),
          ),
        ),
        label: const Text('New tag'),
        icon: const Icon(Icons.add),
      ),
      body: BlocBuilder<TagsBloc, TagsState>(
        builder: (context, state) {
          final tags = state.tags;
          return tags.isEmpty
              ? const Center(child: Text('No tags added yet!'))
              : Expanded(
                  child: ListView.builder(
                    itemCount: tags.length,
                    itemBuilder: (context, index) => Text(tags[index].label),
                  ),
                );
        },
      ),
    );
  }
}
