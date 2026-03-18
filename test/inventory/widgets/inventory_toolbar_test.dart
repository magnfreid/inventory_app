import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inventory_app/inventory/bloc/inventory_bloc.dart';
import 'package:inventory_app/inventory/bloc/inventory_state.dart';
import 'package:inventory_app/inventory/models/inventory_filter.dart';
import 'package:inventory_app/inventory/widgets/inventory_tool_bar.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/helpers.dart';

void main() {
  late InventoryBloc bloc;

  setUp(() {
    bloc = MockInventoryBloc();
  });

  Widget inventoryDrawer() =>
      BlocProvider.value(value: bloc, child: const InventoryToolBar());

  testWidgets('shows toolbar initially', (tester) async {
    when(() => bloc.state).thenReturn(const InventoryState());

    await tester.pumpApp(inventoryDrawer());

    expect(find.byKey(const ValueKey('toolbar')), findsOneWidget);
    expect(find.byKey(const ValueKey('searchbar')), findsNothing);
  });

  testWidgets('tapping search shows search bar', (tester) async {
    when(() => bloc.state).thenReturn(const InventoryState());

    await tester.pumpApp(inventoryDrawer());

    await tester.tap(find.byIcon(Icons.search));
    await tester.pumpAndSettle();

    expect(find.byKey(const ValueKey('searchbar')), findsOneWidget);
  });

  testWidgets('cancel button clears search and hides bar', (tester) async {
    when(() => bloc.state).thenReturn(const InventoryState());

    await tester.pumpApp(inventoryDrawer());

    await tester.tap(find.byIcon(Icons.search));
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.cancel));
    await tester.pumpAndSettle();

    verify(
      () => bloc.add(
        const SearchQueryUpdated(searchString: ''),
      ),
    ).called(1);

    expect(find.byKey(const ValueKey('toolbar')), findsOneWidget);
  });

  testWidgets('sort button opens bottom sheet', (tester) async {
    when(() => bloc.state).thenReturn(const InventoryState());

    await tester.pumpApp(inventoryDrawer());

    await tester.tap(find.byIcon(Icons.sort));
    await tester.pumpAndSettle();

    expect(find.byType(BottomSheet), findsOneWidget);
  });

  testWidgets('filter button shows badge count', (tester) async {
    when(() => bloc.state).thenReturn(
      const InventoryState(
        filter: InventoryFilter(
          brandFilters: {'123'},
          categoryFilters: {'456'},
          storageFilters: {'789'},
        ),
      ),
    );

    await tester.pumpApp(inventoryDrawer());

    expect(find.text('3'), findsOneWidget);
  });

  testWidgets('sort order button dispatches event', (tester) async {
    when(() => bloc.state).thenReturn(const InventoryState());

    await tester.pumpApp(inventoryDrawer());

    await tester.tap(find.byIcon(Icons.arrow_upward));
    await tester.pump();

    verify(() => bloc.add(const SortOrderButtonPressed())).called(1);
  });
}
