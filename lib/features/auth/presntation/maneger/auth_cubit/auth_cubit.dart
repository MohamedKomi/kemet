import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/auth_model.dart';
import '../../../data/repositories/auth_repo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  bool isLogin = true;

  void onPressed() {
    isLogin = !isLogin;
    emit(AuthInitial());
  }

  AuthCubit(this.authRepo) : super(AuthInitial());
  final AuthRepo authRepo;

  Future<void> login({required String email, required String password}) async {
    emit(AuthLoading());
    final res = await authRepo.login(email, password);

    res.fold((failure) {
      emit(AuthFailure(failure.errorMessage));
    }, (login) {
      emit(AuthSuccess(login));
    });
  }

  Future<void> register(
      {required String email,
      required String password,
      required String confirmPassword,
      required String phone,
      required String firstName,
      required String lastName,
      required int age,
      required String gender}) async {
    emit(AuthLoading());
    final res = await authRepo.register(
      email,
      password,
      confirmPassword,
      phone,
      firstName,
      lastName,
      age,
      gender,
    );

    res.fold((failure) {
      emit(AuthFailure(failure.errorMessage));
    }, (register) {
      emit(AuthSuccess(register));
    });
  }
}
