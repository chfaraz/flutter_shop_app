import 'dart:convert';

import 'package:app/cart.dart';
import 'package:app/userBlock.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'item.dart';
import 'drower.dart';
import 'dart:async';
import 'cart.dart';
import 'data.dart';

class ItemsPage extends StatefulWidget {
  @override
  _ItemsPageState createState() => _ItemsPageState();
  ItemsPage({
    this.name,
  });
  final name;
}

class _ItemsPageState extends State<ItemsPage> {
  var data;
  var catagory;
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
  }

  @override
  Widget build(BuildContext context) {
    final DataBlock dataBlock = Provider.of(context);
    final UserBlock userBlock = Provider.of(context, listen: false);
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
      catagory = data
          .where((i) => i['catagory'].toString() == widget.name.toLowerCase())
          .toList();
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            catagory == 'child' ? 'Children' : widget.name.toString(),
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
                Text(catagory == 'child' ? 'Children' : widget.name.toString(),
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
