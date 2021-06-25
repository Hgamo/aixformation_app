import 'dart:ui';

import 'package:aixformation_app/classes/class_post.dart';
import 'package:aixformation_app/helper/app_Start.dart';
import 'package:aixformation_app/helper/remote_config_helper.dart';
import 'package:aixformation_app/provider/landscape_provider.dart';
import 'package:aixformation_app/screens/post_screen.dart';
import 'package:aixformation_app/widgets/higlight_post_item.dart';
import 'package:aixformation_app/widgets/post_item.dart';
import 'package:aixformation_app/widgets/scotial_buttons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeFragment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Post> posts = Provider.of<List<Post>>(context) ?? [];
    if (posts.length == 0) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    final bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final List<Widget> widgetList = [
      SizedBox(
        height: 57,
      ),
    ];
    widgetList.add(
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          'Neueste Beiträge',
          style: Theme.of(context).textTheme.headline5,
          textAlign: TextAlign.center,
        ),
      ),
    );
    widgetList.add(CarouselSlider(
      items: [
        PostItem(
          post: posts[0],
          isLandscape: isLandscape,
          isnewesPost: true,
        ),
        PostItem(
          post: posts[1],
          isLandscape: isLandscape,
          isnewesPost: false,
        ),
        PostItem(
          post: posts[2],
          isLandscape: isLandscape,
          isnewesPost: false,
        ),
      ],
      options: CarouselOptions(
          enableInfiniteScroll: false, height: 450, viewportFraction: 0.9),
    ));
    widgetList.add(
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          'Alle Beiträge',
          style: Theme.of(context).textTheme.headline5,
          textAlign: TextAlign.center,
        ),
      ),
    );
    widgetList.addAll(
      posts.asMap().entries.map<Widget>(
            (post) => HilightPostItem(
              post: post.value,
              isLandscape: isLandscape,
              isnewesPost: post.key == 0,
            ),
          ),
    );
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
              return widgetList[index];
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
                        posts.firstWhere((element) =>
                            element.id ==
                            Provider.of<LandScapeProvider>(context)
                                .currentPostId),
                        UniqueKey(),
                      ),
              ),
            ],
          )
        : stack;
  }
}
