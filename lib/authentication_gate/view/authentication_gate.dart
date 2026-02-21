import 'package:auth_repository/auth_repository.dart';
import 'package:firebase_inventory_repository/firebase_inventory_repository.dart';
import 'package:firebase_location_repository/firebase_location_repository.dart';
import 'package:firebase_product_repository/firebase_product_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/authentication_gate/cubits/auth/authentication_cubit.dart';
import 'package:inventory_app/authentication_gate/cubits/auth/authentication_state.dart';
import 'package:inventory_app/authentication_gate/user/user_cubit.dart';
import 'package:inventory_app/authentication_gate/user/user_state.dart';
import 'package:inventory_app/inventory/view/inventory_page.dart';
import 'package:inventory_app/sign_in/view/sign_in_page.dart';
import 'package:inventory_repository/inventory_repository.dart';
import 'package:location_repository/location_repository.dart';
import 'package:product_repository/product_repository.dart';
import 'package:user_repository/user_repository.dart';

class AuthenticationGate extends StatelessWidget {
  const AuthenticationGate({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationCubit, AuthenticationState>(
      builder: (context, state) {
        return state.when(
          loading: () => const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
          unauthenticated: SignInPage.new,
          authenticated: AuthenticatedApp.new,
        );
      },
    );
  }
}

class AuthenticatedApp extends StatelessWidget {
  const AuthenticatedApp(this.authUser, {super.key});

  final AuthUser authUser;

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
                create: (_) => FirebaseInventoryRepository(
                  organizationId: currentUser.organizationId,
                ),
              ),
              RepositoryProvider<LocationRepository>(
                create: (_) => FirebaseLocationRepository(
                  organizationId: currentUser.organizationId,
                ),
              ),
              RepositoryProvider<ProductRepository>(
                create: (_) => FirebaseProductRepository(
                  organizationId: currentUser.organizationId,
                ),
              ),
            ],
            child: const InventoryPage(),
          ),
        ),
      ),
    );
  }
}
