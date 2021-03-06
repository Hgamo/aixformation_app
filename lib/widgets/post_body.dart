import 'package:flutter/material.dart';
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
      webViewJs: true,
      customWidgetBuilder: (element) {
        if (element.localName == 'ul') {
          return Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: HtmlWidget(
              element.outerHtml,
              textStyle: Theme.of(context).textTheme.bodyText1.copyWith(
                    fontWeight: FontWeight.bold,
                    height: 1.3,
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
                          style: Theme.of(context).textTheme.bodyText2.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).accentColor,
                              ),
                          text: strings[0],
                          children: [
                            TextSpan(
                              text: '|' + strings[1],
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
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
        if (element.localName.contains('h')) {
          return Text(
            element.text,
            style: GoogleFonts.arvo(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              height: 1.5,
            ),
          );
        }
        if (element.className.contains('wp-block-image')) {
          return HtmlWidget(
            element.innerHtml,
          );
        }
        return null;
      },
    );
  }
}
