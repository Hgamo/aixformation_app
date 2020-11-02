import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:html_unescape/html_unescape.dart';
//import 'package:url_launcher/url_launcher.dart';

import '../classes/class_post.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
            expandedHeight: MediaQuery.of(context).size.height/3,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text('AiXformation'),
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
                        
                        fontWeight: FontWeight.normal,
                        color: Theme.of(context).accentColor,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(18),
                  child: HtmlWidget(
                    post.contentHtml,
                    onTapUrl: (url) => launch(
                      url,
                      option: CustomTabsOption(
                        enableUrlBarHiding: true,
                        showPageTitle: true,
                      ),
                    ),
                    textStyle: GoogleFonts.ubuntu(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
