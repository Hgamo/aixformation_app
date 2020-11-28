import 'package:aixformation_app/classes/class_post.dart';
import 'package:aixformation_app/helper/my_time.dart';
import 'package:aixformation_app/screens/post_screen.dart';
import 'package:aixformation_app/widgets/author_name.dart';
import 'package:aixformation_app/widgets/category_name.dart';
import 'package:aixformation_app/widgets/fav_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:html_unescape/html_unescape.dart';

class PostItem extends StatelessWidget {
  final Post post;
  PostItem({
    this.post,
  });
  @override
  Widget build(BuildContext context) {
    var unescape = new HtmlUnescape();
    return Container(
      padding: EdgeInsets.all(5),
      child: GestureDetector(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return PostScreen(post);
            },
          ),
        ),
        child: Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Hero(
                    tag: post.id,
                    child: CachedNetworkImage(
                      fadeInDuration: Duration(milliseconds: 0),
                      progressIndicatorBuilder: (context, url, progress) {
                        return Container(
                          height: 200,
                        );
                      },
                      imageUrl: post.featuredMedia,
                      fit: BoxFit.cover,
                    ),
                  ),
                  CategoryName(
                    categoriesId: post.categoriesId,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: Text(
                  unescape.convert(post.title),
                  style: GoogleFonts.arvo(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: HtmlWidget(
                  post.excerptHtml,
                  hyperlinkColor: Theme.of(context).textTheme.bodyText2.color,
                  textStyle: GoogleFonts.ubuntu(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    AuthorName(
                      authorId: post.authorId,
                    ),
                    SizedBox(width: 5),
                    Text(
                      MyTime.dateToText(post.date),
                      style: GoogleFonts.ubuntu(),
                    ),
                    Spacer(),
                    FavButton(post.id),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
