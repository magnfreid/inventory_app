import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/l10n/l10n.dart';
import 'package:inventory_app/storages/bloc/storages_bloc.dart';
import 'package:inventory_app/storages/bloc/storages_state.dart';
import 'package:inventory_app/storages_editor/view/storages_editor_page.dart';
import 'package:storage_repository/storage_repository.dart';

class StoragesPage extends StatelessWidget {
  const StoragesPage({super.key});

  static MaterialPageRoute<void> route() =>
      MaterialPageRoute(builder: (context) => const StoragesPage());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          StoragesBloc(storageRepository: context.read<StorageRepository>()),
      child: const StoragesView(),
    );
  }
}

class StoragesView extends StatelessWidget {
  const StoragesView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.storagePageTitle),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text(l10n.addStorageFabLabelText),
        icon: const Icon(Icons.add),
        onPressed: () => showModalBottomSheet<void>(
          showDragHandle: true,
          context: context,
          builder: (context) => const StoragesEditorPage(),
        ),
      ),

      body: BlocBuilder<StoragesBloc, StoragesState>(
        builder: (context, state) {
          final storages = state.storages;
          return switch (state.status) {
            .loading => const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
            .loaded =>
              storages.isEmpty
                  ? const Center(
                      child: Text('No storages added yet'),
                    )
                  : ListView.builder(
                      itemCount: state.storages.length,
                      itemBuilder: (context, index) {
                        final storage = state.storages[index];
                        return Card(
                          child: ListTile(title: Text(storage.name)),
                        );
                      },
                    ),
          };
        },
      ),
    );
  }
}
