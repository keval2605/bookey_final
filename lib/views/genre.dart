import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../components/body_builder.dart';
import '../components/book_list_item.dart';
import '../models/category.dart';
import '../providers/genre_provider.dart';
import 'package:provider/provider.dart';

class Genre extends StatefulWidget {
  final String title;
  final String url;

  Genre({Key key, this.title, this.url}) : super(key: key);

  @override
  _GenreState createState() => _GenreState();
}

class _GenreState extends State<Genre> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback(
      (_) => Provider.of<GenreProvider>(context, listen: false).getFeed(widget.url),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, GenreProvider provider, Widget child) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('${widget.title}'),
          ),
          body: body(provider),
        );
      },
    );
  }

  Widget body(GenreProvider provider) {
    return BodyBuilder(
      apiRequestStatus: provider.apiRequestStatus,
      child: bodyList(provider),
      reload: () => provider.getFeed(widget.url),
    );
  }

  bodyList(GenreProvider provider) {
    return ListView(
      primary: false,
      children: <Widget>[
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          shrinkWrap: true,
          itemCount: provider.items.length,
          itemBuilder: (BuildContext context, int index) {
            Entry entry = provider.items[index];
            return Padding(
              padding: EdgeInsets.all(5.0),
              child: BookListItem(
                img: entry.link[1].href,
                title: entry.title.t,
                author: entry.author.name.t,
                desc: entry.summary.t,
                entry: entry,
              ),
            );
          },
        ),
        SizedBox(height: 10.0),
      ],
    );
  }
}
