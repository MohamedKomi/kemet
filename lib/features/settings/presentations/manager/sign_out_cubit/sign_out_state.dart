part of 'sign_out_cubit.dart';

abstract class SignOutState {}

class SignOutInitial extends SignOutState {}

class SignOutLoading extends SignOutState {}

class SignOutFailure extends SignOutState {
  final String message;

  SignOutFailure(this.message);
}

class SignOutSuccess extends SignOutState {
  final String message;

  SignOutSuccess(this.message);
}
