import 'package:auth_repository/auth_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:inventory_app/authentication_gate/cubit/authentication_cubit.dart';
import 'package:inventory_app/authentication_gate/cubit/authentication_state.dart';

import 'package:inventory_app/sign_in/bloc/sign_in_bloc.dart';
import 'package:inventory_app/sign_in/bloc/sign_in_state.dart';
import 'package:inventory_repository/inventory_repository.dart';
import 'package:location_repository/location_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:product_repository/product_repository.dart';
import 'package:user_repository/user_repository.dart';

//Repositories
class MockAuthRepository extends Mock implements AuthRepository {}

class MockUserRepository extends Mock implements UserRepository {}

class MockLocationRepository extends Mock implements LocationRepository {}

class MockInventoryRepository extends Mock implements InventoryRepository {}

class MockProductRepository extends Mock implements ProductRepository {}

//Bloc
class MockAuthenticationCubit extends MockCubit<AuthenticationState>
    implements AuthenticationCubit {}

class MockSignInBloc extends MockBloc<SignInEvent, SignInState>
    implements SignInBloc {}
