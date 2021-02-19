import 'package:aixformation_app/classes/class_post.dart';
import 'package:aixformation_app/classes/comment.dart';
import 'package:aixformation_app/helper/comment_helper.dart';
import 'package:aixformation_app/shared/website_screen.dart';
import 'package:aixformation_app/widgets/comment_item.dart';
import 'package:flutter/material.dart';

class CommentsWidget extends StatelessWidget {
  CommentsWidget(this.post);
  final Post post;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Comment>>(
      future: CommentHelper.getComments(post.id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final List<Comment> comments = snapshot.data ?? [];
          comments.sort((a, b) => b.date.compareTo(a.date));
          return Column(
            children: [
              Text('Kommentare'),
              ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  backgroundColor:
                      MaterialStateProperty.all(Theme.of(context).accentColor),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                ),
                child: Text('Hinterlasse einen Kommentar'),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    settings:
                        RouteSettings(name: 'new Comment Post: ${post.id}'),
                    builder: (context) => WebsiteScreen(
                      title: 'Kommentar',
                      url: post.link + '#commentform',
                    ),
                  ),
                ),
              ),
              Column(
                children: comments
                    .map(
                      (e) => Column(
                        children: [
                          CommentItem(e),
                          Divider(),
                        ],
                      ),
                    )
                    .toList(),
              ),
            ],
          );
        } else {
          return Column(
            children: [
              CircularProgressIndicator(),
              Text('Die Kommentare werden geladen')
            ],
          );
        }
      },
    );
  }
}
