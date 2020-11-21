import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:google_fonts/google_fonts.dart';

class PostBody extends StatelessWidget {
  final String htmlString;
  PostBody(this.htmlString);
  @override
  Widget build(BuildContext context) {
    return HtmlWidget(
      htmlString,
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
        if (element.className.contains('wp-block-lazyblock-einleitung')) {
          return HtmlWidget(
            element.innerHtml,
            customWidgetBuilder: (e) {
              if (e.className == 'aix-einleitung') {
                return HtmlWidget(
                  e.innerHtml,
                  customWidgetBuilder: (el) {
                    final List<String> strings = el.text.split('|');
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: RichText(
                        text: TextSpan(
                          style: GoogleFonts.ubuntu(
                            textStyle:
                                Theme.of(context).textTheme.bodyText2.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).accentColor,
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
    );
  }
}