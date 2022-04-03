import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'dart:math';

import 'package:snu_lecture_map/dataclass.dart';
import 'package:snu_lecture_map/search.dart';

double appBar = 0;
double bottomBar = 0;
double height = 0;
double vertical = 0;
double screen_width = 0;
double screen_height = 0;
List lecturesList = dataclass;

List colors= [
  [0xFFFCE4EC, -1], // pink
  [0xFFFFB74D, -1], // yellow
  [0xFF9CCC65, -1],// lightGreen
  [0xFF90CAF9, -1],// blue
  [0xFFE1BEE7, -1],// purple
];

List colorList = [[0xFFFFFFFF],
  [0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF],
  [0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF],
  [0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF],
  [0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF],
  [0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF],
  [0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF],
  [0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF]
];

int count = 0;
List item = ['강의명', '교수', ''];
List<LectureTime> lectureTimeList= [];

int upperLimit = 1; // 9시
int lowerLimit = 9+1; // 18시
int timeTableCount = (lowerLimit - upperLimit);

int dayUpperLimit = 0; //
int dayLowerLimit = 5+1; //
int dayCount = (dayLowerLimit - dayUpperLimit);

class TimeTableBox extends StatelessWidget {
  Dataclass lecture;
  TimeTableBox({Key? key, required this.lecture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}


class TimeTable extends StatefulWidget {
  double bottomBarHeight;
  double appBarHeight;

  TimeTable({Key? key, required this.bottomBarHeight, required this.appBarHeight}) : super(key: key);

  @override
  TimeTableState createState() => TimeTableState();
}

class TimeTableState extends State<TimeTable> {

  List day = [["", 0, 1],["월", 0, 1],["화", 0, 1],["수", 0, 1],["목", 0, 1],["금", 0, 1], ["토", 0, 1], ["일", 0, 1]];
  List<dynamic> info = [["8","9","10","11","12", "13","14", "15", "16", "17", "18","19","20","21"],
    [Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1)],
    [Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1)],
    [Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1)],
    [Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1)],
    [Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1)],
    [Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1)],
    [Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1), Dataclass(idx: -1)],
  ];

  @override
  Widget build(BuildContext context) {
    screen_width = MediaQuery.of(context).size.width;
    screen_height = MediaQuery.of(context).size.height;
    double basic_height = ((screen_height - widget.appBarHeight - widget.bottomBarHeight-60-20) / (timeTableCount*2+1));
    ; // (30분길이)
    appBar = widget.appBarHeight;
    bottomBar = widget.bottomBarHeight;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '시간표',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 1,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            color: Colors.black,
            onPressed: () async {
              final value = await Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LectureListView(info)));
              setState(() {});
              //showSearch(context: context, delegate: DataSearch());
            },
          ),
          IconButton(
              icon: Icon(Icons.add_box_outlined),
              color: Colors.black,
              onPressed: () async {
                lectureTimeList = await [];
                item = await ['강의명', '교수', ''];
                final value = await Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddLecture(info : info)));
                setState(() {});
              }
            //_onButtonPressed(),
          ),
          IconButton(
            icon: Icon(Icons.settings),
            color: Colors.black,
            onPressed: () {
              _onButtonPressed();
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            ListTile(
              contentPadding: EdgeInsets.fromLTRB(20, 30, 10, 10),
              title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "2021 여름학기",
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "시간표",
                        style:
                        TextStyle(color: Colors.black54, fontSize: 15),
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          /*
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SecondPage()));

                             */
                        },
                        child: Text(
                          "시간표1",
                          style: TextStyle(
                              color: Colors.black54, fontSize: 15),
                        )),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "시간표2",
                        style:
                        TextStyle(color: Colors.black54, fontSize: 15),
                      ),
                    )
                  ]),
            ),
          ],
        ),
      ),
      body:
      Column(
        children: [
          SizedBox(
              height : basic_height,
              width: screen_width,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: dayCount,
                itemBuilder: (context, index_day) {
                  return Container(
                      width: index_day == 0 ? (screen_width) / (dayCount*2-1) : (screen_width) / (dayCount*2-1)*2,
                      child: Text(day[index_day][0]),
                      decoration: BoxDecoration(
                          border: Border(right : index_day != dayLowerLimit ? BorderSide(color: Colors.grey, width: 1) : BorderSide(color: Colors.grey, width: 0)
                          )
                      )
                  );
                },
              )
          ),
          Container(color: Colors.grey, height:1),
          SizedBox(
              height : basic_height*timeTableCount*2,
              width: screen_width,
              child:  ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: dayCount,
                itemBuilder: (context, index_h) {
                  return SizedBox(
                      width: index_h == 0 ? (screen_width) / (dayCount*2-1) : (screen_width) / (dayCount*2-1)*2,
                      child: ListView.separated(
                        itemCount: (index_h == 0) ? timeTableCount : timeTableCount*2,
                        separatorBuilder: (context, index) => Divider(height: 0, thickness: 1, color: Colors.grey),
                        itemBuilder: (context, index_v) {

                          if (index_h ==0) {index_v = index_v + upperLimit;}
                          else {index_v = index_v + upperLimit*2;}
                          if (index_h == 0) {
                              return Container(
                                  width : (screen_width) / 11,
                                  height: basic_height*2,
                                  child: Text(info[index_h][index_v]),
                                  decoration: BoxDecoration(
                                      border: Border(right : BorderSide(color: Colors.grey, width: 1),),
                                      color: Color(colorList[0][0])
                                  )
                              );
                            }
                            else {
                              return GestureDetector(
                                onTap: () async {
                                  if (info[index_h][index_v].idx != -1) {
                                    final value = await Navigator.push(context,
                                        MaterialPageRoute(builder: (context) =>
                                            LecturePage(
                                                lecture: info[index_h][index_v])));
                                    setState(() {});
                                  }
                                },
                                onLongPress: () async {
                                  if (info[index_h][index_v].idx != -1) {
                                    await _delete(info[index_h][index_v]);
                                    setState(() {});
                                  }
                                },
                                child: Container(
                                    height: info[index_h][index_v].idx == -1 ? basic_height
                                        : info[index_h][index_v].time == "-"? 0 : basic_height * (info[index_h][index_v].lecture_time[0].EndTime - info[index_h][index_v].lecture_time[0].StartTime),
                                    decoration: BoxDecoration(
                                        border: Border(right : index_h != dayLowerLimit ? BorderSide(color: Colors.grey, width: 1) : BorderSide(color: Colors.grey, width: 0)),
                                        color: Color(colorList[index_h][index_v])
                                    ),
                                    child: (info[index_h][index_v].name == null) ? Text("") :
                                    Column(
                                      children: [
                                        Text('${info[index_h][index_v].name}'),
                                        //Text('${info[index_five][index_twenty].professor}')
                                      ],
                                    )
                                ),
                              );
                            }
                          },
                      )
                  );
                },
              )
          ),
          Container(color: Colors.grey, height:1),
        ],
      ),
    );
  }


  Future _delete(Dataclass lecture) => showDialog(
    context: context,
    barrierDismissible: false, //barrierDismissible - Dialog를 제외한 다른 화면 터치 x
    builder: (BuildContext context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0)),
          title: Column(
            children: <Widget>[
              new Text("강의 삭제"),
            ],
          ),
          content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "${lecture.name}을(를) 정말 삭제하시겠습니까?",
                    ),
                  ],
                );
              }
          ),
          actions: <Widget>[
            new TextButton(
                child: new Text("취소"),
                onPressed: () {
                  Navigator.pop(context);
                }
            ),
            new TextButton(
              child: new Text("확인"),
              onPressed: () {

                // info, coloList 비우기
                for (int i = 1; i < info.length; i++) {
                  for (int j = 0; j < info[i].length; j++) {
                    if (info[i][j].idx == lecture.idx) {
                      info[i][j] = Dataclass(idx: -1);
                      colorList[i][j] = 0xFFFFFFFF;
                    }
                  }
                }

                // colors 리스트 해당 색깔 인덱스 초기화
                for (int i = 0; i < colors.length; i++) {
                  if (colors[i][1] == lecture.idx) {
                    colors[i][1] = -1;
                    break;
                  }
                }
                print(colors);

                int earliestTime = 1;
                int latestTime = 9+1;

                List minMaxCheck = [];
                for (int i=1; i<=7; i++) {
                  for (int j=0; j<= 27; j++) {
                    if (info[i][j].idx != -1) {
                      minMaxCheck.add(j);
                    }
                  }
                }

                minMaxCheck.sort();

                print(minMaxCheck);
                if (minMaxCheck.length > 0) {
                  if (minMaxCheck[0] ~/ 2 < earliestTime) {
                    earliestTime = minMaxCheck[0] ~/ 2;
                  }
                  if (minMaxCheck[minMaxCheck.length - 1] ~/ 2 + 1 >
                      latestTime) {
                    latestTime = minMaxCheck[minMaxCheck.length -
                        1] ~/ 2 + 1;
                  }
                }

                print(earliestTime);
                print(latestTime);

                dayLowerLimit = 5+1;

                for (int i=6; i<=7; i++) {
                  for (int j = 0; j <= 27; j++) {
                    print('${i}, ${j}');
                    print(info[i][j].idx);
                    if (info[i][j].idx != -1) {
                      dayLowerLimit = i + 1;
                      print('${i}, ${j}');

                    }
                  }
                }

                print(dayLowerLimit);

                print(earliestTime);
                print(latestTime);

                upperLimit = earliestTime;
                lowerLimit = latestTime;
                timeTableCount = (lowerLimit - upperLimit);
                dayCount = (dayLowerLimit - dayUpperLimit);

                this.setState(() {});
                Navigator.pop(context);
              },
            ),

          ],
        )
    ),
  );

  Future _deleteAll() => showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        shape : RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)
        ),
        title: Text("모든 강의를 삭제하시겠습니까?"),
        actions: <Widget>[
          new TextButton(
            child: new Text("취소"),
            onPressed: () {
              Navigator.pop(context);},),
          new TextButton(
            child: new Text("확인"),
            onPressed: () {
              for (int i=1; i < info.length; i++) {
                for (int j = 0; j < info[i].length; j++) {
                  info[i][j] = Dataclass(idx: -1);
                  colorList[i][j] = 0xFFFFFFFF;
                }
              }

              for (int i = 0; i < colors.length; i++) {
                colors[i][1] = -1;
              }
              print(colors);

              upperLimit = 1; // 9시
              lowerLimit = 9+1; // 18시
              timeTableCount = (lowerLimit - upperLimit);

              dayUpperLimit = 0; //
              dayLowerLimit = 5+1; //
              dayCount = (dayLowerLimit - dayUpperLimit);

              this.setState(() {});
              Navigator.pop(context);
            },
          )
        ],
      );
    },
  );

  void _onButtonPressed() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: Color(0xFF737373),
            height: 80,
            child: Container(
              child: Column(
                children: [SizedBox(height: 20),
                  ListTile(
                    leading: Icon(Icons.delete),
                    title: Text("삭제"),
                    onTap: () {
                      Navigator.pop(context);
                      _deleteAll();},)],),
              decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(30),
                    topRight: const Radius.circular(30),
                  )),
            ),
          );
        });
  }
}


class LecturePage extends StatefulWidget {
  Dataclass lecture;
  LecturePage({Key? key, required this.lecture}) : super(key: key);

  @override
  _LecturePageState createState() => _LecturePageState();
}

class _LecturePageState extends State<LecturePage> {
  @override
  Widget build(BuildContext context) {
    Dataclass lecture = widget.lecture;
    List lectureInfo = [lecture.idx.toString(), lecture.name, lecture.professor, lecture.time.toString()];
    List itemName = ['index', '강의명', '교수명', '강의시간'];
    //List itemGroup1 = ['강의명','교수명', '강의실', '강의시간', '색'];
    //List itemGroup2 = ['학점', '개설학과', '학년', '교과구분', '과정구분', '교과목 번호', '비고'];

    return Scaffold(
      appBar: AppBar(
        title: Text('강의정보', style: TextStyle(color: Colors.black),),
        elevation: 1,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body : Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
            child: ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  return Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Align(alignment: Alignment.centerLeft,
                              child:Text(itemName[index])),
                        ),
                        Expanded(child:Container(), flex : 1),
                        Expanded(flex : 10, child: Align(alignment: Alignment.centerLeft, child:Text(lectureInfo[index]),)),
                      ]
                  );
                },
                separatorBuilder: (context, index) => Container(color: Colors.black26, height:0.5),
                itemCount: itemName.length)
        ),
      ),
    );
  }
}

class LectureTile extends StatelessWidget {
  LectureTile(this._lecture);

  final Dataclass _lecture;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(_lecture.name!),
      subtitle: Text(_lecture.professor!),
    );
  }
}

class LectureListView extends StatefulWidget {
  LectureListView(this._info);
  final List<dynamic>  _info;

  @override
  _LectureListViewState createState() => _LectureListViewState();
}

class _LectureListViewState extends State<LectureListView> {
  @override
  Widget build(BuildContext context1) {

    List<dynamic> info = widget._info;

    return Scaffold(
        appBar: AppBar(
          title: Text('시간표를 검색하세요'),
        ),
        body: Opacity(
          opacity: 1,
          child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: lecturesList.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                    child: LectureTile(lecturesList[index]),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {

                            int earliestTime = 1; // 9시
                            int latestTime = 9+1; // 17시 (즉, 18시까지)

                            List minMaxCheck = [];
                            for (int i=1; i<=7; i++) {
                              for (int j=0; j<= 27; j++) {
                                if (info[i][j].idx != -1) {
                                  minMaxCheck.add(j);
                                }
                              }
                            }

                            minMaxCheck.sort();

                            print(minMaxCheck);
                            if (minMaxCheck.length > 0) {
                              if (minMaxCheck[0] ~/ 2 < earliestTime) {
                                earliestTime = minMaxCheck[0] ~/ 2;
                              }
                              if (minMaxCheck[minMaxCheck.length - 1] ~/ 2 + 1 >
                                  latestTime) {
                                latestTime = minMaxCheck[minMaxCheck.length -
                                    1] ~/ 2 + 1;
                              }
                            }

                            print(earliestTime);
                            print(latestTime);

/*
                            for (int i=1; i<=7; i++) { // 월요일부터 일요일까지
                              print('${i}요일');
                              for (int j=0; j ~/ 2 <= earliestTime; j++) { // 8시부터 최대 9시까지 확인
                                print(j);
                                print(info[i][j].idx);
                                if (info[i][j].idx != -1) {
                                  earliestTime = j ~/ 2 == 0 ? 0 : j ~/ 2 -1;
                                  break;
                                }
                              }
                              for (int j=27; j ~/ 2 >= latestTime; j--) { // 21시 반부터 최대 6시까지 확인
                                print(j);
                                print(info[i][j].idx);
                                if (info[i][j].idx != -1) {
                                  latestTime = j ~/ 2 == 13 ? 13 : j ~/ 2 +1;
                                  print('lastTime: ${j}, ${j~/2+1}');
                                  break;
                                }
                              }
                            }

 */

                            for (int i=6; i<=7; i++) {
                              for (int j = 0; j <= 27; j++) {
                                if (info[i][j].idx != -1) {
                                  dayLowerLimit = i + 1;
                                }
                              }
                            }

                            print(lecturesList[index].name);
                            print(lecturesList[index].lecture_time);

                            bool filled = false;
                            for (int time_index = 0; time_index < lecturesList[index].lecture_time.length; time_index++) {
                              int day = (lecturesList[index].lecture_time[time_index].day == 0) ? 7: lecturesList[index].lecture_time[time_index].day;
                              double startTime = lecturesList[index].lecture_time[time_index].StartTime + 1;
                              double endTime = lecturesList[index].lecture_time[time_index].EndTime + 1;

                              print(day);
                              print(startTime);
                              print(endTime);

                              if (startTime ~/ 2 < earliestTime) {earliestTime = startTime ~/ 2;}
                              if (endTime ~/ 2 + 1 > latestTime) {latestTime = endTime % 2 == 1 ? endTime ~/ 2 + 1 : endTime ~/ 2;}
                              if (day+1 > dayLowerLimit) {dayLowerLimit = day+1;}

                              for (int i = startTime.toInt(); i < endTime; i++) {
                                if (info[day][i].idx != -1) {
                                  filled = true;
                                }
                              }
                            }

                            if (filled) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)
                                ),
                                title: Text("겹치는 시간대의 강의가 존재합니다"),
                                actions: <Widget>[
                                  TextButton(
                                    child: new Text("확인"),
                                    onPressed: () {
                                      filled = false;
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              );
                            }
                            else {
                              upperLimit = earliestTime;
                              lowerLimit = latestTime;
                              timeTableCount = (lowerLimit - upperLimit);
                              dayCount = (dayLowerLimit - dayUpperLimit);

                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)
                                ),
                                title: Text(
                                    "${lecturesList[index].name}을(를) 추가하시겠습니까?"),
                                actions: <Widget>[
                                  TextButton(
                                    child: new Text("취소"),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },),
                                  TextButton(
                                      child: new Text("확인"),
                                      onPressed: () {
                                        int color = 0xFFFFFFFF;
                                        for (int i = 0; i < colors.length; i++) {
                                          if (colors[i][1] == -1) {
                                            color = colors[i][0];
                                            colors[i][1] = lecturesList[index].idx;
                                            break;
                                          }
                                        }
                                        print(colors);

                                        for (int time_index = 0; time_index <
                                            lecturesList[index].lecture_time
                                                .length; time_index++) {
                                          int day = (lecturesList[index]
                                              .lecture_time[time_index].day == 0) ? 7:
                                          lecturesList[index]
                                              .lecture_time[time_index].day;
                                          double startTime = lecturesList[index]
                                              .lecture_time[time_index].StartTime+1;
                                          double endTime = lecturesList[index]
                                              .lecture_time[time_index].EndTime+1;

                                          for (int i = startTime.toInt(); i <
                                              endTime; i++) {
                                            if (i == startTime) {
                                              info[day][i] = lecturesList[index];
                                              colorList[day][i] = color;
                                            } else {
                                              Dataclass newLecture = new Dataclass(
                                                  idx: lecturesList[index].idx,
                                                  time: "-");
                                              info[day][i] = newLecture;
                                              colorList[day][i] = 0xFFFFFFFF;
                                            }
                                          }
                                        }

                                        print(info);
                                        print(colorList);
                                        print(colors);
                                        Navigator.pop(context);
                                        Navigator.pop(context1);
                                      }
                                  ),
                                ],
                              );
                            }
                          }
                      );
                    }
                );
              }
          ),
        )
    );
  }
}


class AddLecture extends StatefulWidget {
  List info;
  AddLecture({Key? key, required this.info}) : super(key: key);

  @override
  _AddLectureState createState() => _AddLectureState();
}


class _AddLectureState extends State<AddLecture> {
  @override
  Widget build(BuildContext context_) {
    List info = widget.info;
    Dataclass newLecture = new Dataclass(idx: -1, name: "", professor: "", n14 : "" );

    return Scaffold(
        appBar: AppBar(
          title: Text('시간표 추가', style: TextStyle(color: Colors.black),),
          elevation: 1,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          actions: <Widget>[
            new IconButton(
              icon: new Icon(Icons.check),
              onPressed: () {
                print(newLecture.name);
                print(item);
                if (newLecture.name == "" || item.length <= 3) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)
                        ),
                        title: item.length <= 3 ? Text("시간을 선택하세요") : Text("강의명을 입력하세요"),
                        actions: <Widget>[
                          TextButton(
                            child: new Text("확인"),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          )
                        ],
                      );
                    },
                  );
                }
                else {

                  // 인덱스 넣기
                  count ++;
                  newLecture.idx = 10000000 + count;

                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        List dataClasses = [];
                        bool filled = false;

                        // item: 4번째 원소부터 시간대 나타나는 리스트 [요일, 시작시간, 끝시간] (요일: 1-월 ~ 7-일, 시간: 0-8시 ~ 27-21시 반)
                        for (int i = 3; i < item.length; i++) {
                          if (item[i][2] != 0) {
                            LectureTime lectureTime = new LectureTime();
                            lectureTime.day = item[i][2][0];
                            lectureTime.StartTime = item[i][2][1].toDouble();
                            lectureTime.EndTime = item[i][2][2].toDouble();
                            lectureTimeList.add(lectureTime);
                          }
                        }

                        for (int i = 0; i < lectureTimeList.length; i++) {
                          Dataclass eachLecture = new Dataclass(idx: newLecture.idx, name: newLecture.name, professor: newLecture.professor);
                          eachLecture.lecture_time = [lectureTimeList[i]];
                          dataClasses.add(eachLecture);
                        }
                        // 여기까지의 코드로 dataClasses에 한 과목에 대한 여러개의 시간 대의 수업이 모두 담기게 됨

                        // 시간표 크기 조절 (현재 표시된 시간표 화면 밖에 강의가 존재하는 경우 시간표 크기 조절)
                        // 주의: info (0: 8시, 1: 9시, ... 13: 21시), 추가되는 강의의 시간 (0: 8시, 1: 8시 반, ... 26: 21시, 27: 21시 반)
                        int earliestTime = 1; // 9시
                        int latestTime = 9+1; // 17시 (즉, 18시까지)

                        List minMaxCheck = [];
                        for (int i=1; i<=7; i++) {
                          for (int j=0; j<= 27; j++) {
                            if (info[i][j].idx != -1) {
                              minMaxCheck.add(j);
                            }
                          }
                        }

                        minMaxCheck.sort();

                        print(minMaxCheck);
                        if (minMaxCheck.length > 0) {
                          if (minMaxCheck[0] ~/ 2 < earliestTime) {
                            earliestTime = minMaxCheck[0] ~/ 2;
                          }
                          if (minMaxCheck[minMaxCheck.length - 1] ~/ 2 + 1 >
                              latestTime) {
                            latestTime = minMaxCheck[minMaxCheck.length -
                                1] ~/ 2 + 1;
                          }
                        }

                        print(earliestTime);
                        print(latestTime);

                        for (int i=6; i<=7; i++) {
                          for (int j = 0; j <= 27; j++) {
                            if (info[i][j].idx != -1) {
                              dayLowerLimit = i + 1;
                            }
                          }
                        }

                        for (int time_index = 0; time_index < dataClasses.length; time_index++) {
                          int day = dataClasses[time_index].lecture_time![0].day!;
                          double startTime = dataClasses[time_index].lecture_time![0].StartTime!;
                          double endTime = dataClasses[time_index].lecture_time![0].EndTime!;

                          print(day);
                          print(startTime);
                          print(endTime);

                          if (startTime ~/ 2 < earliestTime) {earliestTime = startTime ~/ 2;}
                          if (endTime ~/ 2 + 1 > latestTime) {latestTime = endTime % 2 == 1 ? endTime ~/ 2 + 1 : endTime ~/ 2;}
                          if (day+1 > dayLowerLimit) {dayLowerLimit = day+1;}

                          // 중복 확인
                          for (int i = startTime.toInt(); i < endTime; i++) {
                            if (info[day][i].idx != -1) {
                              filled = true;
                            }
                          }
                        }

                        if (filled) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)
                            ),
                            title: Text("겹치는 시간대의 강의가 존재합니다"),
                            actions: <Widget>[
                              TextButton(
                                child: new Text("확인"),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                        }

                        else {
                          upperLimit = earliestTime;
                          lowerLimit = latestTime;
                          timeTableCount = (lowerLimit - upperLimit);
                          dayCount = (dayLowerLimit - dayUpperLimit);

                          print(upperLimit);
                          print(lowerLimit);
                          print(timeTableCount);
                          print(dayCount);

                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)
                            ),
                            title: Text("강의를 추가하시겠습니까?"),
                            actions: <Widget>[
                              TextButton(
                                child: new Text("취소"),
                                onPressed: () {
                                  Navigator.pop(context);
                                },),
                              TextButton(
                                child: new Text("확인"),
                                onPressed: () {
                                  int color = 0xFFFFFFFF;
                                  for (int i = 0; i < colors.length; i++) {
                                    if (colors[i][1] == -1) {
                                      color = colors[i][0];
                                      colors[i][1] = newLecture.idx;
                                      break;
                                    }
                                  }
                                  print(colors);

                                  for (int time_index = 0; time_index < dataClasses.length; time_index++) {
                                    int day = dataClasses[time_index].lecture_time![0].day!;
                                    double startTime = dataClasses[time_index].lecture_time![0].StartTime!;
                                    double endTime = dataClasses[time_index].lecture_time![0].EndTime!;

                                    for (int i = startTime.toInt(); i < endTime; i++) {
                                      print(startTime);
                                      print(i);
                                      print(endTime);
                                      if (i == startTime) {
                                        info[day][i] = dataClasses[time_index];
                                        colorList[day][i] = color;
                                      } else {
                                        print(dataClasses[time_index].idx);
                                        Dataclass newLecture = new Dataclass(
                                            idx: dataClasses[time_index].idx,
                                            time: "-");
                                        info[day][i] = newLecture;
                                        colorList[day][i] = 0xFFFFFFFF;
                                      }
                                    }
                                  }
                                  setState(() {});
                                  Navigator.pop(context);
                                  Navigator.pop(context_);
                                },
                              )
                            ],
                          );
                        };
                      }
                  );
                }
              },
            ),
          ],
        ),
        body : Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView.builder(
                itemCount: item.length,
                itemBuilder: (BuildContext context, int index) {
                  if (index == 0 || index == 1) {
                    return Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Align(alignment: Alignment.centerLeft,
                                child: Text(item[index])),
                          ),
                          Expanded(child: Container(), flex: 1),
                          Expanded(flex: 10,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: TextField(
                                    style: TextStyle(fontSize: 14),
                                    cursorColor: Colors.grey,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "입력하세요"),
                                    onChanged: (value) {
                                      if (index == 0) {
                                        newLecture.name = value;
                                        print(newLecture.name);
                                      }
                                      else{
                                        newLecture.professor = value;}
                                    }),
                              )
                          ),
                        ]
                    );
                  }
                  else if (index == 2) {
                    return TextButton(
                      child: Text('시간 및 장소 추가'),
                      onPressed: () {
                        item.add([1, "시간을 선택하세요", 0]);
                        setState(() {});
                        print(item);
                      },
                    );
                  }
                  else {
                    if (item[index][0] == 1) {
                      return Column(
                        children: [
                          Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Align(alignment: Alignment.centerLeft,
                                      child: Text('시간')),
                                ),
                                Expanded(child: Container(), flex: 1),
                                Expanded(flex: 10,
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: GestureDetector(
                                          child: Text(item[index][1]),
                                          onTap: () {
                                            List _ = showPickerModal(index);
                                            setState(() {});
                                          }),
                                    )
                                ),
                              ]
                          ),

                          Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Align(alignment: Alignment.centerLeft,
                                      child: Text('장소')),
                                ),
                                Expanded(child: Container(), flex: 1),
                                Expanded(flex: 9,
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: TextField(
                                          style: TextStyle(fontSize: 14),
                                          cursorColor: Colors.grey,
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "입력하세요"),
                                          onChanged: (value) {
                                            newLecture.n14 = value;
                                          }),)),
                                Expanded(
                                    flex: 1,
                                    child: IconButton(
                                      icon : Icon(Icons.remove_circle_outline),
                                      onPressed: () {
                                        item.removeAt(index);
                                        setState(() {});
                                        print(item);
                                      },
                                    ))
                              ]
                          ),
                        ],
                      );
                    }
                    else {
                      return Container();
                    }
                  }
                }
            )
        )
    );

  }
  List PickerData = [
    ["월", "화", "수", "목", "금", "토", "일"],
    [8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22],
    ["00", "30"],
    [8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22],
    ["00", "30"]
  ];


  showPickerModal(int index) {
    List timeList = [];
    new Picker(
        adapter: PickerDataAdapter<String>(pickerdata: PickerData, isArray: true),
        hideHeader: false,
        onConfirm: (Picker picker, List value) async {
          double startTime = value[1].toDouble();
          double endTime = value[3].toDouble();

          if (value[2] == 1) {
            startTime += 0.5;
          }
          if (value[4] == 1) {
            endTime += 0.5;
          }

          if (startTime >= endTime) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return AlertDialog(
                  shape : RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  title: Text("종료 시간을 시작 시간 이후로 설정해주세요."),
                  actions: <Widget>[
                    new TextButton(
                      child: new Text("확인"),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                );
              },
            );
          }
          else {
            String day = PickerData[0][value[0]];
            String Stime = PickerData[1][value[1]].toString() + ":" +
                PickerData[2][value[2]];
            String Etime = PickerData[3][value[3]].toString() + ":" +
                PickerData[4][value[4]];
            String time = day + ' ' + Stime + ' - ' + Etime;
            item[index][1] = time;

            // List hour_temp = i*2 for i in 0:14;
            List hour = [0, 2, 4, 6, 8, 10, 12, 14, 16 ,18 ,20, 22, 24, 26, 28];
            List minute = [0, 1];
            item[index][2] = [value[0]+1, hour[value[1]] + minute[value[2]], hour[value[3]] + minute[value[4]]];

            print(item);
            setState(() {});
          }
        }
    ).showModal(this.context);//_scaffoldKey.currentState);
    return timeList;
  }

}
