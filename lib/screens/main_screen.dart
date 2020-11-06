import 'package:aixformation_app/classes/class_post.dart';
import 'package:aixformation_app/helper/app_Start.dart';
import 'package:aixformation_app/helper/get_data.dart';
import 'package:aixformation_app/screens/loading_screen.dart';
import 'package:aixformation_app/widgets/fade_in.dart';
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
        List<Post> posts = snapshot.data['posts'];
        return Scaffold(
          appBar: AppBar(
            //elevation: 0,
            centerTitle: true,
            title: Text('AiXformation'),
          ),
          body: ListView.builder(
            //cacheExtent: 1000,
            itemCount: posts.length,
            itemBuilder: (context, index) => index < 3
                ? FadeIn(
                    index.toDouble() * 0.5,
                    PostItem(
                      post: posts[index],
                      authors: snapshot.data['authors'],
                      categories: snapshot.data['categories'],
                    ),
                  )
                : PostItem(
                    post: posts[index],
                    authors: snapshot.data['authors'],
                    categories: snapshot.data['categories'],
                  ),
          ),
        );
      },
    );
  }
}

/*GridView.builder(
            padding: const EdgeInsets.all(10),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: posts.length,
            itemBuilder: (context, index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return PostScreen(posts[index]);
                      },
                    ));
                  },
                  child: GridTile(
                    child: Hero(
                      tag: posts[index].id,
                      child: CachedNetworkImage(

                        imageUrl: posts[index].featuredMedia,
                        fit: BoxFit.cover,
                      ),
                    ),
                    footer: GridTileBar(
                      backgroundColor: Colors.black87,
                      title: Text(posts[index].title),
                    ),
                  ),
                ),
              );
            },
          ),*/
