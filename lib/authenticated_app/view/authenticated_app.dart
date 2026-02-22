import 'package:auth_repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/authenticated_app/cubit/user_cubit.dart';
import 'package:inventory_app/authenticated_app/cubit/user_state.dart';
import 'package:inventory_app/inventory/view/inventory_page.dart';
import 'package:inventory_repository/inventory_repository.dart';
import 'package:location_repository/location_repository.dart';
import 'package:product_repository/product_repository.dart';
import 'package:user_repository/user_repository.dart';

class AuthenticatedApp extends StatelessWidget {
  const AuthenticatedApp({
    required this.authUser,
    required this.inventoryRepositoryFactory,
    required this.locationRepositoryFactory,
    required this.productRepositoryFactory,
    super.key,
  });

  final AuthUser authUser;

  final InventoryRepository Function(String orgId) inventoryRepositoryFactory;
  final LocationRepository Function(String orgId) locationRepositoryFactory;
  final ProductRepository Function(String orgId) productRepositoryFactory;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UserCubit(
        userRepository: context.read<UserRepository>(),
        currentUserId: authUser.id,
      ),
      child: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) => state.when(
          loading: () =>
              const Center(child: CircularProgressIndicator.adaptive()),
          error: (error) => Text(error.toString()),
          loaded: (currentUser) => MultiRepositoryProvider(
            providers: [
              RepositoryProvider<InventoryRepository>(
                create: (_) =>
                    inventoryRepositoryFactory(currentUser.organizationId),
              ),
              RepositoryProvider<LocationRepository>(
                create: (_) =>
                    locationRepositoryFactory(currentUser.organizationId),
              ),
              RepositoryProvider<ProductRepository>(
                create: (_) =>
                    productRepositoryFactory(currentUser.organizationId),
              ),
            ],
            child: const InventoryPage(),
          ),
        ),
      ),
    );
  }
}
