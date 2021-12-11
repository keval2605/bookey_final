import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'views/splash.dart';
import 'providers/home_provider.dart';
import 'providers/genre_provider.dart';
import 'providers/favourites_provider.dart';
import 'providers/details_provider.dart';
import 'database/auth.dart';
import 'models/user.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => GenreProvider()),
        ChangeNotifierProvider(create: (_) => FavouritesProvider()),
        ChangeNotifierProvider(create: (_) => DetailsProvider()),
      ],
      child: Bookey(),
    ),
  );
}

class Bookey extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<MyUser>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Splash(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
