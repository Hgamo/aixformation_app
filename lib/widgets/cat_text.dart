import 'package:aixformation_app/classes/category.dart';
import 'package:aixformation_app/screens/category_screen.dart';
import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape_small.dart';

class CatText extends StatelessWidget {
  final Category cat;
  CatText(this.cat);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              settings: RouteSettings(
                name: 'Category ${cat.id} screen'
              ),
              builder: (context) => CategoryScreen(cat),
            ),
          );
        },
        child: Chip(
          elevation: 5,
          backgroundColor: Theme.of(context).accentColor,
          label: Text(
            HtmlUnescape().convert(cat.name),
            style: TextStyle(color: Colors.white, height: 1),
          ),
        ),
      ),
    );
  }
}
