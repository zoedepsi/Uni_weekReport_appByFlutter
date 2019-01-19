import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'pages/filter.dart';
import 'pages/meetRecordList.dart';
import 'pages/personalInfo.dart';
import 'pages/reportList.dart';
import 'pages/thisWeek.dart';

void main() => runApp(MyHomePage());

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //页面当前选中的tab
  int _tabIndex = 0;
  // TabItem的文本默认样式
  final tabTextStyleNormal = new TextStyle(color: const Color(0xff969696));
  // TabItem被选中时的文本样式
  final tabTextStyleSelected =
      new TextStyle(color: Color.fromRGBO(30, 128, 240, 1));
// 页面底部TabItem上的图标数组
  var tabImages;
  var _body;
  //页面顶部大标题（也是tabItem文本）
  var appBarTitles = ['周报', '会议', '检索', '我的'];
  //传入图片路径，返回Image
  Image getTabImage(path) {
    return new Image.asset(path, width: 20.0, height: 20.0);
  }

  // 数据初始化，包括TabIcon数据和页面内容数据
  initData() {
    if (tabImages == null) {
      tabImages = [
        [
          getTabImage('images/ic_nav_news_normal.png'),
          getTabImage('images/ic_nav_news_actived.png')
        ],
        [
          getTabImage('images/ic_nav_tweet_normal.png'),
          getTabImage('images/ic_nav_tweet_actived.png')
        ],
        [
          getTabImage('images/ic_nav_discover_normal.png'),
          getTabImage('images/ic_nav_discover_actived.png')
        ],
        [
          getTabImage('images/ic_nav_my_normal.png'),
          getTabImage('images/ic_nav_my_pressed.png')
        ]
      ];
    }
    //页面body部分
    _body = new IndexedStack(
      children: <Widget>[
        new ReportList(),
        new MeetRecordList(),
        new Filter(),
        new PersonalInfo()
      ],
      index: _tabIndex,
    );
  }

  List<BottomNavigationBarItem> getBottomNavItems() {
    List<BottomNavigationBarItem> list = new List();
    for (var i = 0; i < 4; i++) {
      list.add(new BottomNavigationBarItem(
          icon: getTabIcon(i), title: getTabTitle(i)));
    }
    return list;
  }

  // 根据索引值确定Tab是选中状态的样式还是非选中状态的样式
  TextStyle getTabTextStyle(int curIndex) {
    if (curIndex == _tabIndex) {
      return tabTextStyleSelected;
    } else {
      return tabTextStyleNormal;
    }
  }

// 根据索引值确定TabItem的icon是选中还是非选中
  Image getTabIcon(int curIndex) {
    if (curIndex == _tabIndex) {
      return tabImages[curIndex][1];
    } else {
      return tabImages[curIndex][0];
    }
  }

  //根据索引值返回页面顶部标题
  Text getTabTitle(int curIndex) {
    return new Text(
      appBarTitles[curIndex],
      style: getTabTextStyle(curIndex),
    );
  }

  @override
  Widget build(BuildContext context) {
    //每次修改状态都会触发initData()
    initData();
    return new MaterialApp(
        home: Builder(
      builder: (context) => Scaffold(
            appBar: AppBar(
              title: Text(
                appBarTitles[_tabIndex],
                style: new TextStyle(color: Colors.white),
              ),
              iconTheme: new IconThemeData(color: Colors.white),
            ),
            body: _body,
            bottomNavigationBar: CupertinoTabBar(
              items: getBottomNavItems(),
              currentIndex: _tabIndex,
              onTap: (index) {
                setState(() {
                  _tabIndex = index;
                });
              },
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                  return new ThisWeek();
                }));
              },
              child: Icon(Icons.add),
            ),
          ),
    ));
  }
}
