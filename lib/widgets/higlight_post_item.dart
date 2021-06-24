import 'dart:convert';
import 'dart:ui';

import 'package:aixformation_app/classes/class_post.dart';
import 'package:aixformation_app/helper/my_time.dart';
import 'package:aixformation_app/provider/landscape_provider.dart';
import 'package:aixformation_app/screens/post_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape_small.dart';
import 'package:provider/provider.dart';

class HilightPostItem extends StatelessWidget {
  final Post post;
  final bool isnewesPost;
  final bool isLandscape;
  final heroTag = UniqueKey();
  HilightPostItem({
    this.post,
    this.isnewesPost,
    this.isLandscape,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Material(
        elevation: 5,
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: InkWell(
          onTap: () {
            if (isnewesPost) {
              FirebaseAnalytics().logEvent(name: 'open_newest_post');
            }
            if (isLandscape) {
              context.read<LandScapeProvider>().changeCurrentPost(post.id);
              return;
            }
            Navigator.of(context).push(
              MaterialPageRoute(
                settings: RouteSettings(name: 'PostScreen ${post.id}'),
                builder: (context) => PostScreen(post, heroTag),
              ),
            );
          },
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Hero(
                  tag: heroTag,
                  child: CachedNetworkImage(
                    fadeInDuration: Duration(milliseconds: 0),
                    imageUrl: post.featuredMedia,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Flexible(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 5,
                    right: 5,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        HtmlUnescape().convert(post.title),
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                      Text(MyTime.dateToText(post.date)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
