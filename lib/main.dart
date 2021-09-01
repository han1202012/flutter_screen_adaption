import 'package:flutter/material.dart';

/// 使用 MediaQuery 进行全面屏适配
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    /// 获取当前的 padding 信息
    final EdgeInsets edgeInsets = MediaQuery.of(context).padding;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),

      padding: EdgeInsets.fromLTRB(0, edgeInsets.top, 0, edgeInsets.bottom),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("顶部内容"),
          Text("底部内容"),
        ],
      ),
    );
  }
}