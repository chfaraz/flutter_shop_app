import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteBlock extends ChangeNotifier {
  List _favorite = [];

  get favorite => _favorite;

  set favorite(var data) {
    _favorite.add(data);
    notifyListeners();
  }

  setFavorite(var data) {
    favorite = data;
    setfav();
    print(favorite);
  }

  removeFavorite(var id) {
    var item = favorite.where((item) => (item != id)).toList();

    _favorite = item;
    setfav();

    print(favorite);
  }

  Future setfav() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var storedData = json.encode(favorite);
    await prefs.setString('fav', storedData);
  }

  Future getfav() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String fav = prefs.getString('fav');
    if (fav != null) {
      _favorite = json.decode(fav);
    }
  }
}
// String data = prefs.getString('fav');
//     print(data);
//       favorite = json.decode(counter);
