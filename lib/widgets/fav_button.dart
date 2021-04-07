import 'package:aixformation_app/helper/fav_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavButton extends StatelessWidget {
  final int postId;
  FavButton(this.postId);
  @override
  Widget build(BuildContext context) {
    final List<int> favIds = Provider.of<List<int>>(context);
    final bool isFav = favIds == null ? false : favIds.contains(postId);
    return IconButton(
      color: isFav ? Theme.of(context).accentColor : Colors.grey,
      icon: Icon(Icons.favorite),
      onPressed: () {
        FavHelper.changefav(postId);
      },
    );
  }
}
