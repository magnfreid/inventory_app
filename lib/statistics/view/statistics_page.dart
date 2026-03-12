import 'package:flutter/material.dart';
import 'package:inventory_app/l10n/l10n.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({super.key});

  static MaterialPageRoute<void> route() =>
      MaterialPageRoute(builder: (context) => const StatisticsPage());

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(),
      body: Placeholder(
        child: Center(
          child: Text(l10n.workInProgress),
        ),
      ),
    );
  }
}
