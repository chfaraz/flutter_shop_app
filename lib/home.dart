import 'dart:convert';

import 'package:app/bottomAppBar.dart';
import 'package:app/cart.dart';
import 'package:app/favoriteDataBlock.dart';
import 'package:app/itemsPage.dart';
import 'package:app/userBlock.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'item.dart';
import 'drower.dart';
import 'dart:async';
import 'package:dio/dio.dart';
import 'cart.dart';
import 'data.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var name;
  var data;
  var dio = Dio();
  var women;
  var men;
  var child;
  void initState() {
    super.initState();
    login();
  }

  Future login() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String counter = prefs.getString('data');
    print(counter);
    setState(() {
      data = json.decode(counter);
    });
    final response = await dio.get('http://192.168.0.100:4000');

    var storedData = json.encode(response.data);
    await prefs.setString('data', storedData);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      setState(() {
        data = response.data;
      });
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    final DataBlock dataBlock = Provider.of(context);
    final FavoriteBlock favoriteBlock = Provider.of(context, listen: false);
    final UserBlock userBlock = Provider.of(context, listen: false);
    favoriteBlock.getfav();
    // name = userBlock.user['name'];
    if (data == null) {
      return Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      );
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // Add Your Code here.

        dataBlock.setData(data);
        dataBlock.setAdd(51111);
      });
      women = data.where((i) => i['catagory'].toString() == 'women').toList();
      men = data.where((i) => i['catagory'].toString() == 'men').toList();
      child = data.where((i) => i['catagory'].toString() == 'child').toList();
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            "Welcome $name",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Container(
          color: Colors.white,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text('WOMEN',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Item(data: women[0]),
                        Item(data: women[1]),
                        Item(data: women[2]),
                        Item(data: women[3]),
                        Container(
                          width: 100,
                          margin: EdgeInsets.fromLTRB(48, 0, 48, 0),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ItemsPage(
                                    name: 'Women',
                                  ),
                                ),
                              );
                            },
                            child: Text('View More'),
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  return Colors.pink[400];
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text('MEN',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Item(data: men[0]),
                        Item(data: men[1]),
                        Item(data: men[2]),
                        Item(data: men[3]),
                        Container(
                          width: 100,
                          margin: EdgeInsets.fromLTRB(48, 0, 48, 0),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ItemsPage(
                                    name: 'Men',
                                  ),
                                ),
                              );
                            },
                            child: Text('View More'),
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  return Colors.pink[400];
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text('CHILDREN',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Item(data: child[0]),
                        Item(data: child[1]),
                        Item(data: child[2]),
                        Item(data: child[3]),
                        Container(
                          width: 100,
                          margin: EdgeInsets.fromLTRB(48, 0, 48, 0),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ItemsPage(
                                    name: 'child',
                                  ),
                                ),
                              );
                            },
                            child: Text('View More'),
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  return Colors.pink[400];
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  )
                ],
              ),
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
        bottomNavigationBar: BottomBar(active: 'home'),
        drawer: Drower(),
      );
    }
  }
}
