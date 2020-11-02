import 'package:aixformation_app/helper/get_posts.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthorName extends StatefulWidget {
  final int author;
  AuthorName(this.author);
  @override
  _AuthorNameState createState() => _AuthorNameState();
}

class _AuthorNameState extends State<AuthorName> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      
      curve: Curves.easeIn,
      duration: Duration(milliseconds: 200),
      vsync: this,
          child: FutureBuilder(
        future: GetPosts().getauthor(widget.author),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return MyOText(snapshot.data);
          }
          return Container(
            height: 5,
            width: 20,
          );
        },
      ),
    );
  }
}

class MyOText extends StatefulWidget {
  final String name;
  MyOText(this.name);

  @override
  _MyOTextState createState() => _MyOTextState();
}

class _MyOTextState extends State<MyOText> {
  bool vis = false;
  changeOpacity() {
    Future.delayed(Duration(seconds: 0), () {
      setState(() {
        vis = !vis;
      });
    });
  }

  @override
  void initState() {
    changeOpacity();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: vis ? 1 : 0,
      child: Text(widget.name == null ? '' : widget.name, style: GoogleFonts.ubuntu(),),
      duration: Duration(milliseconds: 200),
    );
  }
}
