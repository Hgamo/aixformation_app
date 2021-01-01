import 'package:aixformation_app/classes/class_post.dart';
import 'package:aixformation_app/helper/app_Start.dart';
import 'package:aixformation_app/helper/get_posts.dart';
import 'package:aixformation_app/widgets/post_item.dart';
import 'package:flutter/material.dart';

class HomePosts extends StatelessWidget {
  final List<Post> emptyPosts = [];
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      initialData: emptyPosts,
      stream: GetPosts.getPosts(),
      builder: (context, AsyncSnapshot<List<Post>> snapshot) {
        final posts = snapshot.data;
        return RefreshIndicator(
          onRefresh: () async {
            await AppStart.onAppStrat();
          },
          child: ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) => PostItem(
              post: posts[index],
            ),
          ),
        );
      },
    );
  }
}
