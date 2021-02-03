import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_netease_cloud_music/page/my.dart';

void main() {
  runApp(CloudMusicApp());
}

class CloudMusicApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Cloud Music',
      theme: ThemeData(
        primarySwatch: Colors.red,
        pageTransitionsTheme: _createPageTransitionsTheme(),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        pageTransitionsTheme: _createPageTransitionsTheme(),
      ),
      home: MusicHomePage(),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('zh', 'CH'),
        const Locale('en', 'US'),
      ],
    );
  }

  _createPageTransitionsTheme() {
    return PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.android: ZoomPageTransitionsBuilder()
      },
    );
  }
}

class MusicHomePage extends StatefulWidget {
  @override
  _MusicHomePageState createState() => _MusicHomePageState();
}

class _MusicHomePageState extends State<MusicHomePage>
    with SingleTickerProviderStateMixin {
  int _currentTabIndex = 2;
  final _itemLength = 5;
  TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: _tabController,
        children: [
          Container(
            child: Center(
              child: Text("发现"),
            ),
          ),
          Container(
            child: Center(
              child: Text("播客"),
            ),
          ),
          MyPage(),
          Container(
            child: Center(
              child: Text("K歌"),
            ),
          ),
          Container(
            child: Center(
              child: Text("云村"),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.red,
        selectedLabelStyle: TextStyle(fontSize: 18, color: Colors.black),
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        currentIndex: _currentTabIndex,
        onTap: (index) {
          setState(() {
            _currentTabIndex = index;
            _tabController.animateTo(index);
          });
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            label: "发现",
            icon: Icon(Icons.ac_unit),
          ),
          BottomNavigationBarItem(
            label: "播客",
            icon: Icon(Icons.ac_unit),
          ),
          BottomNavigationBarItem(
            label: "我的",
            icon: Icon(Icons.ac_unit),
          ),
          BottomNavigationBarItem(
            label: "K歌",
            icon: Icon(Icons.ac_unit),
          ),
          BottomNavigationBarItem(
            label: "云村",
            icon: Icon(Icons.ac_unit),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  void initState() {
    super.initState();
    _setStatusBarColor();
    _tabController =
        TabController(initialIndex: 2, length: _itemLength, vsync: this);
  }

  void _setStatusBarColor() {
    if (defaultTargetPlatform == TargetPlatform.android) {
      SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        // statusBarBrightness: Brightness.dark,
      );
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      /**手机的状态栏默认为打开的
       * 判断是否为苹果手机。如果是，并且padding top不为0即为x系列
       * 其他系列关闭状态栏
       */
      if (MediaQuery.of(context).padding.top == null ||
          MediaQuery.of(context).padding.top == 0) {
        SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
      }
    }
  }
}