@[TOC]



<br>
<br>
<br>
<br>

# 一、Flutter 全面屏适配

---

<br>


传统的 Android 屏幕的宽高比是 $16 : 9$ , 但是当前主流的全面屏手机 , 基本已经都是 $19.5:9$ , $20:9$ , $21:9$ 的宽高比 , 基本达到了 $2:1$ 左右的宽高比 ;

适配全面屏主要是适配比较长的这个边 ;

<br>

**全面屏适配内容 :**

**高度适配 :** 传统的布局按照 $16:9$ 进行布局 , 高度不足 , 如果适配到全屏屏中 , 导致无法填充满整个屏幕 ;

**位置适配 :** 基于 屏幕 顶部 / 底部 摆放的组件 , 会出现偏移 , 没有按照设计位置摆放 ;

**安全区域适配 :** 在一些手机中 , 顶部有刘海 , 水滴 等摄像头位置 , 底部有话筒 , 这些位置不能填充组件 , 有被阻挡的风险 ;


<br>
<br>
<br>
<br>

# 二、全面屏适配的情况

---

<br>


**全面屏适配要点 :**
 - 在页面中使用了 Scaffold 的 appBar 和 bottomNavigationBar , Scaffold 框架会自动按照全面屏的机制进行适配 , 不需要开发者进行手动干预 ;
 - 如果页面中没有使用 Scaffold , 或者使用了 Scaffold  没有使用 appBar 和 bottomNavigationBar , 这样顶部导航栏偏上 , 底部导航栏偏下 , 这里需要适配一下 ;



<br>
<br>
<br>
<br>

# 三、全面屏适配方法

---

<br>


**全面屏适配方法 :** 在 <font color=blue>顶部</font> 和 <font color=red>底部</font> 留出足够的 <font color=purple>安全区域 ;


**方案一 :** Flutter 中提供了一个 `SafeArea` 组件 , 使用该组件 包裹 页面 , 可以实现适配 ;

**方案二 :** 使用 `MediaQuery.of(context).padding` 获取屏幕四个方向上的 Padding ;



<br>
<br>
<br>
<br>

# 四、反面示例 ( 留海遮挡内容 )

---

<br>

华为 Mate 30 手机中 , 使用如下代码 , 显示的内容 , 顶部没有预留足够的安全区域 , 导致部分内容


```java
import 'package:flutter/material.dart';

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
      home: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("顶部内容"),
            Text("底部内容"),
          ],
        ),
      ),
    );
  }
}
```

这是华为 Mate 30 的真机展示样式 ; 如果使用截图 , 无法看到被留海遮挡的样式 ;

![在这里插入图片描述](https://img-blog.csdnimg.cn/f7296e285c78401f839543b73131a979.png?x-oss-process=image/watermark,type_ZHJvaWRzYW5zZmFsbGJhY2s,shadow_50,text_Q1NETiBA6Z-p5puZ5Lqu,size_20,color_FFFFFF,t_70,g_se,x_16)




<br>
<br>
<br>
<br>

# 五、Android 中配置最大宽高比

---

<br>

在 flutter_screen_adaption\android\app\src\main\AndroidManifest.xml 清单文件中的 application 节点下 , 配置 `android.max_aspect` 最大可适配的宽高比配置 ;

```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="com.example.flutter_screen_adaption">
   <application
        android:label="flutter_screen_adaption"
        android:icon="@mipmap/ic_launcher">

        <!-- 添加 Android 可以适配的最大宽高比为 2.5 : 1 , 适配全面屏添加 -->
        <meta-data
            android:name="android.max_aspect"
            android:value="2.5"/>
    </application>
</manifest>

```



<br>
<br>
<br>
<br>

# 六、使用 SafeArea 进行全面屏适配

---

<br>


```java
import 'package:flutter/material.dart';

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
      home: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: SafeArea(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("顶部内容"),
                Text("底部内容"),
              ],
            ),
        ),
      ),
    );
  }
}
```


**适配后的样式 :**

![在这里插入图片描述](https://img-blog.csdnimg.cn/b458874e3c42404795aefcdaa80e4c82.png?x-oss-process=image/watermark,type_ZHJvaWRzYW5zZmFsbGJhY2s,shadow_50,text_Q1NETiBA6Z-p5puZ5Lqu,size_20,color_FFFFFF,t_70,g_se,x_16)









<br>
<br>
<br>
<br>

# 七、使用 MediaQuery 进行全面屏适配

---

<br>


```java
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
```

**适配后的样式 :**

![在这里插入图片描述](https://img-blog.csdnimg.cn/edfc0b8e7712481cbc0fce580d0bcb31.png?x-oss-process=image/watermark,type_ZHJvaWRzYW5zZmFsbGJhY2s,shadow_50,text_Q1NETiBA6Z-p5puZ5Lqu,size_20,color_FFFFFF,t_70,g_se,x_16)

