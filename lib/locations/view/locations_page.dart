import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/locations/bloc/locations_bloc.dart';
import 'package:inventory_app/locations/bloc/locations_state.dart';
import 'package:location_repository/location_repository.dart';

class LocationsPage extends StatelessWidget {
  const LocationsPage({super.key});

  static MaterialPageRoute<void> route() =>
      MaterialPageRoute(builder: (context) => const LocationsPage());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          LocationsBloc(locationRepository: context.read<LocationRepository>()),
      child: const LocationsView(),
    );
  }
}

class LocationsView extends StatelessWidget {
  const LocationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('New storage'),
        icon: const Icon(Icons.add),
        onPressed: () {},
      ),
      appBar: AppBar(),
      body: BlocBuilder<LocationsBloc, LocationsState>(
        builder: (context, state) {
          final locations = state.locations;
          return switch (state.status) {
            .loading => const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
            .loaded =>
              locations.isEmpty
                  ? const Center(
                      child: Text('No storages added yet'),
                    )
                  : ListView.builder(
                      itemCount: state.locations.length,
                      itemBuilder: (context, index) {
                        final location = state.locations[index];
                        return Card(
                          child: ListTile(title: Text(location.name)),
                        );
                      },
                    ),
          };
        },
      ),
    );
  }
}
