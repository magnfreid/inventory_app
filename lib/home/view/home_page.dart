import 'package:flutter/material.dart';
import 'package:inventory_app/products/view/products_page.dart';
import 'package:inventory_app/inventory/view/inventory_page.dart';
import 'package:inventory_app/statistics/view/statistics_page.dart';
import 'package:inventory_app/storages/view/storages_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  List<Widget> get pages => const [
    InventoryPage(),
    ProductsPage(),
    StoragesPage(),
    StatisticsPage(),
  ];

  List<NavigationDestination> get tabs => const [
    NavigationDestination(
      icon: Icon(Icons.list),
      label: 'Inventory',
    ),
    NavigationDestination(
      icon: Icon(Icons.newspaper),
      label: 'Catalogue',
    ),
    NavigationDestination(
      icon: Icon(Icons.house),
      label: 'Storages',
    ),
    NavigationDestination(
      icon: Icon(Icons.star),
      label: 'Statistics',
    ),
  ];

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        destinations: widget.tabs,
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) => setState(() {
          _selectedIndex = index;
        }),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: widget.pages,
      ),
    );
  }
}
