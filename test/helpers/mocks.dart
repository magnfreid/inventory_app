import 'package:auth_repository/auth_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:inventory_app/authentication/cubit/authentication_cubit.dart';
import 'package:inventory_app/authentication/cubit/authentication_state.dart';
import 'package:inventory_app/sign_in/bloc/sign_in_bloc.dart';
import 'package:inventory_app/sign_in/bloc/sign_in_state.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

class MockAuthenticationCubit extends MockCubit<AuthenticationState>
    implements AuthenticationCubit {}

class MockSignInBloc extends MockBloc<SignInEvent, SignInState>
    implements SignInBloc {}
