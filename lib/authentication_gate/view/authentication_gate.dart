import 'package:firebase_inventory_repository/firebase_inventory_repository.dart';
import 'package:firebase_location_repository/firebase_location_repository.dart';
import 'package:firebase_product_repository/firebase_product_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/authenticated_app/view/authenticated_app.dart';
import 'package:inventory_app/authentication_gate/cubit/authentication_cubit.dart';
import 'package:inventory_app/authentication_gate/cubit/authentication_state.dart';
import 'package:inventory_app/sign_in/view/sign_in_page.dart';

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
          authenticated: (authUser) => AuthenticatedApp(
            authUser: authUser,
            inventoryRepositoryFactory: (orgId) =>
                FirebaseInventoryRepository(organizationId: orgId),
            locationRepositoryFactory: (orgId) =>
                FirebaseLocationRepository(organizationId: orgId),
            productRepositoryFactory: (orgId) =>
                FirebaseProductRepository(organizationId: orgId),
          ),
        );
      },
    );
  }
}
