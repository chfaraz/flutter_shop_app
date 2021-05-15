import 'package:app/favorites.dart';
import 'package:app/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'cart.dart';
import 'data.dart';
import 'favoriteDataBlock.dart';

class BottomBar extends StatefulWidget {
  @override
  _BottomBarState createState() => _BottomBarState();
  BottomBar({this.active});
  final active;
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    final DataBlock dataBlock = Provider.of(context);
    final FavoriteBlock favoriteBlock = Provider.of(context);

    return BottomAppBar(
      elevation: 40,
      color: Colors.grey[800],
      child: IconTheme(
        data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              tooltip: 'Home',
              icon: Icon(
                Icons.home,
                color: widget.active == 'home' ? Colors.pink : Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Home(),
                  ),
                );
              },
            ),
            IconButton(
              tooltip: 'Favorite',
              icon: Icon(
                favoriteBlock.favorite.length == 0
                    ? Icons.favorite_border_outlined
                    : Icons.favorite,
                color: widget.active == 'fav' ? Colors.pink : Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FavoritePage(),
                  ),
                );
              },
            ),
            IconButton(
              tooltip: 'Cart',
              icon: Icon(
                dataBlock.list.length == 0
                    ? Icons.shopping_cart_outlined
                    : Icons.shopping_cart,
                color: widget.active == 'cart' ? Colors.pink : Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Cart(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
