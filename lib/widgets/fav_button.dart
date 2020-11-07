import 'package:aixformation_app/helper/auth_helper.dart';
import 'package:aixformation_app/helper/fav_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FavButton extends StatelessWidget {
  final int postId;
  FavButton(this.postId);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('fav')
          .doc(Auth.getAuthstae().uid)
          .snapshots(),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return IconButton(
            onPressed: () {},
            color: Colors.grey,
            icon: Icon(Icons.favorite),
          );
        }
        var data = snapshot.data.data();
        bool isfav;
        if (data[postId.toString()] == null) {
          isfav = false;
        } else {
          isfav = data[postId.toString()];
        }
        return IconButton(
          icon: Icon(Icons.favorite),
          onPressed: () {
            FavHelper.changefav(postId);
          },
          color: isfav ? Colors.pink : Colors.grey,
        );
      },
    );
  }
}
