import 'package:firebase_inventory_repository/firebase_inventory_repository.dart';
import 'package:firebase_location_repository/firebase_location_repository.dart';
import 'package:firebase_product_repository/firebase_product_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/authentication/cubit/authentication_cubit.dart';
import 'package:inventory_app/authentication/cubit/authentication_state.dart';
import 'package:inventory_app/home/cubit/user_cubit.dart';
import 'package:inventory_app/home/cubit/user_state.dart';
import 'package:inventory_app/home/view/home_page.dart';
import 'package:inventory_app/sign_in/view/sign_in_page.dart';
import 'package:inventory_repository/inventory_repository.dart';
import 'package:location_repository/location_repository.dart';
import 'package:product_repository/product_repository.dart';
import 'package:user_repository/user_repository.dart';

class AuthenticationPage extends StatelessWidget {
  const AuthenticationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //TODO(magnfreid): Appbar for testing, remove later
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => context.read<AuthenticationCubit>().signOut(),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<AuthenticationCubit, AuthenticationState>(
          builder: (context, state) {
            return state.when(
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              unauthenticated: () => const SignInPage(),
              authenticated: (authUser) => BlocProvider(
                create: (context) => UserCubit(
                  userRepository: context.read<UserRepository>(),
                  currentUserId: authUser.id,
                ),
                child: const AuthenticationView(),
              ),
            );
          },
        ),
      ),
    );
  }
}

//TODO(magnfreid): Make this it's own view/feature?
class AuthenticationView extends StatelessWidget {
  const AuthenticationView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        return state.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error) => Text(error.toString()),
          loaded: (user) {
            return MultiRepositoryProvider(
              providers: [
                RepositoryProvider<LocationRepository>(
                  create: (_) => FirebaseLocationRepository(
                    organizationId: user.organizationId,
                  ),
                ),
                RepositoryProvider<InventoryRepository>(
                  create: (_) => FirebaseInventoryRepository(
                    organizationId: user.organizationId,
                  ),
                ),
                RepositoryProvider<ProductRepository>(
                  create: (_) => FirebaseProductRepository(
                    organizationId: user.organizationId,
                  ),
                ),
              ],
              child: const HomePage(),
            );
          },
        );
      },
    );
  }
}
