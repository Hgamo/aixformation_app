import 'package:aixformation_app/classes/class_post.dart';
import 'package:aixformation_app/helper/my_time.dart';
import 'package:aixformation_app/screens/post_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FavItem extends StatelessWidget {
  final Post post;
  FavItem(this.post);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return PostScreen(post);
            },
          ),
        ),
        leading: Hero(
          tag: post.id,
          child: CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: post.featuredMedia,
          ),
        ),
        title: Text(
          post.title,
          style: GoogleFonts.arvo(
            textStyle: TextStyle(
              color: Theme.of(context).accentColor,
            ),
          ),
        ),
        subtitle: Text(
          dateToText(post.date),
          style: GoogleFonts.ubuntu(),
        ),
      ),
    );
  }
}
