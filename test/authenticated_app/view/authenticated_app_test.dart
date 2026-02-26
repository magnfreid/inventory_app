import 'package:authentication_service/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inventory_app/authenticated_app/view/authenticated_app.dart';
import 'package:inventory_app/inventory/view/inventory_page.dart';
import 'package:mocktail/mocktail.dart';
import 'package:part_repository/part_repository.dart';
import 'package:stock_repository/stock_repository.dart';
import 'package:storage_repository/storage_repository.dart';
import 'package:user_repository/user_repository.dart';

import '../../helpers/helpers.dart';

void main() {
  late MockUserRepository userRepository;
  late MockStorageRepository storageRepository;
  late MockStockRepository stockRepository;
  late MockPartRepository partRepository;
  late AuthenticatedUser authUser;
  late User user;

  setUp(() {
    userRepository = MockUserRepository();
    storageRepository = MockStorageRepository();
    stockRepository = MockStockRepository();
    partRepository = MockPartRepository();
    authUser = AuthenticatedUser(id: '123');
    user = User(
      id: '123',
      organizationId: 'org1',
      name: 'Test',
      email: 'test@test.com',
      role: .admin,
    );
  });

  group('AuthenticatedApp', () {
    testWidgets(
      'shows loading indicator initially',
      (tester) async {
        when(
          () => userRepository.watchUser('123'),
        ).thenAnswer((_) => const Stream.empty());

        await tester.pumpWidget(
          MaterialApp(
            home: RepositoryProvider<UserRepository>.value(
              value: userRepository,
              child: AuthenticatedApp(
                authUser: authUser,
                stockRepositoryFactory: (orgId) => stockRepository,
                storageRepositoryFactory: (orgId) => storageRepository,
                partRepositoryFactory: (orgId) => partRepository,
              ),
            ),
          ),
        );

        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      },
    );

    testWidgets(
      'renders InventoryPage when user loads',
      (tester) async {
        when(
          () => userRepository.watchUser('123'),
        ).thenAnswer((_) => Stream.value(user));
        when(
          () => stockRepository.watchStock(),
        ).thenAnswer((_) => Stream.value(<Stock>[]));

        when(
          () => storageRepository.watchStorages(),
        ).thenAnswer((_) => Stream.value(<Storage>[]));

        when(
          () => partRepository.watchParts(),
        ).thenAnswer((_) => Stream.value(<Part>[]));

        await tester.pumpApp(
          RepositoryProvider<UserRepository>.value(
            value: userRepository,
            child: AuthenticatedApp(
              authUser: authUser,
              stockRepositoryFactory: (orgId) => stockRepository,
              storageRepositoryFactory: (orgId) => storageRepository,
              partRepositoryFactory: (orgId) => partRepository,
            ),
          ),
        );

        await tester.pump();

        expect(find.byType(InventoryPage), findsOneWidget);
      },
    );
  });
}
