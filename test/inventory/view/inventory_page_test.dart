import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart'
    as hydrated
    show HydratedBloc, Storage;
import 'package:inventory_app/authenticated_app/cubit/user_cubit.dart';
import 'package:inventory_app/authenticated_app/cubit/user_state.dart';
import 'package:inventory_app/inventory/bloc/inventory_bloc.dart';
import 'package:inventory_app/inventory/bloc/inventory_state.dart';
import 'package:inventory_app/inventory/view/inventory_page.dart';
import 'package:inventory_app/inventory/widgets/inventory_part_card.dart';
import 'package:inventory_app/l10n/l10n.dart';
import 'package:inventory_app/use_cases/part_presentation.dart/models/part_presentation.dart';
import 'package:inventory_app/use_cases/part_presentation.dart/models/stock_presentation.dart';
import 'package:mocktail/mocktail.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:user_repository/user_repository.dart';
import '../../helpers/helpers.dart';

void main() {
  late InventoryBloc inventoryBloc;
  late UserCubit userCubit;
  late PartPresentation mockPart;
  late hydrated.Storage storage;
  late User user;

  setUp(() {
    storage = MockHydratedBlocStorage();
    user = User(
      id: '123',
      organizationId: '456',
      name: 'Test User',
      email: 'email@test.com',
      role: .admin,
    );
    when(() => storage.write(any(), any<dynamic>())).thenAnswer((_) async {});
    hydrated.HydratedBloc.storage = storage;

    inventoryBloc = MockInventoryBloc();
    userCubit = MockUserCubit();
    mockPart = MockPartPresentation();

    when(() => inventoryBloc.state).thenReturn(
      const InventoryState(),
    );

    when(() => userCubit.state).thenReturn(
      UserState.loaded(currentUser: user),
    );

    when(() => mockPart.name).thenReturn('Test Part');
    when(() => mockPart.stock).thenReturn(<StockPresentation>[]);
    when(() => mockPart.isRecycled).thenReturn(false);
    when(() => mockPart.detailNumber).thenReturn('');
    when(() => mockPart.price).thenReturn(1);
    when(() => mockPart.totalQuantity).thenReturn(1);
  });

  Widget pumpInventoryView() => MultiBlocProvider(
    providers: [
      BlocProvider.value(value: inventoryBloc),
      BlocProvider.value(value: userCubit),
    ],
    child: const InventoryView(),
  );

  testWidgets('AppBar shows user name', (tester) async {
    await tester.pumpApp(pumpInventoryView());
    expect(find.text(user.name), findsOneWidget);
  });

  testWidgets('shows skeletons when state is loading', (tester) async {
    when(() => inventoryBloc.state).thenReturn(
      const InventoryState(),
    );

    await tester.pumpApp(pumpInventoryView());
    await tester.pump();

    final skeletonFinder = find.byWidgetPredicate(
      (widget) => widget is Skeletonizer && widget.enabled,
    );
    expect(skeletonFinder, findsOneWidget);
  });

  testWidgets('shows empty message when loaded with no parts', (tester) async {
    when(() => inventoryBloc.state).thenReturn(
      const InventoryState(
        status: .loaded,
      ),
    );
    await tester.pumpApp(pumpInventoryView());

    final context = tester.element(find.byType(Scaffold));
    final l10n = context.l10n;

    expect(find.text(l10n.partsListEmpty), findsOneWidget);
  });

  testWidgets('renders ListView with InventoryPartCard when parts exist', (
    tester,
  ) async {
    when(() => inventoryBloc.state).thenReturn(
      InventoryState(
        status: .loaded,
        parts: [mockPart, mockPart],
      ),
    );

    await tester.pumpApp(pumpInventoryView());
    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(InventoryPartCard), findsNWidgets(2));
  });
}
