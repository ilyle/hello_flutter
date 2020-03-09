import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hello_flutter/base/res/values/colors/BaseColors.dart';
import 'package:hello_flutter/base/res/values/demins/BaseDemins.dart';
import 'package:hello_flutter/bean/article.dart';
import 'package:hello_flutter/ui/page/article_detail_page.dart';

class ArticleItem extends StatefulWidget {
   var article;

  ArticleItem(var article) {
    this.article = article;
  }

  @override
  State<StatefulWidget> createState() {
    return _ArticleItem(article);
  }
}

class _ArticleItem extends State<ArticleItem> {
  var article;

  _ArticleItem(var article) {
    this.article = article;
  }

  @override
  Widget build(BuildContext context) {
    Widget chapter = Text(
      article['chapterName'],
      style: TextStyle(fontSize: Demins.text_small, color: MyColors.color_text_black_secondary),
    );

    Widget title = Padding(
        padding: EdgeInsets.only(top: Demins.padding_small, bottom: Demins.padding_small),
        child: Text(
          article['title'],
          maxLines: 2,
        ));

    Widget author = Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(Icons.person_outline, color: MyColors.color_primary),
        Padding(
          padding: EdgeInsets.only(left: Demins.padding_small),
          child: Text(
            getArticleAuthor(article['author']),
            style: TextStyle(color: MyColors.color_primary, fontSize: Demins.text_small),
          ),
        )
      ],
    );

    Widget date = Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(Icons.date_range, color: MyColors.color_primary),
        Padding(
            padding: EdgeInsets.only(left: Demins.padding_small),
            child: Text(
              article['niceDate'],
              style: TextStyle(color: MyColors.color_primary, fontSize: Demins.text_small),
            ))
      ],
    );

    Widget card = Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
      chapter,
      title,
      Stack(
        children: <Widget>[
          Align(alignment: Alignment.centerLeft, child: author),
          Align(alignment: Alignment.centerRight, child: date)
        ],
      )
    ]);

    return GestureDetector(
      onTap: () {
        showArticleDetails(article);
      },
      child: Card(
        elevation: Demins.elevation_normal,
        child: Padding(
          padding: EdgeInsets.fromLTRB(
              Demins.padding_huge, Demins.padding_normal, Demins.padding_huge, Demins.padding_normal),
          child: card,
        ),
      ),
    );
  }

  // 若无作者，返回未知
  String getArticleAuthor(String author) {
    if (author.isEmpty) {
      return "未知";
    } else {
      return author;
    }
  }

  void showArticleDetails(var article) async {
    await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ArticleDetailPage(Article.fromMap(article));
    }));
  }
}
