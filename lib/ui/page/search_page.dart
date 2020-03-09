import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:hello_flutter/ui/item/article_item.dart';
import 'package:hello_flutter/api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SearchPage extends SearchDelegate<String> {

  // EasyRefresh控制器，支持手动停止刷新和加载动画
  EasyRefreshController controller = EasyRefreshController();

  // 当前搜索页面
  int curPage = 0;

  // 推荐的文章列表
  var searchList = [];

  // 推荐的文章缓存
  var searchCacheList = [];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
        onPressed: () {
          close(context, "");
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return EasyRefresh(
        controller: controller,
        enableControlFinishRefresh: true,
        enableControlFinishLoad: true,
        child: ListView.builder(
            itemCount: searchList.length,
            itemBuilder: (BuildContext context, int position) {
              return ArticleItem(searchList[position]);
            }),
        onRefresh: (){refreshSearch(context);},
        onLoad: null);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container(
      child: Center(
        child: Text("搜索的结果：$query"),
      ),
    );
  }

  Future<void> refreshSearch(BuildContext context) async {
    String url = buildRefreshUrl();
    print("post : URL = $url");
    Map<String, String> params =  {};
    params["k"] = query;
    http.Response response = await http.post(url, body: params);



      //controller.finishRefresh(success: true);
      if (response.statusCode == 200) {
        Map<String, dynamic> map = json.decode(response.body);
        Map<String, dynamic> data = map['data'];
        searchList = data["datas"];
        // 更新缓存
        searchCacheList = searchList;
      }
    showResults(context);
  }

  String buildRefreshUrl() {
    curPage = 0;
    return Api.ARTICLE_QUERY + "0/json";
  }

  String buildLoadMoreUrl() {
    curPage++;
    return Api.ARTICLE_QUERY + curPage.toString() + "/json";
  }
}
