part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

// auth
final class AuthLoading extends AuthState {
  final bool isLoading;

  AuthLoading({required this.isLoading});
}

// kayıt
final class SignUpSuccess extends AuthState {
  final UserModel userModel;

  SignUpSuccess({required this.userModel});
}

final class SignUpFailure extends AuthState {}

// giriş
class SignInUserSuccess extends AuthState {}

class SignInUserFailure extends AuthState {}

// çıkış
class SignOutUserSuccess extends AuthState {}

class SignOutUserFailure extends AuthState {}
