import 'dart:convert';
import 'dart:ui';

import 'package:aixformation_app/classes/class_post.dart';
import 'package:aixformation_app/provider/landscape_provider.dart';
import 'package:aixformation_app/screens/post_screen.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape_small.dart';
import 'package:provider/provider.dart';

class HilightPostItem extends StatelessWidget {
  final Post post;
  final bool isnewesPost;
  final bool isLandscape;
  HilightPostItem({
    this.post,
    this.isnewesPost,
    this.isLandscape,
  });

  @override
  Widget build(BuildContext context) {
    var unescape = new HtmlUnescape();
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
                builder: (context) => PostScreen(post),
              ),
            );
          },
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Image.network(post.featuredMedia, fit: BoxFit.fill,),
              ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Container(
                    color: Colors.transparent,
                    child: Text(
                      unescape.convert(post.title),
                      style: Theme.of(context).textTheme.headline5,
                    ),
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
