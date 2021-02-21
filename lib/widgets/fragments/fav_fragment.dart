import 'package:aixformation_app/classes/class_post.dart';
import 'package:aixformation_app/widgets/Fav_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavFragment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Post> allPosts = Provider.of<List<Post>>(context);

    final List<int> favInts = Provider.of<List<int>>(context);
    if (favInts.isEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite,
            color: Theme.of(context).accentColor,
            size: 100,
          ),
          Text('Du hast noch keine Favorieten'),
        ],
      );
    }
    List<Post> favPosts = [];
    allPosts.forEach((element) {
      if (favInts.contains(element.id)) {
        favPosts.add(element);
      }
    });
    favPosts.sort((a, b) => b.date.compareTo(a.date));
    return ListView.builder(
      itemCount: favPosts.length,
      itemBuilder: (context, index) => FavItem(favPosts[index]),
    );
  }
}
