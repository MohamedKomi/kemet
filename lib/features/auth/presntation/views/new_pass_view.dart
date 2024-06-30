import 'package:kemet/features/auth/data/repositories/auth_repo_implementation.dart';
import 'package:kemet/features/auth/presntation/maneger/reset_password_cubit/reset_password_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/service_locator.dart';
import 'widgets/new_pass_body.dart';

class NewPassView extends StatelessWidget {
  const NewPassView({super.key, required this.parameters,});

  final Map<String, dynamic> parameters;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>ResetPasswordCubit(sl<AuthRepoImplementation>()),
      child: Scaffold(
        body: NewPassBody(parameters: parameters,),
      ),
    );
  }
}
