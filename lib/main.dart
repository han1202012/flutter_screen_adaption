import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 使用 MediaQuery 进行全面屏适配
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /// 在 MaterialApp 组件外层包裹一层 ScreenUtilInit 组件
    return ScreenUtilInit(
      /// 设置设计稿宽高
      designSize: Size(750, 1334),

      /// 设置原本要显示的 MaterialApp
      builder: ()=>MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage(),
      ),
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
          Text("顶部内容", style: TextStyle(fontSize: 40.sp),),

          /// 宽高是宽度的 0.5 倍 , 显示正方形
          Container(
            width: 0.5.sw,
            height: 0.5.sw,
            color: Colors.green,
          ),

          Text("底部内容", style: TextStyle(fontSize: 20.sp),),
        ],
      ),
    );
  }
}

/*
    ScreenUtil().setWidth(540)  (sdk>=2.6 : 540.w)   //根据屏幕宽度适配尺寸
    ScreenUtil().setHeight(200) (sdk>=2.6 : 200.h)   //根据屏幕高度适配尺寸(一般根据宽度适配即可)
    ScreenUtil().radius(200)    (sdk>=2.6 : 200.r)   //根据宽度或高度中的较小者进行调整
    ScreenUtil().setSp(24)      (sdk>=2.6 : 24.sp)   //适配字体

    ScreenUtil.pixelRatio       //设备的像素密度
    ScreenUtil.screenWidth   (sdk>=2.6 : 1.sw)   //设备宽度
    ScreenUtil.screenHeight  (sdk>=2.6 : 1.sh)   //设备高度
    ScreenUtil.bottomBarHeight  //底部安全区距离，适用于全面屏下面有按键的
    ScreenUtil.statusBarHeight  //状态栏高度 刘海屏会更高
    ScreenUtil.textScaleFactor //系统字体缩放比例

    ScreenUtil().scaleWidth  // 实际宽度设计稿宽度的比例
    ScreenUtil().scaleHeight // 实际高度与设计稿高度度的比例

    ScreenUtil().orientation  //屏幕方向

    0.2.sw  //屏幕宽度的0.2倍
    0.5.sh  //屏幕高度的50%
 */