import 'package:kemet/features/auth/data/repositories/auth_repo_implementation.dart';
import 'package:kemet/features/auth/presntation/maneger/generate_otp_cubit/generate_otp_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/service_locator.dart';
import 'widgets/forget_pass_body.dart';

class ForgetPassView extends StatelessWidget {
  const ForgetPassView({
    super.key,
    required this.isRegister,
  });

  final bool isRegister;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GenerateOtpCubit(sl<AuthRepoImplementation>()),
      child: Scaffold(
        body: ForgetPassBody(
          isRegister: isRegister,
        ),
      ),
    );
  }
}
