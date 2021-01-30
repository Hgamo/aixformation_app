import 'package:aixformation_app/classes/author.dart';
import 'package:aixformation_app/helper/my_time.dart';
import 'package:aixformation_app/helper/remote_config_helper.dart';
import 'package:aixformation_app/shared/website_screen.dart';
import 'package:aixformation_app/widgets/author_name.dart';
import 'package:aixformation_app/widgets/author_widget.dart';
import 'package:aixformation_app/widgets/comments_widget.dart';
import 'package:aixformation_app/widgets/fav_button.dart';
import 'package:aixformation_app/widgets/post_body.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:provider/provider.dart';
import '../classes/class_post.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:share/share.dart';

class PostScreen extends StatelessWidget {
  PostScreen(this.post);
  final Post post;
  final unescape = HtmlUnescape();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        cacheExtent: 1000000,
        slivers: <Widget>[
          SliverAppBar(
            actions: [
              IconButton(
                icon: Icon(Icons.launch),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      settings:
                          RouteSettings(name: 'WebsiteScreen Post ${post.id}'),
                      builder: (context) => WebsiteScreen(
                        title: unescape.convert(post.title),
                        url: post.link + '?amp',
                      ),
                    ),
                  );
                },
              ),
              IconButton(
                icon: Icon(Icons.share),
                onPressed: () {
                  FirebaseAnalytics().logShare(
                    contentType: 'post',
                    itemId: post.id.toString(),
                    method: 'standard',
                  );
                  Share.share(post.link);
                },
              ),
            ],
            expandedHeight: MediaQuery.of(context).size.height / 3,
            pinned: context.watch<RemoteConfigHelper>().pinnedAppBar(),
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: post.id,
                child: CachedNetworkImage(
                  imageUrl: post.featuredMedia,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
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
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  child: Text(
                    unescape.convert(post.title),
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: PostBody(post.contentHtml),
                ),
                AuthorWidget(
                  context.watch<List<Author>>().firstWhere(
                        (element) => element.id == post.authorId,
                        orElse: () => Author(),
                      ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: CommentsWidget(post),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
