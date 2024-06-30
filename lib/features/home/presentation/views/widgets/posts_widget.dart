import 'package:cached_network_image/cached_network_image.dart';
import 'package:kemet/core/utils/app_localization.dart';
import 'package:kemet/core/utils/shared_data.dart';

import 'package:kemet/features/home/presentation/manager/posts_cubit/posts_cubit.dart';
import 'package:kemet/features/home/presentation/views/widgets/post_like_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../constants.dart';

Map<String, dynamic> likes = {};
Map<String, dynamic> likesCounter = {};

class PostsWidget extends StatelessWidget {
  const PostsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<PostsCubit>(context).fetchPosts();
    final size = MediaQuery.of(context).size;
    return BlocConsumer<PostsCubit, PostsState>(
      listener: (context, state) {

      },
      builder: (context, state) {
        if (state is PostsFailure) {
          return Center(
              child: TextButton(
                  onPressed: () {
                    BlocProvider.of<PostsCubit>(context).fetchPosts();
                  },
                  child: Text("try".tr(context))));
        } else if (state is PostsSuccess) {
          var data = state.postsModel.postsAfterTranslate;

          return ListView.builder(
              itemCount: data.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                var post = data.reversed.toList()[index];
                likes[post.post.id] =
                    post.post.likes.contains(SharedData.getUserId());
                likesCounter[post.post.id] = post.post.likesCounter;
                return Padding(
                  padding: EdgeInsets.all(size.height * .01),
                  child: Card(
                    shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(size.width*0.03),
                      borderSide: BorderSide.none
                    ),
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
                              SizedBox(width: size.width*0.025,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(post.post.createdBy.userName.toString(),style: TextStyle(fontWeight: FontWeight.bold),),
                                 // SizedBox(height: size.height*0.008,),
                                  Text(post.post.createdAt,style: TextStyle(fontSize: size.width*0.02),),
                                ],
                              ),
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
                                  const Center(child: Icon(Icons.error)),
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
                                like: likes,
                                counter: likesCounter,
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
