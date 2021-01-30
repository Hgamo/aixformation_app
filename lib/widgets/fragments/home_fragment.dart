import 'dart:ui';

import 'package:aixformation_app/classes/class_post.dart';
import 'package:aixformation_app/helper/app_Start.dart';
import 'package:aixformation_app/helper/remote_config_helper.dart';
import 'package:aixformation_app/provider/landscape_provider.dart';
import 'package:aixformation_app/screens/post_screen.dart';
import 'package:aixformation_app/widgets/post_item.dart';
import 'package:aixformation_app/widgets/scotial_buttons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeFragment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Post> posts = Provider.of<List<Post>>(context) ?? [];
    final bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final Widget stack = Stack(
      alignment: Alignment.topLeft,
      children: [
        RefreshIndicator(
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
                isLandscape: isLandscape,
                isnewesPost: index == 1,
                post: posts[index - 1],
              );
            },
          ),
        ),
        Provider.of<RemoteConfigHelper>(context).blurButtons()
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
                color:
                    MediaQuery.of(context).platformBrightness == Brightness.dark
                        ? Colors.black26
                        : Colors.white24,
              )
            : Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                height: 50,
                child: SoctialButtons(),
              ),
      ],
    );
    return isLandscape
        ? Row(
            children: [
              Flexible(
                flex: 1,
                child: stack,
              ),
              Flexible(
                flex: 2,
                child: posts.length != 20
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : PostScreen(
                        posts.firstWhere(
                          (element) =>
                              element.id ==
                              Provider.of<LandScapeProvider>(context)
                                  .currentPostId,
                        ),
                      ),
              ),
            ],
          )
        : stack;
  }
}
