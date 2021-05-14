import 'dart:convert';

import 'package:app/cart.dart';
import 'package:app/favoriteDataBlock.dart';
import 'package:app/userBlock.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'item.dart';
import 'drower.dart';
import 'dart:async';
import 'cart.dart';
import 'data.dart';

class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  var data;
  var favList = [];
  var catagory = [];
  void initState() {
    super.initState();
    login();
  }

  Future login() async {
    final FavoriteBlock favoriteBlock = Provider.of(context);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String counter = prefs.getString('data');
    print(counter);
    setState(() {
      data = json.decode(counter);
    });

    setState(() {
      favList = favoriteBlock.favorite;
    });
    for (var id in favList) {
      var item = data.firstWhere((item) => item['_id'] == id);
      print(item);
      catagory.add(item);
    }
  }

  @override
  Widget build(BuildContext context) {
    final FavoriteBlock favoriteBlock = Provider.of(context);

    final DataBlock dataBlock = Provider.of(context);
    if (catagory == null) {
      return Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            'Favorite',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10,
                ),
                Text('Favorite',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    )),
                SizedBox(
                  height: 10,
                ),
                Wrap(
                  children: [
                    for (var item in catagory) Item(data: item),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Cart()),
            );
          },
          backgroundColor: Colors.pink[400],
          child: Icon(
              dataBlock.list.length == 0
                  ? Icons.shopping_cart_outlined
                  : Icons.shopping_cart,
              color: Colors.white),
        ),
        drawer: Drower(),
      );
    }
  }
}
