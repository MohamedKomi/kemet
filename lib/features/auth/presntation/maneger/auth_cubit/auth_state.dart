part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final AuthModel authModel;

  AuthSuccess(this.authModel);
}

class AuthFailure extends AuthState {
  final String errMessage;

  AuthFailure(this.errMessage);
}
