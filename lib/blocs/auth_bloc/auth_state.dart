part of 'auth_bloc.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthorizedUserState extends AuthState {
  final User user;

  AuthorizedUserState(this.user);
}

class NonAuthorizedUserState extends AuthState {}

class AuthErrorState extends AuthState {
  final String message;

  AuthErrorState(this.message);
}
