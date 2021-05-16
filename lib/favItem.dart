import 'package:flutter/material.dart';
import 'detail.dart';
import 'package:cached_network_image/cached_network_image.dart';

class FavItem extends StatelessWidget {
  FavItem({this.data, this.image});
  final data;
  final image;
  @override
  Widget build(BuildContext context) {
    var pre = data['image'].toString();
    var image = 'http://192.168.0.101:4000/' +
        pre.substring(0, 7) +
        '/' +
        pre.substring(8);
    final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;

    return Container(
      padding: EdgeInsets.only(top: 9),
      margin: EdgeInsets.fromLTRB(35, 0, 0, 20),
      child: Column(
        children: [
          Container(
            width: 130,
            height: 190,
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
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Center(child: CircularProgressIndicator()),
                memCacheWidth: (100 * devicePixelRatio).round(),
                width: 100,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            data['title'].toString(),
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
                color: Colors.grey[900]),
          ),
          SizedBox(
            height: 2,
          ),
          Text(
            "Rs:" + data['price'].toString() + '.00',
            style: TextStyle(fontSize: 12, color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }
}
