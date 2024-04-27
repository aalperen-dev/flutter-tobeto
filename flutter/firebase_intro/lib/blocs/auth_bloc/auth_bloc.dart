import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:firebase_intro/models/user_model.dart';
import 'package:firebase_intro/services/auth_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService authService;

  AuthBloc({
    required this.authService,
  }) : super(AuthInitial()) {
    on<SignUpUser>((event, emit) async {
      emit(AuthLoading(isLoading: true));

      try {
        final UserModel? userModel = await authService.signUpUser(
          event.email,
          event.password,
        );

        if (userModel != null) {
          emit(SignUpSuccess(userModel: userModel));
        } else {
          emit(SignUpFailure());
        }
      } catch (e) {
        if (kDebugMode) {
          print(e.toString());
        }
      }

      emit(AuthLoading(isLoading: false));
    });

    on<SignInUser>(
      (event, emit) {
        emit(AuthLoading(isLoading: true));
        try {
          authService.signInUser(event.email, event.password);
          emit(SignInUserSuccess());
        } catch (e) {
          if (kDebugMode) {
            print(e.toString());
          }
          emit(SignInUserFailure());
        }

        emit(AuthLoading(isLoading: false));
      },
    );

    on<SignOutUser>(
      (event, emit) {
        try {
          authService.signOutUser();
          emit(SignOutUserSuccess());
        } catch (e) {
          if (kDebugMode) {
            print(e.toString());
          }
          emit(SignOutUserFailure());
        }
      },
    );
  }
}
