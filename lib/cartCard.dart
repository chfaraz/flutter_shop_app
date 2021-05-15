import 'package:app/data.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartCard extends StatelessWidget {
  CartCard(
      {this.title,
      this.image,
      this.id,
      this.price,
      this.catagory,
      this.itemQuantity,
      this.quantity});
  final id;
  final title;
  final image;
  final price;
  final catagory;
  final itemQuantity;
  final quantity;
  final less = SnackBar(content: Text('cant be less then one'));

  @override
  Widget build(BuildContext context) {
    final DataBlock dataBlock = Provider.of(context);
    final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;

    return Container(
      padding: EdgeInsets.all(7),
      margin: EdgeInsets.only(bottom: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[400],
            offset: Offset(0.0, 0.0), //(x,y)
            blurRadius: 7.0,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.only(right: 7),
            width: 90,
            height: 110,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: CachedNetworkImage(
                memCacheWidth: (100 * devicePixelRatio).round(),
                imageUrl: image,
                fit: BoxFit.cover,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title.toString(),
                          style:
                              TextStyle(fontSize: 20, color: Colors.grey[900]),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          catagory.toString(),
                          style:
                              TextStyle(fontSize: 15, color: Colors.grey[600]),
                        ),
                      ],
                    ),
                    Flexible(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          dataBlock.deteteFromCart(id);
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 15),
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.pink,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child:
                              Icon(Icons.close_outlined, color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 18,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Rs: ' + price.toString(),
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: Colors.black),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 15),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (quantity != 1) {
                                dataBlock.setQuantityMinus(id);
                              } else {
                                print('cant be less then one');
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(less);
                              }
                            },
                            child: Container(
                              width: 22,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '-',
                                    style: TextStyle(
                                        fontSize: 22,
                                        color: Colors.grey[800],
                                        fontWeight: FontWeight.w900),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            quantity.toString(),
                            style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[800]),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              if (quantity < itemQuantity) {
                                dataBlock.setQuantityPlus(id);
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(
                                      'we only have $itemQuantity of these items'),
                                ));
                                print(
                                    'we only have $itemQuantity of these items');
                              }
                            },
                            child: Container(
                              width: 22,
                              height: 22,
                              child: Text(
                                '+',
                                style: TextStyle(
                                    fontSize: 22, color: Colors.grey[800]),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
