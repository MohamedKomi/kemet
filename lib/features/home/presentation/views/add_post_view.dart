import 'package:kemet/features/home/data/repos/home_repo_implementation.dart';
import 'package:kemet/features/home/presentation/views/widgets/add_post_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/service_locator.dart';
import '../manager/add_post_cubit/add_post_cubit.dart';

class AddPostView extends StatelessWidget {
  const AddPostView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddPostCubit(sl<HomeRepoImplement>()),
      child: Scaffold(
        body: const AddPostBody(),
        appBar: AppBar(
          backgroundColor: const Color(0xfffafafa),
          elevation: 0,
        ),
      ),
    );
  }
}
