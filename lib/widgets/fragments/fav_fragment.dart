import 'package:aixformation_app/classes/class_post.dart';
import 'package:aixformation_app/helper/fav_helper.dart';
import 'package:aixformation_app/helper/get_posts.dart';
import 'package:aixformation_app/widgets/Fav_item.dart';
import 'package:flutter/material.dart';

class FavFragment extends StatelessWidget {
  final List<int> emptyints = [];
  final List<Post> emptyPosts = [];
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: GetPosts.getPosts(),
      initialData: emptyPosts,
      builder: (context, AsyncSnapshot<List<Post>> snapshot) {
        final List<Post> posts = snapshot.data;
        return StreamBuilder<List<int>>(
          stream: FavHelper.getFavsIds,
          initialData: emptyints,
          builder: (context, AsyncSnapshot<List<int>> snapshot) {
            List<Post> favPosts = [];
            snapshot.data.forEach((element) {
              favPosts.add(posts.firstWhere((e) => e.id == element));
            });
            favPosts.sort((a, b) => b.date.compareTo(a.date));
            return ListView.builder(
              itemCount: favPosts.length,
              itemBuilder: (context, index) => FavItem(favPosts[index]),
            );
          },
        );
      },
    );
  }
}
