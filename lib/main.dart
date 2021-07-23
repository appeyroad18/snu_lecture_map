import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:snu_lecture_map/map.dart';
import 'package:snu_lecture_map/search.dart';
import 'package:snu_lecture_map/setting.dart';
import 'package:snu_lecture_map/timetable.dart';

///global variable
class CurrentScreenNumber{
  int? currentNum;
  CurrentScreenNumber({this.currentNum});

  void changeCurrentNum(int changeTo){
    this.currentNum = changeTo;
  }
}

final int content_num = 4;

StreamController _controller = StreamController();
///

void main(){
  runApp(SNUMap());
}

class SNUMap extends StatelessWidget {
  const SNUMap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => BoxSize(),
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
  CurrentScreenNumber csn = CurrentScreenNumber(currentNum: 0);
  //Matrix4 resetmatrix = Matrix4.identity();
  Stream stream = _controller.stream;

 @override
  void initState() {
    // TODO: implement initState
   super.initState();
   stream.listen((current_touched) {
     setState(() {
       csn.currentNum = current_touched;
     });
   });
  }

  @override
  Widget build(BuildContext context) {
    double screen_height = MediaQuery.of(context).size.height;
    double screen_width = MediaQuery.of(context).size.width;
    double menubar_height = 50;

   return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            height: screen_height - menubar_height,
            child: Stack(
              children: [
                //Container(height: double.infinity,),
                Visibility(
                  visible: csn.currentNum == 0,
                  child: MapScreen(),
                ),
                Visibility(
                  visible: csn.currentNum == 1,
                  child: SearchScreen(),
                ),
                Visibility(
                  visible: csn.currentNum == 2,
                  child: TimeTable(),
                ),
                Visibility(
                  visible: csn.currentNum == 3,
                  child: SettingScreen(),
                ),
              ],
            ),
          ),
          Container(
            height: menubar_height,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                BottomButton(button_pos: 0, content: '지도', csn: csn,),
                BottomButton(button_pos: 1, content: '검색', csn: csn,),
                BottomButton(button_pos: 2, content: '내 강의', csn: csn,),
                BottomButton(button_pos: 3, content: '설정', csn: csn,),
              ],
            ),
          ),
        ],
      ),
    );
  }
}



class BottomButton extends StatefulWidget {
  int button_pos;
  String content;
  CurrentScreenNumber csn;

  BottomButton({Key? key, required this.button_pos, required this.content, required this.csn,}) : super(key: key);

  @override
  _BottomButtonState createState() => _BottomButtonState();
}

class _BottomButtonState extends State<BottomButton> {
  @override
  Widget build(BuildContext context) {
    int tempnum = 0; // garbage value. to update stream. no meaning
    double screen_width = MediaQuery.of(context).size.width;

    return FlatButton(
      onPressed: (){
        if(widget.csn.currentNum != widget.button_pos){
          _controller.add(widget.button_pos);
        }
      },
      child: Text(widget.content),
      minWidth: screen_width/content_num,
      color: Colors.blue,
      height: 50,
    );
  }
}


