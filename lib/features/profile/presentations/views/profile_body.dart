import 'package:cached_network_image/cached_network_image.dart';
import 'package:kemet/core/utils/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../constants.dart';
import '../../../../core/utils/service_locator.dart';
import '../../../../core/utils/shared_data.dart';
import '../../../../core/utils/style.dart';
import '../../../home/presentation/views/widgets/post_like_widget.dart';
import '../../../settings/presentations/views/widgets/account_details.dart';
import '../../data/repos/profile_repo_implements.dart';
import '../manager/pofil_post_cubit/profile_post_cubit.dart';

Map<String, dynamic> profileLikes = {};
Map<String, dynamic> profileLikesCounter = {};

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return BlocProvider(
      create: (context) =>
          ProfileCubit(sl<ProfileRepoImplements>())..fetchUserPosts(),
      child: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height * 0.05,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * .04,
                  vertical: size.width * .02,
                ),
                child: const AccountDetailsSetting(),
              ),
              SizedBox(
                height: size.height * 0.022,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * .04),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${"profile".tr(context)[0]} :  ${SharedData.getUserPhone()}',
                      style: Style.textThemeW700,
                    ),
                    Text(
                      '${"profile".tr(context)[1]} :  ${SharedData.getUserAge()}',
                      style: Style.textThemeW700,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.022,
              ),
              Container(
                width: size.width,
                height: size.height * 0.001,
                color: mainColor,
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Center(
                child: SizedBox(
                  height: size.height * 0.05,
                  child: Text(
                    "profile".tr(context)[2],
                    style: Style.textThemeW700
                        .copyWith(fontSize: size.width * .05),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              ProfilePosts(size: size)
            ],
          ),
        ),
      ),
    );
  }
}

class ProfilePosts extends StatelessWidget {
  const ProfilePosts({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfilePostState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is ProfilePostFailure) {
          return Center(
            child: Text(state.errorMessage),
          );
        } else if (state is ProfilePostSuccess) {
          final data = state.data.postsAfterTranslate;
          return ListView.builder(
              itemCount: data.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final post = data.reversed.toList()[index];
                profileLikes[post.post.id] =
                    post.post.likes.contains(SharedData.getUserId());
                profileLikesCounter[post.post.id] = post.post.likesCounter;
                return Padding(
                  padding: EdgeInsets.all(size.height * .01),
                  child: Card(
                    elevation: 20,
                    child: Padding(
                      padding: EdgeInsets.all(size.height * .01),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.white60,
                                backgroundImage: NetworkImage(
                                    post.post.createdBy.profilePic!.secureUrl!),
                                radius: size.width * 0.06,
                              ),
                              const Spacer(),
                              PopupMenuButton(itemBuilder: (context) {
                                return  [
                                  // PopupMenuItem<int>(
                                  //   value: 0,
                                  //   child: Text("Edit post"),
                                  // ),
                                  PopupMenuItem<int>(
                                    value: 1,
                                    child: Text("delPost".tr(context)),
                                  ),
                                ];
                              }, onSelected: (value) {
                                if (value == 0) {
                                  print("Edit post menu is selected.");
                                } else  {
                                  data.removeAt(index);
                                  BlocProvider.of<ProfileCubit>(context).deleteUserPosts(post.post.id);
                                }
                              }),
                            ],
                          ),
                          SizedBox(
                            height: size.height * .01,
                          ),
                          Text(post.descAfterTranslate),
                          SizedBox(
                            height: size.height * .01,
                          ),
                          AspectRatio(
                            aspectRatio: size.height / size.width,
                            child: CachedNetworkImage(
                              placeholder: (context, url) => Shimmer.fromColors(
                                baseColor: const Color(0xfffef9d8),
                                highlightColor: const Color(0xffd8ae2e),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                              ),
                              fit: BoxFit.fill,
                              imageUrl: post.post.images[0].secureUrl,
                              errorWidget: (context, url, error) =>
                                  const Center(
                                child: Icon(Icons.error),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: size.height * .01,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              LikeWidget(
                                post: post,
                                like: profileLikes,
                                counter: profileLikesCounter,
                              ),
                              IconButton(
                                  onPressed: () async {
                                    Uri url = Uri.parse(post.post.location);
                                    if (await canLaunchUrl(url)) {
                                      await launchUrl(url);
                                    }
                                  },
                                  icon: Icon(
                                    Icons.location_on_outlined,
                                    color: mainColor,
                                  )),
                              IconButton(
                                  onPressed: () async {
                                    await Share.share(
                                      '${"share".tr(context)[0]}\n${post.descAfterTranslate}\n\n${"share".tr(context)[1]}\n${post.post.images[0].secureUrl}',
                                    );
                                  },
                                  icon: Icon(
                                    Icons.reply,
                                    color: mainColor,
                                  )),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              });
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
