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
      textStyle: GoogleFonts.ubuntu(),
      customWidgetBuilder: (element) {
        if (element.localName == 'ul') {
          return Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: HtmlWidget(
              element.outerHtml,
              textStyle: GoogleFonts.ubuntu(
                height: 1.5,
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
                            height: 1.5,
                            textStyle:
                                Theme.of(context).textTheme.bodyText2.copyWith(
                                      height: 1.5,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).accentColor,
                                    ),
                          ),
                          text: strings[0],
                          children: [
                            TextSpan(
                              text: '|' + strings[1],
                              style: GoogleFonts.ubuntu(
                                height: 1.5,
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    .copyWith(
                                      height: 1.5,
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
