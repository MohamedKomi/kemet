import 'package:kemet/features/home/presentation/views/widgets/posts_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../constants.dart';
import '../../../data/models/posts_model/post_data_model.dart';
import '../../manager/likes_cubit/likes_cubit.dart';

class LikeWidget extends StatelessWidget {
  const LikeWidget({
    Key? key,
    required this.post,
    required this.like,
    required this.counter,
  }) : super(key: key);

  final PostData post;
  final Map<String, dynamic> like;
  final Map<String, dynamic> counter;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LikesCubit, LikesState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Row(
          children: [
            IconButton(
              onPressed: () {
                BlocProvider.of<LikesCubit>(context)
                    .likes(
                        post.post.id, likes[post.post.id] ? 'dislike' : 'like')
                    .then((value) {
                  like[post.post.id] = !like[post.post.id];
                  like[post.post.id]
                      ? counter[post.post.id]++
                      : counter[post.post.id]--;
                });
              },
              icon: Icon(
                like[post.post.id] ? Icons.favorite : Icons.favorite_border,
                color: mainColor,
              ),
            ),
            Text(counter[post.post.id].toString()),
          ],
        );
      },
    );
  }
}
