import 'package:auth_repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inventory_app/authenticated_app/view/authenticated_app.dart';
import 'package:inventory_app/inventory/view/inventory_page.dart';
import 'package:inventory_repository/inventory_repository.dart';
import 'package:location_repository/location_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:product_repository/product_repository.dart';
import 'package:user_repository/user_repository.dart';

import '../../helpers/helpers.dart';

void main() {
  late MockUserRepository userRepository;
  late MockLocationRepository locationRepository;
  late MockInventoryRepository inventoryRepository;
  late MockProductRepository productRepository;
  late AuthUser authUser;
  late User user;

  setUp(() {
    userRepository = MockUserRepository();
    locationRepository = MockLocationRepository();
    inventoryRepository = MockInventoryRepository();
    productRepository = MockProductRepository();
    authUser = AuthUser(id: '123');
    user = User(
      id: '123',
      organizationId: 'org1',
      name: 'Test',
      email: 'test@test.com',
      role: UserRole.admin,
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
                inventoryRepositoryFactory: (orgId) => inventoryRepository,
                locationRepositoryFactory: (orgId) => locationRepository,
                productRepositoryFactory: (orgId) => productRepository,
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
          () => inventoryRepository.watchInventoryItems(),
        ).thenAnswer((_) => Stream.value(<InventoryItem>[]));

        when(
          () => locationRepository.watchLocations(),
        ).thenAnswer((_) => Stream.value(<Location>[]));

        when(
          () => productRepository.watchProducts(),
        ).thenAnswer((_) => Stream.value(<Product>[]));

        await tester.pumpApp(
          RepositoryProvider<UserRepository>.value(
            value: userRepository,
            child: AuthenticatedApp(
              authUser: authUser,
              inventoryRepositoryFactory: (orgId) => inventoryRepository,
              locationRepositoryFactory: (orgId) => locationRepository,
              productRepositoryFactory: (orgId) => productRepository,
            ),
          ),
        );

        await tester.pump();

        expect(find.byType(InventoryPage), findsOneWidget);
      },
    );
  });
}
