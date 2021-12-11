import 'package:flutter/material.dart';
import '../components/body_builder.dart';
import '../components/book_card.dart';
import '../components/loading_widget.dart';
import '../models/category.dart';
import '../util/api.dart';
import '../util/router.dart';
import '../providers/home_provider.dart';
import 'genre.dart';
import 'package:provider/provider.dart';

class Explore extends StatefulWidget {
  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  Api api = Api();

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (BuildContext context, HomeProvider homeProvider, Widget child) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Explore',
            ),
          ),
          body: BodyBuilder(
            apiRequestStatus: homeProvider.apiRequestStatus,
            child: bodyList(homeProvider),
            reload: () => homeProvider.getFeeds(),
          ),
        );
      },
    );
  }

  bodyList(HomeProvider homeProvider) {
    return ListView.builder(
      itemCount: homeProvider?.top?.feed?.link?.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        Link link = homeProvider.top.feed.link[index];
        if (index < 10) {
          return SizedBox();
        }
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0),
          child: Column(
            children: <Widget>[
              sectionHeader(link),
              SizedBox(height: 10.0),
              sectionBookList(link),
            ],
          ),
        );
      },
    );
  }

  sectionHeader(Link link) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            child: Text(
              '${link.title}',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          GestureDetector(
            onTap: () {
              MyRouter.pushPage(
                context,
                Genre(
                  title: '${link.title}',
                  url: link.href,
                ),
              );
            },
            child: Text(
              'See All',
              style: TextStyle(
                color: Theme.of(context).accentColor,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  sectionBookList(Link link) {
    return FutureBuilder<CategoryFeed>(
      future: api.getCategory(link.href),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
          CategoryFeed category = snapshot.data;
          return Container(
            height: 200.0,
            child: Center(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                scrollDirection: Axis.horizontal,
                itemCount: category.feed.entry.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  Entry entry = category.feed.entry[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 5.0,
                      vertical: 10.0,
                    ),
                    child: BookCard(
                      img: entry.link[1].href,
                      entry: entry,
                    ),
                  );
                },
              ),
            ),
          );
        } else {
          return Container(
            height: 200.0,
            child: LoadingWidget(),
          );
        }
      },
    );
  }
}
