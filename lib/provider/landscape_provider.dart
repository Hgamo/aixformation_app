import 'package:flutter/material.dart';

class LandScapeProvider extends ChangeNotifier {
  LandScapeProvider(this._curretnPostId);
  int _curretnPostId;

  void changeCurrentPost(int newPostId) {
    _curretnPostId = newPostId;
    notifyListeners();
  }

  int get currentPostId => _curretnPostId;
}
