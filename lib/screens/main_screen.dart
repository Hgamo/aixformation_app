import 'package:aixformation_app/classes/class_post.dart';
import 'package:aixformation_app/helper/app_Start.dart';
import 'package:aixformation_app/helper/fav_helper.dart';
import 'package:aixformation_app/helper/get_data.dart';
import 'package:aixformation_app/screens/loading_screen.dart';
import 'package:aixformation_app/widgets/Fav_item.dart';
import 'package:aixformation_app/widgets/post_item.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppStart.onAppStrat();
    return FutureBuilder(
      future: GetData().getallData(),
      builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingScreen();
        }
        if (snapshot.connectionState == ConnectionState.done) {
          
          return MainScaffold(
            snapshot: snapshot,
          );
        }
        return Container();
      },
    );
  }
}

class MainScaffold extends StatefulWidget {
  final AsyncSnapshot snapshot;
  MainScaffold({this.snapshot});

  @override
  _MainScaffoldState createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int pagei = 0;

  @override
  Widget build(BuildContext context) {
    List<Post> posts = widget.snapshot.data['posts'];
    List<Widget> pages = [
      ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) => PostItem(
          post: posts[index],
          authors: widget.snapshot.data['authors'],
          categories: widget.snapshot.data['categories'],
        ),
      ),
      FutureBuilder(
        future: FavHelper.getonlyfavs(posts),
        builder: (context, AsyncSnapshot<List<Post>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          List<Post> favPosts = snapshot.data;
          if (favPosts.length == 0) {
            return Center(
              child: Text('Es gibt keine Favoriten'),
            );
          }
          return ListView.builder(
            itemCount: favPosts.length,
            itemBuilder: (context, index) {
              return FavItem(favPosts[index]);
            },
          );
        },
      )
    ];
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
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
        title: Text('AiXformation'),
      ),
      body: pages[pagei],
    );
  }
}
