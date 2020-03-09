class Article {

  int id;
  String chapterName;
  String title;
  String author;
  String niceDate;
  String link;


  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["chapterName"] = chapterName;
    map["title"] = title;
    map["author"] = author;
    map["niceDate"] = niceDate;
    map["link"] = link;
    return map;
  }

  static Article fromMap(Map<String, dynamic> map) {
    Article article = new Article();
    article.id = map["id"];
    article.chapterName = map["chapterName"];
    article.title = map["title"];
    article.author = map["author"];
    article.niceDate = map["niceDate"];
    article.link = map["link"];
    return article;
  }

  static List<Article> fromMapList(List<Map<String, dynamic>> mapList) {
    List<Article> articleList = [];
    for(var map in mapList) {
      articleList.add(fromMap(map));
    }
    return articleList;
  }
}