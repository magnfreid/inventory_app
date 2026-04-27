import 'dart:async';

import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/l10n/l10n.dart';
import 'package:inventory_app/shared/extensions/list_sorting_extension.dart';
import 'package:inventory_app/shared/extensions/show_snack_bar_extensions.dart';
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
        onPressed: () => Navigator.push(context, StoragesEditorPage.route()),
      ),
      body: BlocListener<StoragesBloc, StoragesState>(
        listenWhen: (previous, current) => previous.error != current.error,
        listener: (context, state) {
          final error = state.error;
          if (error != null) context.showErrorSnackBar(error);
        },
        child: BlocBuilder<StoragesBloc, StoragesState>(
          builder: (context, state) {
            final storages = state.storages;
            return switch (state.status) {
              .loading => const Center(
                child: CircularProgressIndicator.adaptive(),
              ),
              .loaded => storages.isEmpty
                  ? Center(child: Text(l10n.storage))
                  : _StorageList(
                      storages: storages.sortedByName(),
                    ),
            };
          },
        ),
      ),
    );
  }
}

/// Scrollable list of [StorageCard] items with consistent spacing.
class _StorageList extends StatelessWidget {
  const _StorageList({required this.storages});

  final List<Storage> storages;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const .all(16),
      itemCount: storages.length,
      separatorBuilder: (_, _) => const SizedBox(height: 8),
      itemBuilder: (_, index) =>
          StorageCard(storage: storages[index]),
    );
  }
}

/// A single storage card with a left accent border, the storage
/// name, an optional description, and edit / delete actions.
class StorageCard extends StatelessWidget {
  /// Creates a [StorageCard] for the given [storage].
  const StorageCard({required this.storage, super.key});

  final Storage storage;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final hasDescription =
        storage.description != null && storage.description!.isNotEmpty;

    return Card(
      clipBehavior: .hardEdge,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(
              color: context.colors.primary,
              width: 2,
            ),
          ),
        ),
        padding: const .symmetric(
          horizontal: 12,
          vertical: 10,
        ),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    storage.name,
                    style: context.text.bodyLarge,
                  ),
                ),
                _ActionButton(
                  icon: Icons.edit_outlined,
                  onPressed: () => Navigator.push(
                    context,
                    StoragesEditorPage.route(storage: storage),
                  ),
                ),
                _ActionButton(
                  icon: Icons.delete_outline,
                  onPressed: () => showModalBottomSheet<void>(
                    context: context,
                    builder: (_) => BlocProvider.value(
                      value: context.read<StoragesBloc>(),
                      child: _DeleteStorageBottomSheet(
                        storageName: storage.name,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            if (hasDescription)
              Padding(
                padding: const .only(top: 4),
                child: Text(
                  storage.description!,
                  style: context.text.bodyMedium?.copyWith(
                    color: context.colors.onSurfaceVariant,
                  ),
                ),
              )
            else
              Padding(
                padding: const .only(top: 4),
                child: Text(
                  l10n.storageNoDescriptionText,
                  style: context.text.bodySmall?.copyWith(
                    color: context.colors.onSurfaceVariant,
                    fontStyle: .italic,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// Compact icon button used for storage card actions.
class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.icon,
    required this.onPressed,
  });

  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon, size: 20),
      onPressed: onPressed,
      visualDensity: .compact,
      padding: .zero,
      constraints: const BoxConstraints(
        minWidth: 32,
        minHeight: 32,
      ),
    );
  }
}

class _DeleteStorageBottomSheet extends StatefulWidget {
  const _DeleteStorageBottomSheet({required this.storageName});

  final String storageName;

  @override
  State<_DeleteStorageBottomSheet> createState() =>
      _DeleteStorageBottomSheetState();
}

class _DeleteStorageBottomSheetState extends State<_DeleteStorageBottomSheet> {
  late Timer? _timer;
  int _seconds = 5;
  bool get deleteIsBlocked => _seconds > 0;

  @override
  void initState() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() => _seconds--);
      if (_seconds <= 0) timer.cancel();
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _timer = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return SafeArea(
      child: Padding(
        padding: const .all(24),
        child: Column(
          spacing: 30,
          mainAxisSize: .min,
          crossAxisAlignment: .start,
          children: [
            Text(
              '${l10n.deleteStorageConfirmationTitle} ${widget.storageName}?',
              style: context.text.bodyLarge?.copyWith(fontWeight: .bold),
            ),
            Container(
              decoration: BoxDecoration(
                color: context.colors.secondaryContainer,
                borderRadius: .circular(8),
                border: Border.all(
                  color: context.colors.error.withValues(alpha: 0.4),
                  width: 0.5,
                ),
              ),
              padding: const .all(12),
              child: Row(
                children: [
                  const Icon(
                    Icons.warning_amber_rounded,
                    color: Colors.amber,
                    size: 28,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      l10n.deleteStorageConfirmationWarning,
                      style: context.text.bodyMedium?.copyWith(
                        fontStyle: .italic,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                AppButton.elevated(
                  onPressed: () => Navigator.pop(context),
                  label: l10n.cancel,
                ),
                SizedBox(
                  width: 100,
                  child: AppButton(
                    width: .wide,
                    onPressed: deleteIsBlocked ? null : () {},
                    label: deleteIsBlocked ? _seconds.toString() : l10n.delete,
                    textStyle: deleteIsBlocked
                        ? null
                        : context.text.bodyMedium?.copyWith(
                            color: context.colors.onError,
                          ),
                    buttonStyle: deleteIsBlocked
                        ? null
                        : FilledButton.styleFrom(
                            backgroundColor: context.colors.error,
                          ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
