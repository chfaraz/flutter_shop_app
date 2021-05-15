import 'dart:convert';

import 'package:app/cart.dart';
import 'package:app/detail.dart';
import 'package:app/favItem.dart';
import 'package:app/favoriteDataBlock.dart';
import 'package:app/userBlock.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'bottomAppBar.dart';
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
    getData();
  }

  Future getData() async {
    catagory.clear();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String counter = prefs.getString('data');
    String fav = prefs.getString('fav');
    print(counter);
    setState(() {
      data = json.decode(counter);
    });

    setState(() {
      favList = json.decode(fav);
    });
    for (var id in favList) {
      var item = data.firstWhere((item) => item['_id'] == id);
      print(item);
      catagory.add(item);
    }
  }

  @override
  Widget build(BuildContext context) {
    var image;
    final FavoriteBlock favoriteBlock = Provider.of(context);

    final DataBlock dataBlock = Provider.of(context);
    if (catagory == null) {
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
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text("nothing in favorits.")],
          ),
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
                    for (var item in catagory)
                      GestureDetector(
                          onTap: () {
                            var pre = item['image'].toString();
                            image = 'http://192.168.0.100:4000/' +
                                pre.substring(0, 7) +
                                '/' +
                                pre.substring(8);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ItemDetail(
                                  id: item['_id'],
                                  image: image,
                                  title: item['title'],
                                  price: item['price'],
                                  detail: item['description'],
                                  quantity: item['quantity'],
                                  catagory: item['catagory'],
                                ),
                              ),
                            ).then((value) => getData());
                          },
                          child: FavItem(data: item)),
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
        bottomNavigationBar: BottomBar(active: 'fav'),
        drawer: Drower(),
      );
    }
  }
}
