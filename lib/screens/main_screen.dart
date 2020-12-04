import 'package:aixformation_app/classes/class_post.dart';
import 'package:aixformation_app/helper/fav_helper.dart';
import 'package:aixformation_app/helper/get_posts.dart';
import 'package:aixformation_app/widgets/Fav_item.dart';
import 'package:aixformation_app/widgets/post_item.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

final List<Post> emptyPosts = [];
final List<int> emptyints = [];

class _MainScreenState extends State<MainScreen> {
  final List<Widget> pages = [
    StreamBuilder(
      initialData: emptyPosts,
      stream: GetPosts.getPosts(),
      builder: (context, AsyncSnapshot<List<Post>> snapshot) {
        final posts = snapshot.data;
        return ListView.builder(
          itemCount: posts.length,
          itemBuilder: (context, index) => PostItem(
            post: posts[index],
          ),
        );
      },
    ),
    StreamBuilder(
      stream: GetPosts.getPosts(),
      initialData: emptyPosts,
      builder: (context, AsyncSnapshot<List<Post>> snapshot) {
        final List<Post> posts = snapshot.data;
        return StreamBuilder(
          stream: FavHelper.getFavsIds,
          initialData: emptyints,
          builder: (context, AsyncSnapshot<List<int>> snapshot) {
            List<Post> favPosts = [];
            snapshot.data.forEach((element) {
              favPosts.add(posts.firstWhere((e) => e.id == element));
            });
            favPosts.sort((a, b) => b.date.compareTo(a.date));
            return ListView.builder(
              itemCount: favPosts.length,
              itemBuilder: (context, index) => FavItem(favPosts[index]),
            );
          },
        );
      },
    )
  ];
  int pagei = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        elevation: 1000,
        currentIndex: pagei,
        onTap: (value) {
          setState(() {
            pagei = value;
          });
        },
        fixedColor: Theme.of(context).accentColor,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: 'Artikel',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorieten',
          ),
        ],
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'AiXformation',
          style: GoogleFonts.arvo(),
        ),
      ),
      body: pages[pagei],
    );
  }
}
