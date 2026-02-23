import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/locations_editor/bloc/locations_editor_bloc.dart';
import 'package:inventory_app/locations_editor/bloc/locations_editor_state.dart';
import 'package:location_repository/location_repository.dart';

class LocationsEditorPage extends StatelessWidget {
  const LocationsEditorPage({this.location, super.key});

  final Location? location;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LocationsEditorBloc(
        locationRepository: context.read<LocationRepository>(),
      ),
      child: const LocationsEditorView(),
    );
  }
}

class LocationsEditorView extends StatefulWidget {
  const LocationsEditorView({super.key});

  @override
  State<LocationsEditorView> createState() => _LocationsEditorViewState();
}

class _LocationsEditorViewState extends State<LocationsEditorView> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _nameTextController;
  late final TextEditingController _descriptionTextController;
  bool canSave = false;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _nameTextController = TextEditingController();
    _descriptionTextController = TextEditingController();
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
    return BlocListener<LocationsEditorBloc, LocationsEditorState>(
      listenWhen: (previous, current) => current.isSuccess,
      listener: (context, state) => Navigator.of(context).pop(),
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
          child: Column(
            children: [
              const Text('Add new storage'),
              TextFormField(
                decoration: const InputDecoration(label: Text('Name:')),
                controller: _nameTextController,
                autovalidateMode: .always,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Required' : null,
                onChanged: (value) => setState(() {
                  canSave = value.isNotEmpty;
                }),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  label: Text('Description'),
                ),
                controller: _descriptionTextController,
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: canSave
                      ? () {
                          final location = LocationCreateModel(
                            name: _nameTextController.text,
                            description: _descriptionTextController.text == ''
                                ? null
                                : _descriptionTextController.text,
                          );
                          context.read<LocationsEditorBloc>().add(
                            SaveButtonPressed(createModel: location),
                          );
                        }
                      : null,
                  child: BlocBuilder<LocationsEditorBloc, LocationsEditorState>(
                    builder: (context, state) {
                      return state.isLoading
                          ? const SizedBox(
                              height: 24,
                              width: 24,
                              child: CircularProgressIndicator.adaptive(),
                            )
                          : const Text('Save');
                    },
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
