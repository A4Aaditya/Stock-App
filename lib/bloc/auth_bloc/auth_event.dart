part of 'auth_bloc.dart';

abstract class AuthEvent {}

class AuthLogin extends AuthEvent {
  AuthLogin({
    required this.email,
    required this.password,
  });
  final String email;
  final String password;
}

class AuthSignup extends AuthEvent {
  AuthSignup({
    required this.email,
    required this.password,
  });
  final String email;
  final String password;
}
