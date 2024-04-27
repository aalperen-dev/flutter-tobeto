part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class SignUpUser extends AuthEvent {
  final String email;
  final String password;

  SignUpUser({
    required this.email,
    required this.password,
  });
}

class SignInUser extends AuthEvent {
  final String email;
  final String password;

  SignInUser({required this.email, required this.password});
}

class SignOutUser extends AuthEvent {}
