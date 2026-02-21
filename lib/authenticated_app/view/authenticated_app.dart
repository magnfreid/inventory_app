import 'package:firebase_inventory_repository/firebase_inventory_repository.dart';
import 'package:firebase_location_repository/firebase_location_repository.dart';
import 'package:firebase_product_repository/firebase_product_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/authenticated_app/cubit/user_cubit.dart';
import 'package:inventory_app/authenticated_app/cubit/user_state.dart';
import 'package:inventory_app/inventory/view/inventory_page.dart';
import 'package:inventory_app/inventory/view/inventory_page.dart';
import 'package:inventory_app/statistics/view/statistics_page.dart';
import 'package:inventory_app/storages/view/storages_page.dart';
import 'package:inventory_repository/inventory_repository.dart';
import 'package:location_repository/location_repository.dart';
import 'package:product_repository/product_repository.dart';
import 'package:user_repository/user_repository.dart';

class AuthenticatedApp extends StatelessWidget {
  const AuthenticatedApp({required this.currentUserId, super.key});

  final String currentUserId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UserCubit(
        userRepository: context.read<UserRepository>(),
        currentUserId: currentUserId,
      ),
      child: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) => state.when(
          loading: () =>
              const Center(child: CircularProgressIndicator.adaptive()),

          error: (error) => Text(error.toString()),
          loaded: (currentUser) => MultiRepositoryProvider(
            providers: [
              RepositoryProvider<InventoryRepository>(
                create: (_) => FirebaseInventoryRepository(
                  organizationId: currentUser.organizationId,
                ),
              ),
              RepositoryProvider<LocationRepository>(
                create: (_) => FirebaseLocationRepository(
                  organizationId: currentUser.organizationId,
                ),
              ),
              RepositoryProvider<ProductRepository>(
                create: (_) => FirebaseProductRepository(
                  organizationId: currentUser.organizationId,
                ),
              ),
            ],
            child: const InventoryPage(),
          ),
        ),
      ),
    );
  }
}

// class AuthenticatedAppBootstrap extends StatelessWidget {
//   const AuthenticatedAppBootstrap({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return
//   }
// }

// class HomeView extends StatefulWidget {
//   const HomeView({super.key});

//   List<Widget> get pages => const [
//     InventoryPage(),
//     InventoryPage(),
//     StoragesPage(),
//     StatisticsPage(),
//   ];

//   List<NavigationDestination> get tabs => const [
//     NavigationDestination(
//       icon: Icon(Icons.list),
//       label: 'Inventory',
//     ),
//     NavigationDestination(
//       icon: Icon(Icons.newspaper),
//       label: 'Catalogue',
//     ),
//     NavigationDestination(
//       icon: Icon(Icons.house),
//       label: 'Storages',
//     ),
//     NavigationDestination(
//       icon: Icon(Icons.star),
//       label: 'Statistics',
//     ),
//   ];

//   @override
//   State<HomeView> createState() => _HomeViewState();
// }

// class _HomeViewState extends State<HomeView> {
//   int _selectedIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       bottomNavigationBar: NavigationBar(
//         destinations: widget.tabs,
//         selectedIndex: _selectedIndex,
//         onDestinationSelected: (index) => setState(() {
//           _selectedIndex = index;
//         }),
//       ),
//       body: IndexedStack(
//         index: _selectedIndex,
//         children: widget.pages,
//       ),
//     );
//   }
// }
