import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import '../components/book.dart';
import '../models/category.dart';
import '../providers/favourites_provider.dart';

class Favourites extends StatefulWidget {
  @override
  _FavouritesState createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  @override
  void initState() {
    super.initState();
    getFavorites();
  }

  @override
  void deactivate() {
    super.deactivate();
    getFavorites();
  }

  getFavorites() {
    SchedulerBinding.instance.addPostFrameCallback(
      (_) {
        if (mounted) {
          Provider.of<FavouritesProvider>(context, listen: false).getFavorites();
        }
      },
    );
  }

  gridList(List posts) {
    return GridView.builder(
      padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0.0),
      shrinkWrap: true,
      itemCount: posts.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 200 / 340,
      ),
      itemBuilder: (BuildContext context, int index) {
        Entry entry = Entry.fromJson(posts[index]['item']);
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.0),
          child: BookItem(
            img: entry.link[1].href,
            title: entry.title.t,
            entry: entry,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FavouritesProvider>(
      builder: (BuildContext context, FavouritesProvider favouritesProvider, Widget child) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Favorites',
            ),
          ),
          body: favouritesProvider.posts.isEmpty ? emptyList() : gridList(favouritesProvider.posts),
        );
      },
    );
  }

  emptyList() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            'No Favourites',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
