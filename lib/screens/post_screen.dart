import 'package:aixformation_app/widgets/post_body.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:html_unescape/html_unescape.dart';
import '../classes/class_post.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:share/share.dart';

class PostScreen extends StatelessWidget {
  PostScreen(this.post);
  final Post post;
  final unescape = new HtmlUnescape();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            actions: [
              IconButton(
                icon: Icon(Icons.launch),
                onPressed: () {
                  launch(
                    post.link,
                    option: CustomTabsOption(
                      enableUrlBarHiding: true,
                      showPageTitle: true,
                    ),
                  );
                },
              ),
              IconButton(
                icon: Icon(Icons.share),
                onPressed: () {
                  Share.share(post.link);
                },
              ),
            ],
            expandedHeight: MediaQuery.of(context).size.height / 3,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              //title: Text('AiXformation'),
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
                  padding: EdgeInsets.all(10),
                  child: Text(
                    unescape.convert(post.title),
                    style: GoogleFonts.arvo(
                      textStyle: TextStyle(
                        height: 1.3,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(18),
                  child: PostBody(post.contentHtml),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
