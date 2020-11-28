// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// class LoadingScreen extends StatefulWidget {
//   @override
//   _LoadingScreenState createState() => _LoadingScreenState();
// }

// class _LoadingScreenState extends State<LoadingScreen> {
//   @override
//   Widget build(BuildContext context) {
//     bool isdark = MediaQuery.of(context).platformBrightness == Brightness.dark;
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             LoadnigAnimation(
//               maxwidth: MediaQuery.of(context).size.width - 40,
//               child: Image.asset(
//                   isdark ? 'assets/logo_dunkel.png' : 'assets/logo_hell.png'),
//             ),
//             CircularProgressIndicator(),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class LoadnigAnimation extends StatefulWidget {
//   final Widget child;
//   final double maxwidth;
//   LoadnigAnimation({this.child, this.maxwidth});
//   @override
//   _LoadnigAnimationState createState() => _LoadnigAnimationState();
// }

// class _LoadnigAnimationState extends State<LoadnigAnimation> {
//   double width = 0;
//   double height = 0;
//   Color color = Colors.blue;
//   double radius = 5;
//   void changewidth() async {
//     setState(() {
//       if (width == widget.maxwidth / 4) {
//         width = widget.maxwidth;
//       } else {
//         width = widget.maxwidth / 4;
//       }
//     });
//     await Future.delayed(Duration(seconds: 2));
//     changewidth();
//   }

//   void someRandom() async {
//     if (!this.mounted) {
//       return;
//     }
//     setState(() {
//       width =
//           Random().nextInt((widget.maxwidth - 100).toInt()).toDouble() + 100;
//       height = Random().nextInt(100).toDouble() + 100;
//       radius = Random().nextInt(50).toDouble();
//     });
//     await Future.delayed(Duration(seconds: 2));
//     someRandom();
//   }

//   @override
//   void initState() {
//     someRandom();
//     //changewidth();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedContainer(
//       decoration: BoxDecoration(
//         color: Theme.of(context).accentColor,
//         borderRadius: BorderRadius.all(
//           Radius.circular(radius),
//         ),
//       ),
//       child: widget.child,
//       curve: Curves.easeInOutBack,
//       width: width,
//       height: height,
//       duration: Duration(seconds: 2),
//     );
//     // return AnimatedContainer(
//     //   curve: Curves.easeInOut,
//     //   width: width,
//     //   child: widget.child,
//     //   duration: Duration(seconds: 2),
//     // );
//   }
// }
