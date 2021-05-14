import 'package:app/favorites.dart';
import 'package:app/itemsPage.dart';
import 'package:flutter/material.dart';

class Drower extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor:
                      Theme.of(context).platform == TargetPlatform.iOS
                          ? Colors.blue
                          : Colors.grey,
                  child: Text(
                    "A",
                    style: TextStyle(fontSize: 40.0),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Faraz",
                      style: TextStyle(
                          fontSize: 25.0, fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text("faraz2911@gmail.com"),
                  ],
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.arrow_right),
            title: Text('Men'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ItemsPage(
                    name: 'Men',
                  ),
                ),
              );
            },
          ),
          Divider(
            height: 2,
          ),
          ListTile(
            leading: Icon(Icons.arrow_right),
            title: Text('Women'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ItemsPage(
                    name: 'Women',
                  ),
                ),
              );
            },
          ),
          Divider(
            height: 2,
          ),
          ListTile(
            leading: Icon(Icons.arrow_right),
            title: Text('Children'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => ItemsPage(
                        name: 'child',
                      )));
            },
          ),
          Divider(
            height: 2,
          ),
          ListTile(
            leading: Icon(Icons.arrow_right),
            title: Text('Favorites'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => FavoritePage()));
            },
          ),
          Divider(
            height: 2,
          ),
          ListTile(
            leading: Icon(Icons.arrow_right),
            title: Text('Logout'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
