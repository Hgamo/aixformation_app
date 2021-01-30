import 'package:aixformation_app/classes/class_post.dart';
import 'package:aixformation_app/helper/my_time.dart';
import 'package:aixformation_app/provider/landscape_provider.dart';
import 'package:aixformation_app/screens/post_screen.dart';
import 'package:aixformation_app/widgets/author_name.dart';
import 'package:aixformation_app/widgets/category_name.dart';
import 'package:aixformation_app/widgets/fav_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:provider/provider.dart';

class PostItem extends StatelessWidget {
  final Post post;
  final bool isnewesPost;
  final bool isLandscape;
  PostItem({
    this.post,
    this.isnewesPost,
    this.isLandscape,
  });
  @override
  Widget build(BuildContext context) {
    var unescape = new HtmlUnescape();
    return Padding(
      padding: EdgeInsets.all(5),
      child: Material(
        elevation: 5,
        clipBehavior: Clip.antiAliasWithSaveLayer,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Hero(
                    tag: isLandscape ? GlobalKey() : post.id,
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
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: HtmlWidget(
                  post.excerptHtml,
                  customWidgetBuilder: (element) {
                    return HtmlWidget(
                      element.innerHtml,
                      customWidgetBuilder: (element) {
                        return Text(
                          element.innerHtml.split('<a')[0],
                          style: GoogleFonts.ubuntu(),
                          maxLines: 2,
                        );
                      },
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, top: 5),
                child: Wrap(
                  direction: Axis.horizontal,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  //alignment: WrapAlignment.,
                  //mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    AuthorName(
                      authorId: post.authorId,
                    ),
                    SizedBox(width: 5),
                    Text(MyTime.dateToText(post.date)),
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
