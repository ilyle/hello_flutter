import 'package:hello_flutter/bean/article.dart';

void main() {
  Article article1 = new Article();
  article1.id = 1;
  article1.chapterName = "11";

  Article article2 = new Article();
  article1.id = 2;
  article1.chapterName = "22";
  
  List articleList = [];
  articleList.add(article1);
  articleList.add(article2);
  
  print(articleList.toString());

}