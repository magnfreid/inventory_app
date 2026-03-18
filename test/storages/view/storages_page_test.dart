import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inventory_app/l10n/l10n.dart';
import 'package:inventory_app/storages/bloc/storages_bloc.dart';
import 'package:inventory_app/storages/bloc/storages_state.dart';
import 'package:inventory_app/storages/view/storages_page.dart';
import 'package:mocktail/mocktail.dart';
import 'package:storage_repository/storage_repository.dart';

import '../../helpers/mocks.dart';
import '../../helpers/pump_app.dart';

void main() {
  late StoragesBloc bloc;
  late Storage storage;

  setUp(() {
    bloc = MockStoragesBloc();
    storage = Storage(id: '123', name: 'Storage', description: 'description');

    when(() => bloc.state).thenAnswer((_) => const StoragesState());
  });

  setUpAll(() {
    registerFallbackValue(FakeRoute());
  });

  Widget storagesView() {
    return BlocProvider.value(
      value: bloc,
      child: const StoragesView(),
    );
  }

  group('StoragesPage', () {
    testWidgets('Renders all widgets when loading', (tester) async {
      when(() => bloc.state).thenAnswer((_) => const StoragesState());

      await tester.pumpApp(storagesView());

      final context = tester.element(find.byType(Scaffold));
      final l10n = context.l10n;

      expect(find.byType(AppBar), findsOneWidget);
      expect(find.text(l10n.storagePageTitle), findsOne);

      expect(find.byType(FloatingActionButton), findsOneWidget);
      expect(find.text(l10n.addStorageFabLabelText), findsOne);

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('Renders all widgets when loaded', (tester) async {
      when(() => bloc.state).thenAnswer(
        (_) => StoragesState(status: .loaded, storages: [storage]),
      );

      await tester.pumpApp(storagesView());

      final context = tester.element(find.byType(Scaffold));
      final l10n = context.l10n;

      expect(find.byType(AppBar), findsOneWidget);
      expect(find.text(l10n.storagePageTitle), findsOne);

      expect(find.byType(FloatingActionButton), findsOneWidget);
      expect(find.text(l10n.addStorageFabLabelText), findsOne);

      expect(find.byType(ExpansionPanelList), findsOneWidget);
      expect(find.text(storage.name), findsOne);
      expect(
        find.text(storage.description ?? l10n.storageNoDescriptionText),
        findsOne,
      );
      expect(find.byIcon(Icons.delete), findsOneWidget);
      expect(find.byIcon(Icons.edit), findsOneWidget);

      expect(find.byType(CircularProgressIndicator), findsNothing);
    });

    testWidgets('Renders StoragesEditorPage when FAB is pressed', (
      tester,
    ) async {
      final observer = MockNavigatorObserver();
      final storageRepo = MockStorageRepository();
      when(() => bloc.state).thenAnswer(
        (_) => StoragesState(status: .loaded, storages: [storage]),
      );

      await tester.pumpApp(
        observers: [observer],
        providers: [
          RepositoryProvider<StorageRepository>.value(value: storageRepo),
        ],
        storagesView(),
      );

      final fab = find.byType(FloatingActionButton);
      await tester.tap(fab);
      await tester.pump();

      verify(() => observer.didPush(any(), any())).called(2);
    });

    testWidgets(
      'Renders StoragesEditorPage when panel is opened and edit button'
      ' is pressed',
      (
        tester,
      ) async {
        final observer = MockNavigatorObserver();
        final storageRepo = MockStorageRepository();

        when(() => bloc.state).thenAnswer(
          (_) => StoragesState(status: .loaded, storages: [storage]),
        );

        await tester.pumpApp(
          observers: [observer],
          providers: [
            RepositoryProvider<StorageRepository>.value(value: storageRepo),
          ],
          storagesView(),
        );

        final expansionPanel = find.text(storage.name);
        await tester.tap(expansionPanel);
        await tester.pumpAndSettle();

        final editButton = find.byIcon(Icons.edit);
        await tester.tap(editButton);
        await tester.pump();

        verify(() => observer.didPush(any(), any())).called(2);
      },
    );

    testWidgets(
      'Renders bottom sheet when panel is opened and delete button'
      ' is pressed',
      (
        tester,
      ) async {
        final observer = MockNavigatorObserver();
        final storageRepo = MockStorageRepository();

        when(() => bloc.state).thenAnswer(
          (_) => StoragesState(status: .loaded, storages: [storage]),
        );

        await tester.pumpApp(
          observers: [observer],
          providers: [
            RepositoryProvider<StorageRepository>.value(value: storageRepo),
          ],
          storagesView(),
        );

        final expansionPanel = find.text(storage.name);
        await tester.tap(expansionPanel);
        await tester.pumpAndSettle();

        final deleteButton = find.byIcon(Icons.delete);
        await tester.tap(deleteButton);
        await tester.pumpAndSettle();

        final context = tester.element(find.byType(Scaffold));
        final l10n = context.l10n;

        expect(find.text(l10n.deleteStorageConfirmationWarning), findsOne);
      },
    );
  });
}
