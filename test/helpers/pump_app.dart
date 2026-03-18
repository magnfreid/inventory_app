import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inventory_app/l10n/l10n.dart';

extension PumpApp on WidgetTester {
  Future<void> pumpApp(
    Widget widget, {
    List<NavigatorObserver>? observers,
    List<RepositoryProvider<dynamic>>? repositoryProviders,
    RouteFactory? onGenerateRoute,
  }) {
    Widget app = MaterialApp(
      navigatorObservers: observers ?? [],
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: widget,
      onGenerateRoute: onGenerateRoute,
    );

    if (repositoryProviders != null && repositoryProviders.isNotEmpty) {
      app = MultiRepositoryProvider(
        providers: repositoryProviders,
        child: app,
      );
    }

    return pumpWidget(app);
  }
}
