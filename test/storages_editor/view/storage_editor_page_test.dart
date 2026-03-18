import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inventory_app/l10n/l10n.dart';
import 'package:inventory_app/storages_editor/bloc/storages_editor_bloc.dart';
import 'package:inventory_app/storages_editor/bloc/storages_editor_state.dart';
import 'package:inventory_app/storages_editor/view/storages_editor_page.dart';
import 'package:mocktail/mocktail.dart';
import 'package:storage_repository/storage_repository.dart';

import '../../helpers/helpers.dart';

class FakeSaveButtonPressed extends Fake implements SaveButtonPressed {}

void main() {
  late StoragesEditorBloc bloc;
  late Storage storage;

  setUp(() {
    bloc = MockStorageEditorBloc();
    storage = Storage(
      id: '123',
      name: 'Storage name',
      description: 'Storage description',
    );
  });

  setUpAll(() {
    registerFallbackValue(FakeSaveButtonPressed());
  });

  Widget storagesEditorViewWithStorage() => BlocProvider.value(
    value: bloc,
    child: StoragesEditorView(storage: storage),
  );

  Widget storagesEditorViewWithOutStorage() => BlocProvider.value(
    value: bloc,
    child: const StoragesEditorView(),
  );

  group('StoragesEditorPage', () {
    testWidgets('renders widgets when editing an existing storage', (
      tester,
    ) async {
      when(() => bloc.state).thenAnswer((_) => const StoragesEditorState());

      await tester.pumpApp(storagesEditorViewWithStorage());

      final context = tester.element(find.byType(Scaffold));
      final l10n = context.l10n;

      expect(find.text(storage.name), findsExactly(2));
      expect(find.text(storage.description ?? ''), findsExactly(1));
      expect(find.text(l10n.formFieldNameLabelText), findsOne);
      expect(find.text(l10n.formFieldDescriptionLabelText), findsOne);
      expect(find.byType(TextFormField), findsExactly(2));
      expect(find.byType(AppButton), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });

    testWidgets('renders widgets when editing a new storage', (
      tester,
    ) async {
      when(() => bloc.state).thenAnswer((_) => const StoragesEditorState());

      await tester.pumpApp(storagesEditorViewWithOutStorage());

      final context = tester.element(find.byType(Scaffold));
      final l10n = context.l10n;

      expect(find.text(l10n.formFieldNameLabelText), findsOne);
      expect(find.text(l10n.formFieldDescriptionLabelText), findsOne);
      expect(find.byType(TextFormField), findsExactly(2));
      expect(find.byType(AppButton), findsOneWidget);
      expect(find.text(storage.name), findsNothing);
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });

    testWidgets('renders loading spinner in button when loading', (
      tester,
    ) async {
      when(
        () => bloc.state,
      ).thenAnswer((_) => const StoragesEditorState(status: .loading));

      await tester.pumpApp(storagesEditorViewWithOutStorage());

      expect(find.byType(CircularProgressIndicator), findsOne);
    });

    testWidgets('tapping save button triggers SaveButtonPressed', (
      tester,
    ) async {
      when(
        () => bloc.state,
      ).thenAnswer((_) => const StoragesEditorState());

      await tester.pumpApp(storagesEditorViewWithOutStorage());
      await tester.enterText(find.byType(TextFormField).first, 'Test Storage');

      final button = find.byType(AppButton);
      expect(button, findsOneWidget);
      await tester.pump();

      await tester.tap(button);
      await tester.pump();
      verify(() => bloc.add(any(that: isA<SaveButtonPressed>()))).called(1);
    });
  });
}
