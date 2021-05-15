import 'package:app/favoriteDataBlock.dart';
import 'package:app/userBlock.dart';
import 'package:flutter/material.dart';
import 'signIn.dart';
import 'home.dart';
import 'package:provider/provider.dart';
import 'data.dart';

void main() {
  runApp(HomeSecreen());
}

class HomeSecreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DataBlock()),
        ChangeNotifierProvider(create: (_) => UserBlock()),
        ChangeNotifierProvider(create: (_) => FavoriteBlock())
      ],
      child: MaterialApp(
        home: Home(),
      ),
    );
  }
}
