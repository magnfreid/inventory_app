import 'package:authentication_service/authentication_service.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:inventory_app/authenticated_app/cubit/user_cubit.dart';
import 'package:inventory_app/authenticated_app/cubit/user_state.dart';
import 'package:inventory_app/authentication/cubit/authentication_cubit.dart';
import 'package:inventory_app/authentication/cubit/authentication_state.dart';
import 'package:inventory_app/inventory/bloc/inventory_bloc.dart';
import 'package:inventory_app/inventory/bloc/inventory_state.dart';
import 'package:inventory_app/part_details/bloc/part_details_bloc.dart';
import 'package:inventory_app/part_details/bloc/part_details_state.dart';

import 'package:inventory_app/sign_in/bloc/sign_in_bloc.dart';
import 'package:inventory_app/sign_in/bloc/sign_in_state.dart';
import 'package:inventory_app/use_cases/part_presentation.dart/models/part_presentation.dart';
import 'package:inventory_app/use_cases/part_presentation.dart/watch_part_presentations.dart';
import 'package:inventory_app/use_cases/part_presentation.dart/watch_single_part_presentation.dart';

import 'package:mocktail/mocktail.dart';
import 'package:part_repository/part_repository.dart';
import 'package:stock_repository/stock_repository.dart';
import 'package:storage_repository/storage_repository.dart' hide Storage;
import 'package:tag_repository/tag_repository.dart';
import 'package:user_repository/user_repository.dart';

//Objects

class MockPartPresentation extends Mock implements PartPresentation {}

//Repositories
class MockAuthRepository extends Mock implements AuthenticationService {}

class MockUserRepository extends Mock implements UserRepository {}

class MockStorageRepository extends Mock implements StorageRepository {}

class MockStockRepository extends Mock implements StockRepository {}

class MockPartRepository extends Mock implements PartRepository {}

class MockTagRepository extends Mock implements TagRepository {}

class MockWatchPartPresentations extends Mock
    implements WatchPartPresentations {}

class MockWatchSinglePartsPresentation extends Mock
    implements WatchSinglePartPresentation {}

//Bloc
class MockAuthenticationCubit extends MockCubit<AuthenticationState>
    implements AuthenticationCubit {}

class MockUserCubit extends MockCubit<UserState> implements UserCubit {}

class MockSignInBloc extends MockBloc<SignInEvent, SignInState>
    implements SignInBloc {}

class MockInventoryBloc extends MockBloc<InventoryEvent, InventoryState>
    implements InventoryBloc {}

class MockPartDetailsBloc extends MockBloc<PartDetailsEvent, PartDetailsState>
    implements PartDetailsBloc {}

class MockHydratedBlocStorage extends Mock implements Storage {}
