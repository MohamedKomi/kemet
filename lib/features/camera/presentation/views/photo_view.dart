
import 'package:dio/dio.dart';
import 'package:kemet/constants.dart';
import 'package:kemet/core/utils/api_service.dart';
import 'package:kemet/core/utils/app_localization.dart';
import 'package:kemet/core/utils/app_router.dart';
import 'package:kemet/core/utils/style.dart';
import 'package:kemet/core/widgets/custom_button.dart';
import 'package:kemet/core/widgets/custom_snack_bar.dart';
import 'package:kemet/features/camera/data/video_repo/video_repo_implement.dart';
import 'package:kemet/features/camera/presentation/manager/video_cubit/video_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class PhotoView extends StatelessWidget {
  const PhotoView({super.key, required this.data});

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text("camera".tr(context)['camera']),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Center(
                child: SizedBox(
                  width: size.width*0.9,
                  height: size.height*0.65,
                  child: Image.file(
                    data['image']!,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(
                height: size.height * .05,
              ),
              BlocProvider(
                create: (context) =>
                    VideoCubit(VideoRepoImplement(ApiService(Dio()))),
                child: BlocConsumer<VideoCubit, VideoState>(
                  listener: (context, state) {
                    print(state);
                    if (state is InfoFailure) {
                      snackBar(state.message, context, Colors.red);
                    }
                    if (state is InfoSuccess) {
                      GoRouter.of(context)
                          .pushReplacement(AppRouter.exploreMonuments, extra: {
                        'name': state.info['name'],
                        'voiceData': state.info['information']
                      });
                    }
                  },
                  builder: (context, state) {
                    if (state is VideoInitial) {
                      return CustomButton(
                        text: "button".tr(context)['cont'],
                        onPressed: () {
                          if (data['onTap'] == 'first') {
                            BlocProvider.of<VideoCubit>(context)
                                .fetchInfo(data['image'], 'en');
                          } else {
                            GoRouter.of(context).pushReplacement(AppRouter.translateView,
                                extra: data['image']);
                          }
                        },
                      );
                    } else if (state is InfoLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return TextButton(
                          onPressed: () {
                            BlocProvider.of<VideoCubit>(context)
                                .fetchInfo(data['image'], 'en');
                          },
                          child: Text(
                            "try".tr(context),
                            style:
                                Style.textThemeW700.copyWith(color: mainColor),
                          ));
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
