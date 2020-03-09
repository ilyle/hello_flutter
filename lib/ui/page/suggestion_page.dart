import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:hello_flutter/api.dart';
import 'package:hello_flutter/ui/item/article_item.dart';

import 'package:http/http.dart' as http;

import 'dart:convert';

class SuggestionPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _SuggestionPage();
  }
}

class _SuggestionPage extends State<SuggestionPage> {
  // 当前搜索页面
  int curPage = 0;

  // 推荐的文章列表
  var suggestionList = [];

  // 推荐的文章缓存
  var suggestionCacheList = [];

  // EasyRefresh控制器，支持手动停止刷新和加载动画
  EasyRefreshController controller = EasyRefreshController();

  @override
  void initState() {
    super.initState();
    initSuggestionList();
  }

  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
        controller: controller,
        enableControlFinishRefresh: true,
        enableControlFinishLoad: true,
        child: ListView.builder(
            itemCount: suggestionList.length,
            itemBuilder: (BuildContext context, int position) {
              return ArticleItem(suggestionList[position]);
            }),
        onRefresh: refreshArticle,
        onLoad: loadMoreArticle);
  }

  // 初始化推荐列表
  Future<void> initSuggestionList() async {
    refreshArticle();
  }

  Future<void> loadMoreArticle() async {
    String url = buildLoadMoreUrl();
    print("GET : URL = $url");
    http.Response response = await http.get(url);
    setState(() {
      controller.finishLoad(success: true, noMore: false);
      if (response.statusCode == 200) {
        Map<String, dynamic> map = json.decode(response.body);
        Map<String, dynamic> data = map['data'];
        var newSuggestionList = data["datas"];
        suggestionList.addAll(newSuggestionList);
        // 更新缓存
        suggestionCacheList = suggestionList;
      }
    });
  }

  Future<void> refreshArticle() async {
    String url = buildRefreshUrl();
    print("GET : URL = $url");
    http.Response response = await http.get(url);
    setState(() {
      controller.finishRefresh(success: true);
      if (response.statusCode == 200) {
        Map<String, dynamic> map = json.decode(response.body);
        Map<String, dynamic> data = map['data'];
        suggestionList = data["datas"];
        // 更新缓存
        suggestionCacheList = suggestionList;
      }
    });
  }

  String buildRefreshUrl() {
    curPage = 0;
    return Api.ARTICLE_LIST + "0/json";
  }

  String buildLoadMoreUrl() {
    curPage++;
    return Api.ARTICLE_LIST + curPage.toString() + "/json";
  }
}
