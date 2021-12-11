import 'package:flutter/material.dart';
import 'home.dart';
import 'explore.dart';
import 'settings.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  PageController pageController;
  int page = 0;

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      this.page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: onPageChanged,
        children: <Widget>[
          Home(),
          Explore(),
          Settings(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey[200],
        selectedItemColor: Theme.of(context).accentColor,
        unselectedItemColor: Colors.grey[500],
        elevation: 30,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.explore_outlined,
            ),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings_outlined,
            ),
            label: 'Settings',
          ),
        ],
        onTap: navigationTapped,
        currentIndex: page,
      ),
    );
  }
}
