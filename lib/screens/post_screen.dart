import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:html_unescape/html_unescape.dart';
//import 'package:url_launcher/url_launcher.dart';

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
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(18),
                  child: HtmlWidget(
                    post.contentHtml,
                    webView: true,
                    customWidgetBuilder: (element) {
                      if (element.localName == 'ul') {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: HtmlWidget(
                            element.outerHtml,
                            textStyle: GoogleFonts.ubuntu(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      }
                      if (element.className
                          .contains('wp-block-lazyblock-einleitung')) {
                        return HtmlWidget(
                          element.innerHtml,
                          customWidgetBuilder: (e) {
                            if (e.className == 'aix-einleitung') {
                              return HtmlWidget(
                                e.innerHtml,
                                customWidgetBuilder: (el) {
                                  final List<String> strings =
                                      el.text.split('|');
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: RichText(
                                      text: TextSpan(
                                        style: GoogleFonts.ubuntu(
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .bodyText2
                                              .copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: Theme.of(context)
                                                    .accentColor,
                                              ),
                                        ),
                                        text: strings[0],
                                        children: [
                                          TextSpan(
                                            text: '|' + strings[1],
                                            style: GoogleFonts.ubuntu(
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2
                                                  .copyWith(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            }
                            return null;
                          },
                        );
                      }
                      if (element.localName == 'h4') {
                        return Text(
                          element.text,
                          style: GoogleFonts.arvo(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        );
                      }
                      return null;
                    },
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
