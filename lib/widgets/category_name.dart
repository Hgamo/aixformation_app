import 'package:aixformation_app/classes/category.dart';
import 'package:aixformation_app/helper/get_categories.dart';
import 'package:aixformation_app/widgets/cat_text.dart';
import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';

class CategoryName extends StatelessWidget {
  final List<int> categoriesId;
  CategoryName({this.categoriesId});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: categoriesId.map((e) => CategoryText(e)).toList(),
    );
  }
}

class CategoryText extends StatelessWidget {
  final int categoryId;
  CategoryText(this.categoryId);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: GetCategories.getCategoryById(categoryId),
      builder: (context, AsyncSnapshot<Category> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return CatText(HtmlUnescape().convert(snapshot.data.name));
        }
        return Container();
      },
    );
  }
}
