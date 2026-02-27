import 'package:flutter/material.dart';

class InventoryToolBar extends StatelessWidget {
  const InventoryToolBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: .center,
        mainAxisSize: .min,
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.arrow_downward),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.filter_list),
          ),
        ],
      ),
    );
  }
}
