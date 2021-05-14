import 'package:flutter/material.dart';

class UserBlock extends ChangeNotifier {
  var _user;
  get user => _user;

  set user(var data) {
    _user = data;
    notifyListeners();
  }

  setUser(var data) {
    user = data;
  }
}
