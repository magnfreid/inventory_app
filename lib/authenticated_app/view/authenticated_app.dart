import 'package:authentication_service/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/authenticated_app/cubit/user_cubit.dart';
import 'package:inventory_app/authenticated_app/cubit/user_state.dart';
import 'package:inventory_app/inventory/view/inventory_page.dart';
import 'package:part_repository/part_repository.dart';
import 'package:stock_repository/stock_repository.dart';
import 'package:storage_repository/storage_repository.dart';

import 'package:user_repository/user_repository.dart';

class AuthenticatedApp extends StatelessWidget {
  const AuthenticatedApp({
    required this.authUser,
    required this.stockRepositoryFactory,
    required this.storageRepositoryFactory,
    required this.partRepositoryFactory,
    super.key,
  });

  final AuthenticatedUser authUser;

  final StockRepository Function(String orgId) stockRepositoryFactory;
  final StorageRepository Function(String orgId) storageRepositoryFactory;
  final PartRepository Function(String orgId) partRepositoryFactory;

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
              RepositoryProvider<StockRepository>(
                create: (_) =>
                    stockRepositoryFactory(currentUser.organizationId),
              ),
              RepositoryProvider<StorageRepository>(
                create: (_) =>
                    storageRepositoryFactory(currentUser.organizationId),
              ),
              RepositoryProvider<PartRepository>(
                create: (_) =>
                    partRepositoryFactory(currentUser.organizationId),
              ),
            ],
            child: Navigator(
              onGenerateRoute: (_) => MaterialPageRoute(
                builder: (context) => const InventoryPage(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
