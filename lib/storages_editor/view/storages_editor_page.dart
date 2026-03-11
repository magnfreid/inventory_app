import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/l10n/l10n.dart';
import 'package:inventory_app/storages_editor/bloc/storages_editor_bloc.dart';
import 'package:inventory_app/storages_editor/bloc/storages_editor_state.dart';
import 'package:storage_repository/storage_repository.dart';

class StoragesEditorPage extends StatelessWidget {
  const StoragesEditorPage({this.storage, super.key});

  final Storage? storage;

  static MaterialPageRoute<void> route({Storage? storage}) =>
      MaterialPageRoute(builder: (_) => StoragesEditorPage(storage: storage));

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StoragesEditorBloc(
        storageRepository: context.read<StorageRepository>(),
      ),
      child: StoragesEditorView(
        storage: storage,
      ),
    );
  }
}

class StoragesEditorView extends StatefulWidget {
  const StoragesEditorView({this.storage, super.key});

  final Storage? storage;

  @override
  State<StoragesEditorView> createState() => _StoragesEditorViewState();
}

class _StoragesEditorViewState extends State<StoragesEditorView> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _nameTextController;
  late final TextEditingController _descriptionTextController;
  bool canSave = false;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _nameTextController = TextEditingController(text: widget.storage?.name);
    _descriptionTextController = TextEditingController(
      text: widget.storage?.description,
    );
    super.initState();
  }

  @override
  void dispose() {
    _nameTextController.dispose();
    _descriptionTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocListener<StoragesEditorBloc, StoragesEditorState>(
      listenWhen: (previous, current) => current.isSuccess,
      listener: (context, state) => Navigator.of(context).pop(),
      child: Scaffold(
        appBar: AppBar(
          title: widget.storage == null
              ? Text(l10n.addStorageBottomSheetTitle)
              : Text(widget.storage!.name),
        ),
        body: SafeArea(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
              child: Column(
                spacing: 10,
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      label: Text(l10n.formFieldNameLabelText),
                    ),
                    controller: _nameTextController,
                    autovalidateMode: .onUserInteraction,
                    validator: (value) => value == null || value.isEmpty
                        ? l10n.validationRequired
                        : null,
                    onChanged: (value) => setState(() {
                      canSave = value.isNotEmpty;
                    }),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      label: Text(l10n.formFieldDescriptionLabelText),
                    ),
                    controller: _descriptionTextController,
                    onChanged: (value) => setState(() {
                      canSave = _nameTextController.text.isNotEmpty;
                    }),
                    minLines: 3,
                    maxLines: 5,
                    maxLength: 120,
                  ),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    child: BlocBuilder<StoragesEditorBloc, StoragesEditorState>(
                      builder: (context, state) {
                        return AppButton(
                          isLoading: state.isLoading,
                          onPressed: canSave
                              ? () {
                                  final storage = Storage(
                                    name: _nameTextController.text,
                                    description:
                                        _descriptionTextController.text == ''
                                        ? null
                                        : _descriptionTextController.text,
                                    id: widget.storage?.id,
                                  );
                                  context.read<StoragesEditorBloc>().add(
                                    SaveButtonPressed(storage: storage),
                                  );
                                }
                              : null,
                          label: l10n.formSaveButtonText,
                        );
                      },
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
