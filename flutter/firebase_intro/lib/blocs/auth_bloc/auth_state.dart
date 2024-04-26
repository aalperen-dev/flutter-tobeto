part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {
  final bool isLoading;

  AuthLoading({required this.isLoading});
}

final class AuthSuccess extends AuthState {
  final UserModel userModel;

  AuthSuccess({required this.userModel});
}

final class AuthFailure extends AuthState {
  final String errorMessage;

  AuthFailure({required this.errorMessage});
}
