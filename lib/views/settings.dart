import 'package:flutter/material.dart';
import '../util/router.dart';
import 'favourites.dart';
import '../database/auth.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  List items;
  final AuthService _auth = AuthService();

  @override
  void initState() {
    super.initState();
    items = [
      {
        'icon': Icons.favorite_border,
        'title': 'Favorites',
        'function': () => MyRouter.pushPage(context, Favourites()),
      },
      {
        'icon': Icons.info_outline,
        'title': 'About',
        'function': () => showAbout(),
      },
      {
        'icon': Icons.description_outlined,
        'title': 'Licenses',
        'function': () => showLicenses(),
      },
      {
        'icon': Icons.logout,
        'title': 'Logout',
        'function': () => logout(),
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Settings',
        ),
      ),
      body: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 10),
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            onTap: items[index]['function'],
            leading: Icon(
              items[index]['icon'],
            ),
            title: Text(
              items[index]['title'],
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider();
        },
      ),
    );
  }

  showAbout() {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(
            'About',
          ),
          content: Text(
            'Developed By YKM!',
          ),
          actions: <Widget>[
            FlatButton(
              textColor: Theme.of(context).accentColor,
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Close',
              ),
            ),
          ],
        );
      },
    );
  }

  showLicenses() {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(
            'Licenses',
          ),
          content: Text(
            'Bookey - All rights reserved.',
          ),
          actions: <Widget>[
            FlatButton(
              textColor: Theme.of(context).accentColor,
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Close',
              ),
            ),
          ],
        );
      },
    );
  }

  logout() async {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(
            'Logging Out...',
          ),
          content: Text(
            _auth.getEmail() + ' logging out...',
          ),
          actions: <Widget>[
            FlatButton(
              textColor: Theme.of(context).accentColor,
              onPressed: () => loggingOut(),
              child: Text(
                'Close',
              ),
            ),
          ],
        );
      },
    );
  }

  void loggingOut() async {
    Navigator.pop(context);
    await _auth.signOut();
  }
}
