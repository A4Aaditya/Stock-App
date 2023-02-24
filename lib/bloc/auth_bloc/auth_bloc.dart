import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_app/repository/auth_repository.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this.repository) : super(AuthInitial()) {
    on<AuthLogin>(_login);
    on<AuthSignup>(_signup);
  }
  AuthRepository repository;

  FutureOr<void> _login(
    AuthLogin event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final response = await repository.loginWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      if (response != null) {
        emit(AuthSuccess());
      } else {
        emit(AuthError(message: 'User not found ? Please signup'));
      }
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  FutureOr<void> _signup(
    AuthSignup event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final response = await repository.signupWithEmailAndPassword(
          email: event.email, password: event.password);

      if (response != null) {
        emit(AuthUserCreated());
      } else {
        emit(AuthError(message: 'User not created '));
      }
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }
}
