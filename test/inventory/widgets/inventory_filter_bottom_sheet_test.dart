import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inventory_app/inventory/bloc/inventory_bloc.dart';
import 'package:inventory_app/inventory/bloc/inventory_state.dart';
import 'package:inventory_app/inventory/models/inventory_filter.dart';
import 'package:inventory_app/inventory/widgets/inventory_filter_bottom_sheet.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/helpers.dart';

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

  Widget buildBottomSheet() {
    return Scaffold(
      body: BlocProvider.value(
        value: bloc,
        child: const InventoryFilterBottomSheet(),
      ),
    );
  }

  testWidgets('renders filter sheet sections', (tester) async {
    await tester.pumpApp(buildBottomSheet());
    await tester.pumpAndSettle();

    expect(find.text('Category'), findsOneWidget);
    expect(find.text('Brand'), findsOneWidget);
    expect(find.text('Storage'), findsOneWidget);

    expect(find.text('All'), findsNWidgets(3));

    expect(find.byType(TextButton), findsOneWidget);
  });

  testWidgets('tapping Clear All dispatches ClearAllFiltersButtonPressed', (
    tester,
  ) async {
    when(() => bloc.state).thenAnswer(
      (_) => const InventoryState(
        filter: InventoryFilter(
          brandFilters: {'123'},
          categoryFilters: {'456'},
        ),
      ),
    );
    await tester.pumpApp(buildBottomSheet());
    await tester.pumpAndSettle();

    final clearAllButton = find.byType(AppButton);
    expect(clearAllButton, findsOneWidget);

    await tester.tap(clearAllButton);
    await tester.pump();

    verify(() => bloc.add(const ClearAllFiltersButtonPressed())).called(1);
  });
}
