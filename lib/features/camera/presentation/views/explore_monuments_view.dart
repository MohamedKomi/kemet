import 'package:dio/dio.dart';
import 'package:kemet/constants.dart';
import 'package:kemet/core/utils/api_service.dart';
import 'package:kemet/core/utils/app_localization.dart';
import 'package:kemet/core/utils/style.dart';
import 'package:kemet/features/camera/data/video_repo/video_repo_implement.dart';
import 'package:kemet/features/camera/presentation/manager/explore_monuments_cubit/explore_monuments_cubit.dart';
import 'package:kemet/features/camera/presentation/manager/explore_monuments_cubit/explore_monuments_state.dart';
import 'package:kemet/features/camera/presentation/views/widgets/explore_monuments_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExploreMonumentsView extends StatelessWidget {
  const ExploreMonumentsView({super.key, required this.data});

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> sentData = {
      'voiceData': data['voiceData'],
      'name': '',
      'desc': '',
      'images': '',
    };

    return BlocProvider(
      create: (context) =>
          ExploreMonumentsCubit(VideoRepoImplement(ApiService(Dio())))
            ..fetchInformation(data['name']),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        body: BlocConsumer<ExploreMonumentsCubit, ExploreMonumentsState>(
          listener: (context, state) {
            if (state is FetchMonumentSuccess) {
              sentData['name'] = state.info.monumentAfterTranslate.monumentName;
              sentData['desc'] = state.info.monumentAfterTranslate.desc;
              sentData['images'] = state.info.monumentAfterTranslate.images;
            }
          },
          builder: (context, state) {
            if (state is FetchMonumentLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is FetchMonumentFailure) {
              return Center(
                child: TextButton(
                  onPressed: () {
                    BlocProvider.of<ExploreMonumentsCubit>(context)
                        .fetchInformation(data['name']);
                  },
                  child: Text(
                    "try".tr(context),
                    style: Style.textThemeW700.copyWith(color: mainColor),
                  ),
                ),
              );
            } else if (state is FetchMonumentSuccess) {
              return ExploreMonumentsBody(sentData: sentData);
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
