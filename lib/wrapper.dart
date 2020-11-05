//import 'package:aixformation_app/screens/404_screen.dart';
import 'package:aixformation_app/screens/main_screen.dart';
import 'package:flutter/material.dart';
//import 'package:data_connection_checker/data_connection_checker.dart';

//import 'screens/loading_screen.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainScreen();
    // return StreamBuilder(
    //   stream: DataConnectionChecker().onStatusChange,
    //   builder: (context, AsyncSnapshot<DataConnectionStatus> snapshot) {
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return LoadingScreen();
    //     }
    //     if (snapshot.data == DataConnectionStatus.connected) {
    //       return MainScreen();
    //     }
    //     if (snapshot.data == DataConnectionStatus.disconnected) {
    //       return E404Screen();
    //     }
    //     return LoadingScreen();
    //   },
    // );
  }
}
