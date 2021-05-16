import 'package:app/bottomAppBar.dart';
import 'package:app/userBlock.dart';
import 'package:flutter/material.dart';
import 'cartCard.dart';
import 'package:app/data.dart';
import 'package:provider/provider.dart';
import 'constant.dart';
import 'package:dio/dio.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  var dio = Dio();
  var message;
  var total;
  var quantity;

  Future postOrder() async {
    final UserBlock userBlock = Provider.of(context, listen: false);

    var token = userBlock.user['token'];

    dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers["authorization"] = "token $token";
    final response = await dio.post(url + 'order/checkout', data: {
      'name': userBlock.user['name'],
      'userName': userBlock.user['userName'],
      'total': total,
      'quantity': quantity,
    });

    if (response.statusCode == 200) {
      print('success full :)');
      setState(() {
        message = 'Order Placed Successfully';
      });
    } else {
      throw Exception('Failed :(');
    }
  }

  @override
  Widget build(BuildContext context) {
    final DataBlock dataBlock = Provider.of(context);
    if (dataBlock.list.length == 0) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            'Cart',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Center(
          child: Container(
            child:
                message == null ? Text('Nothing In Cart :(') : Text('$message'),
          ),
        ),
        bottomNavigationBar: BottomBar(active: 'cart'),
      );
    } else {
      var totl = 0;
      var quan = 0;
      for (var item in dataBlock.list) {
        totl = totl + item['price'] * item['quantity'];
        quan = quan + item['quantity'];
      }
      total = totl;
      quantity = quan;
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            'Cart',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                for (var item in dataBlock.list)
                  CartCard(
                    id: item['id'],
                    title: item['title'],
                    image: item['image'],
                    price: item['price'],
                    catagory: item['catagory'],
                    quantity: item['quantity'],
                    itemQuantity: item['itemQuantity'],
                  ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total:',
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w900,
                              color: Colors.grey[500]),
                        ),
                        Text(
                          'Rs ' + total.toString() + '.00/-',
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w900,
                              color: Colors.black),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        dataBlock.emptyList();

                        postOrder();
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        decoration: BoxDecoration(
                          color: Colors.pink,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'Pay Now',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomBar(active: 'cart'),
      );
    }
  }
}
