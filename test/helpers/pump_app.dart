import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inventory_app/l10n/l10n.dart';

extension PumpApp on WidgetTester {
  Future<void> pumpApp(
    Widget widget, {
    List<NavigatorObserver>? observers,
    List<RepositoryProvider<dynamic>>? providers,
  }) {
    Widget app = MaterialApp(
      navigatorObservers: observers ?? [],
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: widget,
    );

    if (providers != null && providers.isNotEmpty) {
      app = MultiRepositoryProvider(
        providers: providers,
        child: app,
      );
    }

    return pumpWidget(app);
  }
}
