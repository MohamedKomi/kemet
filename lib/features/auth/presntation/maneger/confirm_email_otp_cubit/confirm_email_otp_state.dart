
import 'package:flutter/material.dart';

import '../../../data/models/ConfirmEmailModel.dart';

@immutable
abstract class ConfirmEmailByOTPState {}

class ConfirmEmailInitial extends ConfirmEmailByOTPState {}
class ConfirmEmailLoading extends ConfirmEmailByOTPState {}
class ConfirmEmailSuccess extends ConfirmEmailByOTPState {
  final ConfirmEmailModel verifyOtpModel;

  ConfirmEmailSuccess(this.verifyOtpModel);
}
class ConfirmEmailFailure extends ConfirmEmailByOTPState {
  final String errorMessage;

  ConfirmEmailFailure(this.errorMessage);
}
