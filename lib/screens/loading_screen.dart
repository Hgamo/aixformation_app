import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool isdark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
                padding: const EdgeInsets.all(20.0),
                child: FutureBuilder(
                  future: load('assets/logo_dunkel.png'),
                  builder: (context, AsyncSnapshot<ui.Image> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container();
                    }
                    return RawImage(
                      image: snapshot.data,
                      invertColors: isdark ? false : true,
                    );
                  },
                )),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}

Future<ui.Image> load(String asset) async {
  ByteData data = await rootBundle.load(asset);
  ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
  ui.FrameInfo fi = await codec.getNextFrame();
  return fi.image;
}