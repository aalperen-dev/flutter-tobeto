import 'package:bloc/bloc.dart';
import 'package:firebase_intro/models/user_model.dart';
import 'package:firebase_intro/services/auth_service.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService authService = AuthService();

  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) {});

    on<SignUpUser>((event, emit) async {
      emit(AuthLoading(isLoading: true));

      try {
        final UserModel? userModel = await authService.signUpUser(
          event.email,
          event.password,
        );

        if (userModel != null) {
          emit(AuthSuccess(userModel: userModel));
        } else {
          emit(AuthFailure(errorMessage: 'Create User Failed'));
        }
      } catch (e) {
        print(e.toString());
      }

      emit(AuthLoading(isLoading: false));
    });

    on<SignOut>(
      (event, emit) {
        emit(AuthLoading(isLoading: true));

        try {
          authService.signOutUser();
        } catch (e) {
          print(e.toString());
        }
        emit(AuthLoading(isLoading: false));
      },
    );
  }
}
