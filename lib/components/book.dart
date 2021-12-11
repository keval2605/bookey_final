import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'loading_widget.dart';
import '../models/category.dart';
import '../util/router.dart';
import '../views/details.dart';

class BookItem extends StatelessWidget {
  final String img;
  final String title;
  final Entry entry;

  BookItem({Key key, this.img, this.title, this.entry}) : super(key: key);

  static final uuid = Uuid();
  final String imgTag = uuid.v4();
  final String titleTag = uuid.v4();
  final String authorTag = uuid.v4();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        MyRouter.pushPage(
          context,
          Details(
            entry: entry,
            imgTag: imgTag,
            titleTag: titleTag,
            authorTag: authorTag,
          ),
        );
      },
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            child: Hero(
              tag: imgTag,
              child: CachedNetworkImage(
                imageUrl: '$img',
                placeholder: (context, url) => LoadingWidget(),
                errorWidget: (context, url, error) => Image.asset(
                  'assets/images/app-icon.png',
                  fit: BoxFit.cover,
                ),
                fit: BoxFit.cover,
                height: 150.0,
              ),
            ),
          ),
          SizedBox(height: 5.0),
          Hero(
            tag: titleTag,
            child: Material(
              type: MaterialType.transparency,
              child: Text(
                '${title.replaceAll(r'\', '')}',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
