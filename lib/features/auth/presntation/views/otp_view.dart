import 'package:kemet/features/auth/data/repositories/auth_repo_implementation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/service_locator.dart';
import '../maneger/confirm_email_otp_cubit/confirm_email_otp_cubit.dart';
import '../maneger/generate_otp_cubit/generate_otp_cubit.dart';
import 'widgets/otp_body.dart';

class OTPView extends StatelessWidget {
  const OTPView({
    super.key,
    required this.parameters,
  });

  final Map<String, dynamic> parameters;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        BlocProvider(create: (context) =>  ConfirmEmailByOTPCubit(sl<AuthRepoImplementation>()),),
        BlocProvider(create: (context) => GenerateOtpCubit(sl<AuthRepoImplementation>()),),
      ],
      child: Scaffold(
        body: OTPBody(
          parameters: parameters,
        ),
      ),
    );
  }
}
