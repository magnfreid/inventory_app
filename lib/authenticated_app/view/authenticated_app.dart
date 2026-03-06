import 'package:authentication_service/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/authenticated_app/cubit/user_cubit.dart';
import 'package:inventory_app/authenticated_app/cubit/user_state.dart';
import 'package:inventory_app/inventory/view/inventory_page.dart';
import 'package:inventory_app/use_cases/part_presentation.dart/watch_part_presentations.dart';
import 'package:inventory_app/use_cases/part_presentation.dart/watch_single_part_presentation.dart';
import 'package:part_repository/part_repository.dart';
import 'package:stock_repository/stock_repository.dart';
import 'package:storage_repository/storage_repository.dart';
import 'package:tag_repository/tag_repository.dart';

import 'package:user_repository/user_repository.dart';

class AuthenticatedApp extends StatelessWidget {
  const AuthenticatedApp({
    required this.authUser,
    required this.stockRepositoryFactory,
    required this.storageRepositoryFactory,
    required this.partRepositoryFactory,
    required this.tagRepositoryFactory,
    super.key,
  });

  final AuthenticatedUser authUser;

  final StockRepository Function(String orgId) stockRepositoryFactory;
  final StorageRepository Function(String orgId) storageRepositoryFactory;
  final PartRepository Function(String orgId) partRepositoryFactory;
  final TagRepository Function(String orgId) tagRepositoryFactory;

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
              RepositoryProvider<TagRepository>(
                create: (_) => tagRepositoryFactory(currentUser.organizationId),
              ),
              RepositoryProvider<WatchPartPresentations>(
                create: (context) => WatchPartPresentations(
                  partRepository: context.read<PartRepository>(),
                  storageRepository: context.read<StorageRepository>(),
                  stockRepository: context.read<StockRepository>(),
                  tagRepository: context.read<TagRepository>(),
                ),
              ),
              RepositoryProvider<WatchSinglePartPresentation>(
                create: (context) => WatchSinglePartPresentation(
                  watchPartPresentations: context
                      .read<WatchPartPresentations>(),
                ),
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
