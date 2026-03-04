import 'package:authentication_service/authentication_service.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:inventory_app/authentication/cubit/authentication_cubit.dart';
import 'package:inventory_app/authentication/cubit/authentication_state.dart';

import 'package:inventory_app/sign_in/bloc/sign_in_bloc.dart';
import 'package:inventory_app/sign_in/bloc/sign_in_state.dart';

import 'package:mocktail/mocktail.dart';
import 'package:part_repository/part_repository.dart';
import 'package:stock_repository/stock_repository.dart';
import 'package:storage_repository/storage_repository.dart';
import 'package:tag_repository/tag_repository.dart';
import 'package:user_repository/user_repository.dart';

//Repositories
class MockAuthRepository extends Mock implements AuthenticationService {}

class MockUserRepository extends Mock implements UserRepository {}

class MockStorageRepository extends Mock implements StorageRepository {}

class MockStockRepository extends Mock implements StockRepository {}

class MockPartRepository extends Mock implements PartRepository {}

class MockTagRepository extends Mock implements TagRepository {}

//Bloc
class MockAuthenticationCubit extends MockCubit<AuthenticationState>
    implements AuthenticationCubit {}

class MockSignInBloc extends MockBloc<SignInEvent, SignInState>
    implements SignInBloc {}
