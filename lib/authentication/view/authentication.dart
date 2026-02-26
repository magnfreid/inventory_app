import 'package:firebase_part_remote/firebase_part_remote.dart';
import 'package:firebase_stock_remote/firebase_stock_remote.dart';
import 'package:firebase_storage_remote/firebase_storage_remote.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/authenticated_app/view/authenticated_app.dart';
import 'package:inventory_app/authentication/cubit/authentication_cubit.dart';
import 'package:inventory_app/authentication/cubit/authentication_state.dart';
import 'package:inventory_app/sign_in/view/sign_in_page.dart';
import 'package:part_repository/part_repository.dart';
import 'package:stock_repository/stock_repository.dart';
import 'package:storage_repository/storage_repository.dart';

class Authentication extends StatelessWidget {
  const Authentication({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationCubit, AuthenticationState>(
      builder: (context, state) {
        return state.when(
          loading: () => const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
          unauthenticated: SignInPage.new,
          authenticated: (authUser) => AuthenticatedApp(
            authUser: authUser,
            stockRepositoryFactory: (orgId) {
              final firebaseStockRemote = FirebaseStockRemote(
                organizationId: orgId,
              );
              return StockRepository(remote: firebaseStockRemote);
            },
            storageRepositoryFactory: (orgId) {
              final firebaseStorageRemote = FirebaseStorageRemote(
                organizationId: orgId,
              );
              return StorageRepository(remote: firebaseStorageRemote);
            },
            partRepositoryFactory: (orgId) {
              final firebasePartRemote = FirebasePartRemote(
                organizationId: orgId,
              );
              return PartRepository(remote: firebasePartRemote);
            },
          ),
        );
      },
    );
  }
}
