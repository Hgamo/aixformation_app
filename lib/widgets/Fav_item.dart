import 'package:aixformation_app/classes/class_post.dart';
import 'package:aixformation_app/helper/my_time.dart';
import 'package:aixformation_app/screens/post_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:html_unescape/html_unescape.dart';

class FavItem extends StatelessWidget {
  final Post post;
  FavItem(this.post);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
      child: GestureDetector(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            settings: RouteSettings(name: 'FavScreen ${post.id}'),
            builder: (context) {
              return PostScreen(post);
            },
          ),
        ),
        child: Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          child: Row(
            children: [
              Flexible(
                flex: 2,
                child: Hero(
                  tag: post.id,
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
                        style: GoogleFonts.arvo(
                          textStyle: TextStyle(
                            height: 1.3,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Text(
                        MyTime.dateToText(post.date),
                        style: GoogleFonts.ubuntu(
                          height: 1.5,
                        ),
                      ),
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
