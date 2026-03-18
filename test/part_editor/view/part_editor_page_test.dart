import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inventory_app/l10n/l10n.dart';
import 'package:inventory_app/part_editor/bloc/part_editor_bloc.dart';
import 'package:inventory_app/part_editor/bloc/part_editor_state.dart';
import 'package:inventory_app/part_editor/view/part_editor_page.dart';
import 'package:inventory_app/tags/models/tag_presentation.dart';
import 'package:inventory_app/use_cases/part_presentation.dart/models/part_presentation.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/helpers.dart';

void main() {
  late PartPresentation part;
  late PartEditorBloc bloc;

  setUp(() {
    part = PartPresentation(
      partId: '123',
      name: 'Part name',
      detailNumber: 'part detail number',
      price: 10,
      isRecycled: true,
      description: 'part description',
      brandTag: TagPresentation(
        id: '123',
        label: 'Brand tag',
        color: Colors.blue,
        type: .brand,
      ),
    );

    bloc = MockPartEditorBloc();
  });

  Widget partEditorViewWithPart() => BlocProvider.value(
    value: bloc,
    child: PartEditorView(part: part),
  );

  Widget partEditorViewWithOutPart() => BlocProvider.value(
    value: bloc,
    child: const PartEditorView(),
  );

  group('PartEditorPage', () {
    testWidgets('renders widgets when part is provided', (tester) async {
      when(() => bloc.state).thenAnswer((_) => const PartEditorState());

      await tester.pumpApp(partEditorViewWithPart());

      final context = tester.element(find.byType(Scaffold));
      final l10n = context.l10n;

      expect(find.byType(AppBar), findsOneWidget);
      expect(find.text(part.name), findsExactly(2));
      expect(find.text(part.detailNumber), findsOne);
      expect(find.text(part.price.toString()), findsOne);
      expect(find.text(part.description ?? ''), findsOne);
      expect(find.text('${l10n.formFieldNameLabelText}*'), findsOne);
      expect(find.text('${l10n.formFieldPriceLabelText}*'), findsOne);
      expect(find.text(l10n.formFieldDetailNumberLabelText), findsOne);
      expect(find.text(l10n.formFieldDescriptionLabelText), findsOne);
      expect(find.byType(TextFormField), findsExactly(4));
      expect(find.byType(SegmentedButton<bool>), findsOneWidget);
      expect(find.byType(TextButton), findsExactly(3));
      expect(find.byType(InputChip), findsOneWidget);
      expect(find.byType(AppButton), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });

    testWidgets('renders widgets when part is not provided', (tester) async {
      when(() => bloc.state).thenAnswer((_) => const PartEditorState());

      await tester.pumpApp(partEditorViewWithOutPart());

      final context = tester.element(find.byType(Scaffold));
      final l10n = context.l10n;

      expect(find.byType(AppBar), findsOneWidget);
      expect(find.text(part.name), findsNothing);
      expect(find.text(part.detailNumber), findsNothing);
      expect(find.text(part.price.toString()), findsNothing);
      expect(find.text(part.description ?? ''), findsNothing);
      expect(find.text('${l10n.formFieldNameLabelText}*'), findsOne);
      expect(find.text('${l10n.formFieldPriceLabelText}*'), findsOne);
      expect(find.text(l10n.formFieldDetailNumberLabelText), findsOne);
      expect(find.text(l10n.formFieldDescriptionLabelText), findsOne);
      expect(find.byType(TextFormField), findsExactly(4));
      expect(find.byType(SegmentedButton<bool>), findsOneWidget);
      expect(find.byType(TextButton), findsExactly(4));
      expect(find.byType(InputChip), findsNothing);
      expect(find.byType(AppButton), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });
  });
}
