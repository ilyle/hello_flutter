import 'package:flutter/material.dart';
import 'package:hello_flutter/ui/page/collection_page.dart';
import 'package:hello_flutter/ui/page/search_page.dart';
import 'package:hello_flutter/ui/page/suggestion_page.dart';

class ArticlePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _ArticlePage();
  }
}

class _ArticlePage extends State<ArticlePage> {
  List<Tab> tabList = <Tab>[Tab(text: "推荐"), Tab(text: "收藏")];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabList.length,
      child: new Scaffold(
          appBar: new AppBar(
            title: Text("呱呱安卓"),
            bottom: new TabBar(tabs: tabList),
            actions: <Widget>[
              IconButton(
                  icon: new Icon(Icons.search),
                  color: Colors.white,
                  tooltip: 'search',
                  onPressed: () {
                    // showSearch(context: context, delegate: SearchPage());
                  })
            ],
          ),
          body: new TabBarView(
              children: tabList.map((Tab tab) {
            return getArticlePage(tab);
          }).toList())),
    );
  }

  Widget getArticlePage(Tab tab) {
    if (tab.text == "推荐") {
      return SuggestionPage();
    } else if (tab.text == "收藏") {
      return CollectionPage();
    } else {
      return SuggestionPage();
    }
  }
}
