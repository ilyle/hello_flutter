import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:hello_flutter/bean/article.dart';
import 'package:hello_flutter/db/article_database_helper.dart';
import 'package:hello_flutter/base/res/values/demins/BaseDemins.dart';

import 'package:webview_flutter/webview_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ArticleDetailPage extends StatefulWidget {
  Article article;

  ArticleDetailPage(Article article) {
    this.article = article;
  }

  @override
  State<StatefulWidget> createState() {
    return _ArticleDetailPage(article);
  }
}

class _ArticleDetailPage extends State<ArticleDetailPage> {
  var mArticleDb = ArticleDatabaseHelper();

  Article mArticle;

  bool isCollected = false;

  _ArticleDetailPage(Article article) {
    mArticle = article;
  }

  @override
  void initState() {
    super.initState();
    initCollected();
  }

  @override
  Widget build(BuildContext context) {
    // 添加收藏或取消收藏
    Widget collection = GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
          operationCollection();
        },
        child: Container(
          alignment: Alignment.centerLeft,
          height: 48,
          padding: EdgeInsets.all(Demins.padding_normal),
          child: Text(getCollectionDesc()),
        ));

    // 弹框
    Widget moreDialog(BuildContext context) {
      return Column(
          crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: <Widget>[collection]);
    }

    // 显示弹框
    void showMoreDialog() {
      showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return moreDialog(context);
          });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("文章详情"),
        actions: <Widget>[
          IconButton(icon: new Icon(Icons.more_vert), color: Colors.white, tooltip: 'More', onPressed: showMoreDialog)
        ],
      ),
      body: WebView(
        initialUrl: mArticle.link,
      ),
    );
  }

  void initCollected() async {
    List<Map<String, dynamic>> collectionArticleList = await mArticleDb.getAll();
    List<int> collectionIdList = [];
    collectionArticleList.forEach((article) {
      collectionIdList.add(article['id']);
    });
    print("collectionIds : $collectionIdList");
    print("articleId: ${mArticle.id}");
    setState(() {
      print(collectionIdList.contains(mArticle.id));
      isCollected = collectionIdList.contains(mArticle.id);
    });
  }

  String getCollectionDesc() {
    if (isCollected)
      return "取消收藏";
    else
      return "添加收藏";
  }

  void operationCollection() {
    if (isCollected) {
      removeCollection();
    } else {
      addCollection();
    }
  }

  void addCollection() async {
    print("添加收藏");
    try {
      var result = await mArticleDb.insert(mArticle);
      if (result > 0) {
        Fluttertoast.showToast(msg: "添加成功");
        setState(() {
          isCollected = true;
        });
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "添加失败：$e");
    }
  }

  void removeCollection() async {
    print("取消收藏");
    try {
      var result = await mArticleDb.delete(mArticle);
      if (result > 0) {
        Fluttertoast.showToast(msg: "取消成功");
        setState(() {
          isCollected = false;
        });
      } else {
        Fluttertoast.showToast(msg: "取消失败");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "取消失败：$e");
    }
  }
}
