import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inventory_app/authenticated_app/cubit/user_cubit.dart';
import 'package:inventory_app/authenticated_app/cubit/user_state.dart';
import 'package:mocktail/mocktail.dart';
import 'package:user_repository/user_repository.dart';

import '../../helpers/mocks.dart';

void main() {
  late MockUserRepository userRepository;
  const userId = '123';

  setUp(() {
    userRepository = MockUserRepository();
  });

  group('UserCubit', () {
    final testUser = User(
      id: userId,
      organizationId: 'org1',
      name: 'name',
      email: 'email',
      role: .admin,
      // add other required fields
    );

    blocTest<UserCubit, UserState>(
      'emits [loaded] when repository emits user',
      build: () {
        when(
          () => userRepository.watchUser(userId),
        ).thenAnswer((_) => Stream.value(testUser));

        return UserCubit(
          userRepository: userRepository,
          currentUserId: userId,
        );
      },
      expect: () => [
        UserState.loaded(currentUser: testUser),
      ],
    );

    blocTest<UserCubit, UserState>(
      'emits [error] when repository emits null',
      build: () {
        when(
          () => userRepository.watchUser(userId),
        ).thenAnswer((_) => Stream.value(null));

        return UserCubit(
          userRepository: userRepository,
          currentUserId: userId,
        );
      },
      expect: () => [
        isA<UserState>().having(
          (state) => state,
          'error state',
          isA<UserState>(),
        ),
      ],
    );

    blocTest<UserCubit, UserState>(
      'emits [error] when stream throws',
      build: () {
        when(
          () => userRepository.watchUser(userId),
        ).thenAnswer((_) => Stream.error(Exception('failure')));

        return UserCubit(
          userRepository: userRepository,
          currentUserId: userId,
        );
      },
      expect: () => [
        isA<UserState>(),
      ],
    );
  });
}
