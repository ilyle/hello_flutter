import 'package:flutter/material.dart';
import 'package:hello_flutter/db/article_database_helper.dart';
import 'package:hello_flutter/ui/item/article_item.dart';

class CollectionPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CollectionPage();
  }
}

class _CollectionPage extends State<CollectionPage> {
  var mDb = ArticleDatabaseHelper();

  var collectionList = [];

  @override
  void initState() {
    super.initState();
    initCollectionList();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: collectionList.length,
      itemBuilder: (BuildContext context, int position) {
        return ArticleItem(collectionList[position]);
      },
    );
  }

  Future<void> initCollectionList() async {
    List<Map<String, dynamic>> mapList = await mDb.getAll();
    setState(() {
      collectionList = mapList;
    });
  }
}
