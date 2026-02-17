import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inventory_app/sign_in/bloc/sign_in_bloc.dart';
import 'package:inventory_app/sign_in/bloc/sign_in_state.dart';
import 'package:inventory_app/sign_in/view/sign_in_page.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/mocks.dart';
import '../../helpers/pump_app.dart';

void main() {
  late SignInBloc bloc;

  setUp(() {
    bloc = MockSignInBloc();
  });
  registerFallbackValue(
    const SignInButtonPressed(email: '', password: ''),
  );
  group('SignInPage', () {
    testWidgets('renders textfields with titles and save button with text in '
        'SignInView when idle', (
      tester,
    ) async {
      when(() => bloc.state).thenReturn(const SignInState());
      whenListen(bloc, const Stream<SignInState>.empty());
      await tester.pumpApp(
        BlocProvider.value(
          value: bloc,
          child: const SignInView(),
        ),
      );
      expect(find.byType(TextField), findsExactly(2));
      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.byType(Text), findsExactly(3));
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });

    testWidgets('renders textfields with title and save button with spinner in '
        'SignInView when loading', (
      tester,
    ) async {
      when(
        () => bloc.state,
      ).thenReturn(const SignInState(status: .loading));
      whenListen(bloc, const Stream<SignInState>.empty());
      await tester.pumpApp(
        BlocProvider.value(
          value: bloc,
          child: const SignInView(),
        ),
      );
      expect(find.byType(TextField), findsExactly(2));
      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.byType(Text), findsExactly(2));
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('shows snackbar when bloc emits error', (tester) async {
      final errorState = SignInState(
        error: Exception('Something went wrong'),
      );

      when(() => bloc.state).thenReturn(errorState);
      whenListen(bloc, Stream.value(errorState));

      await tester.pumpApp(
        BlocProvider.value(
          value: bloc,
          child: const SignInView(),
        ),
      );

      await tester.pump();

      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('Exception: Something went wrong'), findsOneWidget);
    });

    testWidgets('adds SignInButtonPressed when button is tapped', (
      tester,
    ) async {
      when(() => bloc.state).thenReturn(const SignInState());
      whenListen(bloc, const Stream<SignInState>.empty());

      await tester.pumpApp(
        BlocProvider.value(
          value: bloc,
          child: const SignInView(),
        ),
      );

      await tester.enterText(find.byType(TextField).first, 'test@email.com');
      await tester.enterText(find.byType(TextField).last, 'password');

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      verify(() => bloc.add(any(that: isA<SignInButtonPressed>()))).called(1);
    });
  });
}
