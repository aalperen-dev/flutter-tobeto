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

class SignOut extends AuthEvent {}
