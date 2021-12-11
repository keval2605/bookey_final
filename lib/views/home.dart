import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/scheduler.dart';
import '../models/category.dart';
import '../providers/home_provider.dart';
import '../components/body_builder.dart';
import '../components/book_list_item.dart';
import '../components/book_card.dart';
import 'genre.dart';
import '../util/router.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback(
      (_) => Provider.of<HomeProvider>(context, listen: false).getFeeds(),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Consumer<HomeProvider>(
      builder: (BuildContext context, HomeProvider homeProvider, Widget child) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Bookey',
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
          ),
          body: body(homeProvider),
        );
      },
    );
  }

  Widget body(HomeProvider homeProvider) {
    return BodyBuilder(
      apiRequestStatus: homeProvider.apiRequestStatus,
      child: bodyList(homeProvider),
      reload: () => homeProvider.getFeeds(),
    );
  }

  Widget bodyList(HomeProvider homeProvider) {
    return RefreshIndicator(
      onRefresh: () => homeProvider.getFeeds(),
      child: ListView(
        children: <Widget>[
          featuredSection(homeProvider),
          SizedBox(height: 20.0),
          sectionTitle('Categories'),
          SizedBox(height: 10.0),
          genreSection(homeProvider),
          SizedBox(height: 20.0),
          sectionTitle('Recently Added'),
          SizedBox(height: 20.0),
          newSection(homeProvider),
        ],
      ),
    );
  }

  sectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            '$title',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  featuredSection(HomeProvider homeProvider) {
    return Container(
      height: 200.0,
      child: Center(
        child: ListView.builder(
          primary: false,
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          scrollDirection: Axis.horizontal,
          itemCount: homeProvider?.top?.feed?.entry?.length ?? 0,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            Entry entry = homeProvider.top.feed.entry[index];
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
              child: BookCard(
                img: entry.link[1].href,
                entry: entry,
              ),
            );
          },
        ),
      ),
    );
  }

  genreSection(HomeProvider homeProvider) {
    return Container(
      height: 50.0,
      child: Center(
        child: ListView.builder(
          primary: false,
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          scrollDirection: Axis.horizontal,
          itemCount: homeProvider?.top?.feed?.link?.length ?? 0,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            Link link = homeProvider.top.feed.link[index];
            if (index < 10) {
              return SizedBox();
            }
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                  onTap: () {
                    MyRouter.pushPage(
                      context,
                      Genre(
                        title: '${link.title}',
                        url: link.href,
                      ),
                    );
                  },
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        '${link.title}',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  newSection(HomeProvider homeProvider) {
    return ListView.builder(
      primary: false,
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: homeProvider?.recent?.feed?.entry?.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        Entry entry = homeProvider.recent.feed.entry[index];
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
          child: BookListItem(
            img: entry.link[1].href,
            title: entry.title.t,
            author: entry.author.name.t,
            desc: entry.summary.t,
            entry: entry,
          ),
        );
      },
    );
  }
}
