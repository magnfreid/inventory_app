import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/inventory/view/inventory_page.dart';
import 'package:inventory_app/inventory/view/inventory_page.dart';
import 'package:inventory_app/statistics/view/statistics_page.dart';
import 'package:inventory_app/storages/view/storages_page.dart';
import 'package:inventory_repository/inventory_repository.dart';
import 'package:location_repository/location_repository.dart';
import 'package:product_repository/product_repository.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const InventoryPage();
  }
}

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
