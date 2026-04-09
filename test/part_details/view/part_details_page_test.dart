import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inventory_app/part_details/bloc/part_details_bloc.dart';
import 'package:inventory_app/part_details/bloc/part_details_state.dart';
import 'package:inventory_app/part_details/view/part_details_page.dart';
import 'package:inventory_app/use_cases/part_presentation.dart/models/part_presentation.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/helpers.dart';

void main() {
  late PartDetailsBloc bloc;
  late PartPresentation part;

  setUp(() {
    part = const PartPresentation(
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
        child: const PartDetailsView(),
      );
    }

    group('PartDetailsView', () {
      testWidgets('shows part name in AppBar when loaded', (tester) async {
        when(() => bloc.state).thenReturn(
          PartDetailsState(part: part),
        );

        await tester.pumpApp(pumpView());

        expect(find.text(part.name), findsOneWidget);
      });
    });
  });
}
