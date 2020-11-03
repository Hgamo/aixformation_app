import 'package:aixformation_app/helper/get_categories.dart';
import 'package:aixformation_app/widgets/cat_text.dart';
import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';

class CategoryName extends StatelessWidget {
  final List categories;
  final List allcategories;
  CategoryName({this.categories, this.allcategories});

  @override
  Widget build(BuildContext context) {
    List thiscategories = [];
    allcategories.forEach((element) {
      if (categories.contains(element.id)) {
        thiscategories.add(element.name);
      }
    });

    return Wrap(
      alignment: WrapAlignment.start,
      direction: Axis.horizontal,
      children: thiscategories
          .map((e) => Padding(
                padding: const EdgeInsets.all(4),
                child: CatText(HtmlUnescape().convert(e)),
              ))
          .toList(),
    );
  }
}
