import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inventory_app/authenticated_app/cubit/user_cubit.dart';
import 'package:inventory_app/authenticated_app/cubit/user_state.dart';
import 'package:mocktail/mocktail.dart';
import 'package:user_repository/user_repository.dart';

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  late MockUserRepository userRepository;
  late User testUser;

  setUp(() {
    userRepository = MockUserRepository();
    testUser = User(
      id: '123',
      organizationId: 'org1',
      name: 'Test',
      email: 'test@test.com',
      role: UserRole.admin,
    );
  });

  group('UserCubit', () {
    blocTest<UserCubit, UserState>(
      'emits [loaded] when user is found',
      build: () {
        when(
          () => userRepository.watchUser('123'),
        ).thenAnswer((_) => Stream.value(testUser));
        return UserCubit(userRepository: userRepository, currentUserId: '123');
      },
      expect: () => [
        UserState.loaded(currentUser: testUser),
      ],
    );

    blocTest<UserCubit, UserState>(
      'emits [error] when user is null',
      build: () {
        when(
          () => userRepository.watchUser('123'),
        ).thenAnswer((_) => Stream.value(null));
        return UserCubit(userRepository: userRepository, currentUserId: '123');
      },
      expect: () => [
        isA<UserState>().having(
          (s) => s,
          'error type',
          isA<UserState>().having(
            (state) => state.toString(),
            'error message',
            contains('User not found'),
          ),
        ),
      ],
    );

    blocTest<UserCubit, UserState>(
      'emits [error] when repository stream throws',
      build: () {
        when(
          () => userRepository.watchUser('123'),
        ).thenAnswer((_) => Stream<User?>.error('oops'));
        return UserCubit(userRepository: userRepository, currentUserId: '123');
      },
      expect: () => [
        isA<UserState>().having(
          (s) => s,
          'error type',
          isA<UserState>().having(
            (state) => state.toString(),
            'error message',
            contains('oops'),
          ),
        ),
      ],
    );
  });
}
