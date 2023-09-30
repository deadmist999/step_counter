part of 'auth_bloc.dart';

abstract class AuthEvent {}

class CheckAuthEvent extends AuthEvent {}

class SignUpByEmailAndPasswordEvent extends AuthEvent {
  final String email;
  final String password;

  SignUpByEmailAndPasswordEvent({
    required this.email,
    required this.password,
  });
}

class SignInByEmailAndPasswordEvent extends AuthEvent {
  final String email;
  final String password;

  SignInByEmailAndPasswordEvent(this.email, this.password);
}

class LogoutEvent extends AuthEvent {}
