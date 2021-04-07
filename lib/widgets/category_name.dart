import 'package:aixformation_app/classes/category.dart';
import 'package:aixformation_app/widgets/cat_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryName extends StatelessWidget {
  final List<int> categoriesId;
  CategoryName({this.categoriesId});

  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<List<Category>>(context);
    return Wrap(
      children: categoriesId
          .map(
            (e) => CatText(categories.firstWhere((element) => element.id == e)),
          )
          .toList(),
    );
  }
}
