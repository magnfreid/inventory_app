import 'package:authentication_service/authentication_service.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:image_repository/image_repository.dart';
import 'package:inventory_app/authenticated_app/cubit/user_cubit.dart';
import 'package:inventory_app/authenticated_app/cubit/user_state.dart';
import 'package:inventory_app/authentication/cubit/authentication_cubit.dart';
import 'package:inventory_app/authentication/cubit/authentication_state.dart';
import 'package:inventory_app/inventory/bloc/inventory_bloc.dart';
import 'package:inventory_app/inventory/bloc/inventory_state.dart';
import 'package:inventory_app/part_details/bloc/part_details_bloc.dart';
import 'package:inventory_app/part_details/bloc/part_details_state.dart';
import 'package:inventory_app/part_editor/bloc/part_editor_bloc.dart';
import 'package:inventory_app/part_editor/bloc/part_editor_state.dart';

import 'package:inventory_app/sign_in/bloc/sign_in_bloc.dart';
import 'package:inventory_app/sign_in/bloc/sign_in_state.dart';
import 'package:inventory_app/storages/bloc/storages_bloc.dart';
import 'package:inventory_app/storages/bloc/storages_state.dart';
import 'package:inventory_app/storages_editor/bloc/storages_editor_bloc.dart';
import 'package:inventory_app/storages_editor/bloc/storages_editor_state.dart';
import 'package:inventory_app/theme/cubit/theme_cubit.dart';
import 'package:inventory_app/use_cases/part_presentation.dart/models/part_presentation.dart';
import 'package:inventory_app/use_cases/part_presentation.dart/watch_part_presentations.dart';
import 'package:inventory_app/use_cases/part_presentation.dart/watch_single_part_presentation.dart';

import 'package:mocktail/mocktail.dart';
import 'package:part_repository/part_repository.dart';
import 'package:stock_repository/stock_repository.dart';
import 'package:storage_repository/storage_repository.dart' hide Storage;
import 'package:tag_repository/tag_repository.dart';
import 'package:user_repository/user_repository.dart';

class MockPartPresentation extends Mock implements PartPresentation {}

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class FakeRoute extends Fake implements Route<dynamic> {}

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

class MockImageRepository extends Mock implements ImageRepository {}

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

class MockStoragesBloc extends MockBloc<StoragesEvent, StoragesState>
    implements StoragesBloc {}

class MockStorageEditorBloc
    extends MockBloc<StoragesEditorEvent, StoragesEditorState>
    implements StoragesEditorBloc {}

class MockPartEditorBloc extends MockBloc<PartEditorEvent, PartEditorState>
    implements PartEditorBloc {}

class MockThemeCubit extends MockCubit<AppThemeMode> implements ThemeCubit {}

class MockHydratedBlocStorage extends Mock implements Storage {}
