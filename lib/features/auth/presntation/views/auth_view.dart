import 'package:kemet/features/auth/data/repositories/auth_repo_implementation.dart';
import 'package:kemet/features/auth/presntation/maneger/auth_cubit/auth_cubit.dart';
import 'package:kemet/features/auth/presntation/views/widgets/auth_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/service_locator.dart';

class LoginViews extends StatelessWidget {
  const LoginViews({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AuthCubit(sl<AuthRepoImplementation>()),
      child: const Scaffold(
        body: AuthBody(),
      ),
    );
  }
}
