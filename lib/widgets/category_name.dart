import 'package:aixformation_app/helper/get_categories.dart';
import 'package:aixformation_app/widgets/cat_text.dart';
import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';

class CategoryName extends StatefulWidget {
  final List categories;
  CategoryName(this.categories);

  @override
  _CategoryNameState createState() => _CategoryNameState();
}

class _CategoryNameState extends State<CategoryName>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: Duration(milliseconds: 200),
      vsync: this,
      child: FutureBuilder(
        future: GetCategories(widget.categories).getCategoriesById(),
        builder: (context, AsyncSnapshot<List<String>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Wrap(
              alignment: WrapAlignment.start,
              direction: Axis.horizontal,
              children: snapshot.data
                  .map((e) => Padding(
                        padding: const EdgeInsets.all(4),
                        child: CatText(HtmlUnescape().convert(e)),
                      ))
                  .toList(),
            );
          }
          return Container(
            height: 10,
          );
        },
      ),
    );
  }
}
