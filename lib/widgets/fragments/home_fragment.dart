import 'dart:ui';

import 'package:aixformation_app/classes/class_post.dart';
import 'package:aixformation_app/helper/app_Start.dart';
import 'package:aixformation_app/helper/get_posts.dart';
import 'package:aixformation_app/helper/remote_config_helper.dart';
import 'package:aixformation_app/widgets/post_item.dart';
import 'package:aixformation_app/widgets/scotial_buttons.dart';
import 'package:flutter/material.dart';

class HomeFragment extends StatelessWidget {
  final List<Post> emptyPosts = [];
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topLeft,
      children: [
        StreamBuilder(
          initialData: emptyPosts,
          stream: GetPosts.getPosts(),
          builder: (context, AsyncSnapshot<List<Post>> snapshot) {
            final posts = snapshot.data;
            return RefreshIndicator(
              onRefresh: () async {
                await AppStart.onAppStrat();
              },
              child: ListView.builder(
                itemCount: posts.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return SizedBox(
                      height: 57,
                    );
                  }
                  return PostItem(
                    isnewesPost: index==1,
                    post: posts[index-1],
                  );
                },
              ),
            );
          },
        ),
        FutureBuilder(
          initialData: true,
          future: RemoteConfigHelper.blurButtons(),
          builder: (context, AsyncSnapshot<bool> snapshot) {
            return snapshot.data?? true
                ? Container(
                    child: ClipRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 5,
                          sigmaY: 5,
                        ),
                        child: SoctialButtons(),
                      ),
                    ),
                    height: 50,
                    color: MediaQuery.of(context).platformBrightness ==
                            Brightness.dark
                        ? Colors.black26
                        : Colors.white24,
                  )
                : Container(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    height: 50,
                    child: SoctialButtons(),
                  );
          },
        ),
      ],
    );
  }
}
