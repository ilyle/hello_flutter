import 'package:flutter/material.dart';
import 'package:hello_flutter/base/res/values/colors/BaseColors.dart';
import 'package:hello_flutter/ui/page/article_page.dart';

class GuaguaAndroidApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "呱呱安卓",
      theme: ThemeData(primarySwatch: MyColors.color_primary),
      home: ArticlePage(),
    );
  }

}