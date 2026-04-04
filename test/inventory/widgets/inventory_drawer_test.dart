import 'package:authentication_service/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inventory_app/authentication/cubit/authentication_cubit.dart';
import 'package:inventory_app/authentication/cubit/authentication_state.dart';
import 'package:inventory_app/inventory/widgets/inventory_drawer.dart';
import 'package:inventory_app/storages/bloc/storages_bloc.dart';
import 'package:inventory_app/storages/bloc/storages_state.dart';
import 'package:inventory_app/theme/cubit/theme_cubit.dart';
import 'package:mocktail/mocktail.dart';
import 'package:storage_repository/storage_repository.dart';

import '../../helpers/mocks.dart';
import '../../helpers/pump_app.dart';

void main() {
  late AuthenticationCubit authCubit;
  late ThemeCubit themeCubit;
  late StoragesBloc storagesBloc;
  late StorageRepository storageRepository;

  setUp(() {
    authCubit = MockAuthenticationCubit();
    themeCubit = MockThemeCubit();
    storagesBloc = MockStoragesBloc();
    storageRepository = MockStorageRepository();

    when(() => authCubit.state).thenReturn(
      AuthenticationState.authenticated(
        user: AuthenticatedUser(id: '123'),
      ),
    );
    when(() => authCubit.stream).thenAnswer(
      (_) => Stream.value(
        AuthenticationState.authenticated(
          user: AuthenticatedUser(id: '123'),
        ),
      ),
    );
    when(() => authCubit.signOut()).thenAnswer((_) async {});

    when(() => themeCubit.state).thenReturn(const ThemeState());
    when(() => themeCubit.stream).thenAnswer(
      (_) => Stream.value(const ThemeState()),
    );

    when(() => storagesBloc.state).thenReturn(const StoragesState());
    when(() => storagesBloc.stream).thenAnswer((_) => const Stream.empty());
  });

  Widget inventoryDrawer() {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: authCubit),
        BlocProvider.value(value: themeCubit),
        BlocProvider.value(value: storagesBloc),
      ],
      child: RepositoryProvider.value(
        value: storageRepository,
        child: const InventoryDrawer(),
      ),
    );
  }

  group('InventoryDrawer', () {
    testWidgets('renders all menu items', (tester) async {
      await tester.pumpApp(inventoryDrawer());

      expect(find.byType(Drawer), findsOneWidget);

      expect(find.byIcon(Icons.shelves), findsOneWidget);
      expect(find.byIcon(Icons.sell), findsOneWidget);
      expect(find.byIcon(Icons.settings), findsOneWidget);
      expect(find.byIcon(Icons.logout), findsOneWidget);
    });

    testWidgets('tapping sign out calls AuthenticationCubit', (tester) async {
      await tester.pumpApp(inventoryDrawer());

      await tester.tap(find.byIcon(Icons.logout));
      await tester.pump();

      verify(() => authCubit.signOut()).called(1);
    });
  });
}
