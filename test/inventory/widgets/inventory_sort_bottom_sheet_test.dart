import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inventory_app/inventory/bloc/inventory_bloc.dart';
import 'package:inventory_app/inventory/bloc/inventory_state.dart';
import 'package:inventory_app/inventory/models/inventory_filter.dart';
import 'package:inventory_app/inventory/widgets/inventory_sort_bottom_sheet.dart';
import 'package:inventory_app/l10n/l10n.dart';
import 'package:inventory_app/shared/extensions/sort_by_extensions.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/mocks.dart';
import '../../helpers/pump_app.dart';

void main() {
  late InventoryBloc bloc;

  setUp(() {
    bloc = MockInventoryBloc();

    when(() => bloc.state).thenReturn(
      const InventoryState(),
    );

    when(() => bloc.stream).thenAnswer(
      (_) => Stream.value(
        const InventoryState(),
      ),
    );
  });

  setUpAll(() {
    registerFallbackValue(const SortByChipPressed(sortBy: .brand));
  });

  Widget buildBottomSheet() {
    return Scaffold(
      body: BlocProvider.value(
        value: bloc,
        child: const InventorySortBottomSheet(),
      ),
    );
  }

  group('InventorySortBottomSheet', () {
    testWidgets('renders title and all sort chips', (tester) async {
      await tester.pumpApp(buildBottomSheet());
      await tester.pumpAndSettle();

      final context = tester.element(find.byType(Scaffold));
      final l10n = context.l10n;

      expect(find.textContaining(l10n.sortSheetTitleText), findsOneWidget);

      for (final type in SortByType.values) {
        expect(find.text(type.toL10n(context)), findsOneWidget);
      }
    });

    testWidgets('tapping a FilterChip dispatches SortByChipPressed', (
      tester,
    ) async {
      await tester.pumpApp(buildBottomSheet());
      await tester.pumpAndSettle();

      final context = tester.element(find.byType(Scaffold));

      final firstType = SortByType.values.first;

      await tester.tap(find.text(firstType.toL10n(context)));
      await tester.pump();

      verify(
        () => bloc.add(any(that: isA<SortByChipPressed>())),
      ).called(1);
    });

    testWidgets('selected chip matches state', (tester) async {
      const state = InventoryState(
        filter: InventoryFilter(sortByType: SortByType.quantity),
      );

      when(() => bloc.state).thenReturn(state);
      when(() => bloc.stream).thenAnswer((_) => Stream.value(state));

      await tester.pumpApp(buildBottomSheet());
      await tester.pumpAndSettle();

      final context = tester.element(find.byType(Scaffold));

      final selectedChip = tester.widget<FilterChip>(
        find.widgetWithText(FilterChip, SortByType.quantity.toL10n(context)),
      );

      expect(selectedChip.selected, isTrue);
    });
  });
}
