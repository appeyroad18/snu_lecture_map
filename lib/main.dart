import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:snu_lecture_map/map.dart';
import 'package:snu_lecture_map/search.dart';
import 'package:snu_lecture_map/setting.dart';
import 'package:snu_lecture_map/timetable.dart';


void main(){
  runApp(SNUMap());
}

class SNUMap extends StatelessWidget {
  const SNUMap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (BuildContext context) => BoxSize(),),
        ChangeNotifierProvider(create: (BuildContext context) => Showing(),),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SNUMap',
        theme: ThemeData(
            textTheme: Theme.of(context).textTheme.apply(
              bodyColor: Colors.black,
              displayColor: Colors.blue,
            )
        ),
        home: MainPage(),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Matrix4 transform_matrix = Matrix4.identity();


  @override
  Widget build(BuildContext context) {
    // double screen_height = MediaQuery.of(context).size.height;
    // double screen_width = MediaQuery.of(context).size.width;
    // double menubar_height = 50;
    // double appbar_height = AppBar().preferredSize.height;

    return CupertinoTabScaffold(
      backgroundColor: Colors.white,
      tabBar: CupertinoTabBar(
        backgroundColor: Color(0xffaeddef),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.map_outlined),
              title: Text("map")),
          BottomNavigationBarItem(
              icon: Icon(Icons.search_outlined),
              title: Text("search")),
          BottomNavigationBarItem(
              icon: Icon(Icons.schedule_outlined),
              title: Text("schedule")),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings_applications_outlined),
              title: Text("settings")),
        ],
        activeColor: Color(0xff7e7c7a),
        inactiveColor: Color(0xffa3b6c5),
      ),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(child: MapScreen());
            });
            break;
          // case 1:
          //   return CupertinoTabView(builder: (context) {
          //     return CupertinoPageScaffold(child: SearchScreen());
          //   });
          //   break;
          case 2:
            return CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(child: TimeTable());
            });
            break;
          case 3:
            return CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(child: SettingScreen());
            });
            break;
          default:
            return const CupertinoTabView();
        }
      },
    );
  }
}