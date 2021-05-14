import 'package:app/cart.dart';
import 'package:app/favoriteDataBlock.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data.dart';

class ItemDetail extends StatelessWidget {
  ItemDetail(
      {this.title,
      this.image,
      this.id,
      this.price,
      this.quantity,
      this.detail,
      this.catagory});
  final id;
  final title;
  final image;
  final price;
  final detail;
  final quantity;
  final catagory;
  final added = SnackBar(content: Text('Added To Cart'));
  final error = SnackBar(content: Text('Already Added'));
  bool found = false;
  @override
  Widget build(BuildContext context) {
    final DataBlock dataBlock = Provider.of(context);
    final FavoriteBlock favoriteBlock = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Details',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey[400],
                            offset: Offset(0.0, 0.0), //(x,y)
                            blurRadius: 7.0,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: CachedNetworkImage(
                          imageUrl: image,
                          fit: BoxFit.cover,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) =>
                                  Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 34, 17),
                      child: GestureDetector(
                        onTap: () {
                          favoriteBlock.favorite.contains(id)
                              ? favoriteBlock.removeFavorite(id)
                              : favoriteBlock.setFavorite(id);
                        },
                        child: Icon(
                          Icons.favorite,
                          color: favoriteBlock.favorite.contains(id)
                              ? Colors.pink
                              : Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  title.toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: Colors.grey[900]),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      flex: 1,
                      child: Text(
                        "Rs:" + price.toString() + '.00',
                        style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                      ),
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    Flexible(
                      flex: 1,
                      child: Text(
                        'In Stock : ' + quantity.toString(),
                        style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  detail.toString(),
                  style: TextStyle(fontSize: 15, color: Colors.grey[900]),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  dataBlock.add.toString(),
                  style: TextStyle(fontSize: 15, color: Colors.grey[900]),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Map data = {
                          'quantity': 1,
                          'itemQuantity': quantity,
                          'title': title,
                          'price': price,
                          'image': image,
                          'catagory': catagory,
                          'id': id
                        };
                        var item = dataBlock.list.firstWhere(
                            (item) => item['id'] == id,
                            orElse: () => null);
                        if (item == null) {
                          dataBlock.setAddToCart(data);
                        }

                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Cart(),
                          ),
                        );
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                        margin:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                        decoration: BoxDecoration(
                          color: Colors.pink[400],
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.pink[400],
                              offset: Offset(0.0, 0.0), //(x,y)
                              blurRadius: 7.0,
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.shopping_bag_outlined,
                              color: Colors.white,
                            ),
                            Text(
                              'Buy Now',
                              style: TextStyle(
                                  fontSize: 15, color: Colors.grey[100]),
                            )
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Map data = {
                          'quantity': 1,
                          'itemQuantity': quantity,
                          'title': title,
                          'price': price,
                          'image': image,
                          'catagory': catagory,
                          'id': id
                        };
                        var item = dataBlock.list.firstWhere(
                            (item) => item['id'] == id,
                            orElse: () => null);
                        if (item == null) {
                          dataBlock.setAddToCart(data);
                          ScaffoldMessenger.of(context).showSnackBar(added);
                          print('Added To Cart');
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(error);
                          print('Already Added');
                          found = true;
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.all(15),
                        margin: EdgeInsets.only(right: 30),
                        decoration: BoxDecoration(
                          color: Colors.pink[400],
                          borderRadius: BorderRadius.circular(50),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.pink[400],
                              offset: Offset(0.0, 0.0), //(x,y)
                              blurRadius: 7.0,
                              spreadRadius: 0.0,
                            ),
                          ],
                        ),
                        child:
                            Icon(Icons.add_shopping_cart, color: Colors.white),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
