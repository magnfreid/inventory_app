import 'package:flutter/material.dart';

class StoragesPage extends StatelessWidget {
  const StoragesPage({super.key});

  static MaterialPageRoute<void> route() =>
      MaterialPageRoute(builder: (context) => const StoragesPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Placeholder(
        child: Center(
          child: Text('Storages Page'),
        ),
      ),
    );
  }
}

class StoragesView extends StatelessWidget {
  const StoragesView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
