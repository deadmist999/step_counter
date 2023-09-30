import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:step_counter/services/auth_service.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService authService;

  AuthBloc(this.authService) : super(AuthInitial()) {
    on<CheckAuthEvent>((event, emit) {
      if (authService.user != null) {
        emit(AuthorizedUserState(authService.user!));
      } else {
        emit(NonAuthorizedUserState());
      }
    });

    on<SignUpByEmailAndPasswordEvent>((event, emit) async {
      emit(AuthLoadingState());
      try {
        await authService.registerUserByEmailAndPassword(
          event.email,
          event.password,
        );
        if (authService.user != null) {
          emit(AuthorizedUserState(authService.user!));
        } else {
          emit(AuthErrorState('Sign up error'));
        }
      } catch (e) {
        emit(AuthErrorState(e.toString()));
      }
    });

    on<SignInByEmailAndPasswordEvent>((event, emit) async {
      emit(AuthLoadingState());
      try {
        await authService.loginUserByEmailAndPassword(
            event.email, event.password);
        emit(AuthorizedUserState(authService.user!));
      } catch (e) {
        emit(AuthErrorState(e.toString()));
      }
    });

    on<LogoutEvent>((event, emit) async {
      emit(AuthLoadingState());
      try {
        await authService.logout();
        if (authService.user == null) {
          emit(NonAuthorizedUserState());
        }
      } catch (e) {
        emit(AuthErrorState(e.toString()));
      }
    });
  }
}
