import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inventory_app/part_details/bloc/part_details_bloc.dart';
import 'package:inventory_app/part_details/bloc/part_details_state.dart';
import 'package:inventory_app/part_details/view/part_details_page.dart';
import 'package:inventory_app/part_details/widgets/part_details_in_stock.dart';
import 'package:inventory_app/part_details/widgets/part_details_info.dart';
import 'package:inventory_app/part_details/widgets/part_details_restock.dart';
import 'package:inventory_app/use_cases/part_presentation.dart/models/part_presentation.dart';
import 'package:mocktail/mocktail.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../helpers/helpers.dart';

void main() {
  late PartDetailsBloc bloc;
  late PartPresentation part;

  setUp(() {
    part = PartPresentation(
      partId: '123',
      name: 'Name',
      detailNumber: 'details',
      price: 10,
      isRecycled: true,
    );

    bloc = MockPartDetailsBloc();
  });

  group('PartDetailsView', () {
    Widget pumpView() {
      return BlocProvider.value(
        value: bloc,
        child: const PartDetailsView(partId: '123'),
      );
    }

    group('PartDetailsView', () {
      testWidgets('shows skeleton when part is null', (tester) async {
        when(() => bloc.state).thenReturn(const PartDetailsState());

        await tester.pumpApp(pumpView());

        final skeletonFinder = find.byWidgetPredicate(
          (widget) => widget is Skeletonizer && widget.enabled,
        );
        expect(skeletonFinder, findsExactly(4));
      });

      testWidgets('shows part name in AppBar when loaded', (tester) async {
        when(() => bloc.state).thenReturn(
          PartDetailsState(part: part),
        );

        await tester.pumpApp(pumpView());

        expect(find.text(part.name), findsOneWidget);
      });

      testWidgets('shows PartDetailsInfo by default', (tester) async {
        when(() => bloc.state).thenReturn(
          PartDetailsState(
            part: part,
          ),
        );

        await tester.pumpApp(pumpView());

        expect(find.byType(PartDetailsInfo), findsOneWidget);
      });

      testWidgets('shows PartDetailsInStock when content is inStock', (
        tester,
      ) async {
        when(() => bloc.state).thenReturn(
          PartDetailsState(
            part: part,
            content: PartDetailsContent.inStock,
          ),
        );

        await tester.pumpApp(pumpView());

        expect(find.byType(PartDetailsInStock), findsOneWidget);
      });

      testWidgets('shows PartDetailsRestock when content is restock', (
        tester,
      ) async {
        when(() => bloc.state).thenReturn(
          PartDetailsState(
            part: part,
            content: PartDetailsContent.restock,
          ),
        );

        await tester.pumpApp(pumpView());

        expect(find.byType(PartDetailsRestock), findsOneWidget);
      });

      testWidgets('tapping delete button shows bottom sheet', (tester) async {
        when(() => bloc.state).thenReturn(
          PartDetailsState(part: part),
        );

        await tester.pumpApp(pumpView());

        await tester.tap(find.byIcon(Icons.delete));
        await tester.pumpAndSettle();

        expect(find.textContaining('delete'), findsWidgets);
      });
    });
  });
}
