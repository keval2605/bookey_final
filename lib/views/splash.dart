import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'main_screen.dart';
import '../authenticate/authenticate.dart';
import '../models/user.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser>(context);
    if (user == null) {
      return Authenticate();
    } else {
      return MainScreen();
    }
  }
}
