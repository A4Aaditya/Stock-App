part of 'auth_bloc.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {}

class AuthUserCreated extends AuthState {}

class AuthError extends AuthState {
  AuthError({required this.message});
  final String message;
}
