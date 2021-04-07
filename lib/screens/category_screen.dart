import 'package:aixformation_app/classes/category.dart';
import 'package:aixformation_app/classes/class_post.dart';
import 'package:aixformation_app/widgets/Fav_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatelessWidget {
  final Category category;
  CategoryScreen(this.category);
  @override
  Widget build(BuildContext context) {
    final List<Post> posts = Provider.of<List<Post>>(context);
    List<Post> catposts = posts
        .where((element) => element.categoriesId.contains(category.id))
        .toList();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context)
                  .popUntil((route) => route.settings.name == '/');
            }),
        centerTitle: true,
        textTheme: Theme.of(context).textTheme,
        title: Text(category.name),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) => FavItem(catposts[index]),
        itemCount: catposts.length,
      ),
    );
  }
}
