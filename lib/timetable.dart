import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';

import 'dart:io';
import 'dart:math';
import 'package:snu_lecture_map/dataclass.dart';
import 'package:snu_lecture_map/search.dart';

double height = 0;
double vertical = 0;
double screen_width = 0;
double screen_height = 0;

class LectureTime{
  int day = 0;
  double StartTime = 0;
  double EndTime = 0;

  LectureTime(this.day, this.StartTime, this.EndTime);
}

class LectureBR{
  String? Building;
  String? Room;
}


class Lecture {
  int idx = 0;
  String name = "";
  String professor = "";
  LectureTime time = LectureTime(3, 1, 7);

  Lecture(this.idx, this.name, this.professor);
}


class TimeTable extends StatefulWidget {
  double bottomBarHeight;
  double appBarHeight;

  TimeTable({Key? key, required this.bottomBarHeight, required this.appBarHeight}) : super(key: key);

  @override
  TimeTableState createState() => TimeTableState();
}

class TimeTableState extends State<TimeTable> {

  // 강의명\n 강의실, color, 강의시간(높이)
  // 너비 (index_main으로 조절)
  //String test = dataclass[0].name!;

  List<int> indexList = [];

  List day = [["", 0, 1],["월", 0, 1],["화", 0, 1],["수", 0, 1],["목", 0, 1],["금", 0, 1]];
  List time = [["9", 0, 2],["10", 0,2],["11", 0,2],["12", 0,2],["13", 0,2],["14", 0,2],["15", 0,2],["16", 0,2],["17", 0,2],["18", 0,2]];
  List<dynamic> info = [
    [new Lecture(-1, "", ""), new Lecture(-1, "", ""), new Lecture(-1, "", ""), new Lecture(-1, "", ""), new Lecture(-1, "", ""), new Lecture(-1, "", ""), new Lecture(-1, "", ""), new Lecture(-1, "", ""), new Lecture(-1, "", ""), new Lecture(-1, "", ""),
      new Lecture(-1, "", ""), new Lecture(-1, "", ""), new Lecture(-1, "", ""), new Lecture(-1, "", ""), new Lecture(-1, "", ""), new Lecture(-1, "", ""), new Lecture(-1, "", ""), new Lecture(-1, "", ""), new Lecture(-1, "", ""), new Lecture(-1, "", "")],
  [new Lecture(-1, "", ""), new Lecture(-1, "", ""), new Lecture(-1, "", ""), new Lecture(-1, "", ""), new Lecture(-1, "", ""), new Lecture(-1, "", ""), new Lecture(-1, "", ""), new Lecture(-1, "", ""), new Lecture(-1, "", ""), new Lecture(-1, "", ""),
    new Lecture(-1, "", ""), new Lecture(-1, "", ""), new Lecture(-1, "", ""), new Lecture(-1, "", ""), new Lecture(-1, "", ""), new Lecture(-1, "", ""), new Lecture(-1, "", ""), new Lecture(-1, "", ""), new Lecture(-1, "", ""), new Lecture(-1, "", "")],
  [new Lecture(-1, "", ""), new Lecture(-1, "", ""), new Lecture(-1, "", ""), new Lecture(-1, "", ""), new Lecture(-1, "", ""), new Lecture(-1, "", ""), new Lecture(-1, "", ""), new Lecture(-1, "", ""), new Lecture(-1, "", ""), new Lecture(-1, "", ""),
    new Lecture(-1, "", ""), new Lecture(-1, "", ""), new Lecture(-1, "", ""), new Lecture(-1, "", ""), new Lecture(-1, "", ""), new Lecture(-1, "", ""), new Lecture(-1, "", ""), new Lecture(-1, "", ""), new Lecture(-1, "", ""), new Lecture(-1, "", "")],
  [new Lecture(-1, "", ""), new Lecture(-1, "", ""), new Lecture(-1, "", ""), new Lecture(-1, "", ""), new Lecture(-1, "", ""), new Lecture(-1, "", ""), new Lecture(-1, "", ""), new Lecture(-1, "", ""), new Lecture(-1, "", ""), new Lecture(-1, "", ""),
    new Lecture(-1, "", ""), new Lecture(-1, "", ""), new Lecture(-1, "", ""), new Lecture(-1, "", ""), new Lecture(-1, "", ""), new Lecture(-1, "", ""), new Lecture(-1, "", ""), new Lecture(-1, "", ""), new Lecture(-1, "", ""), new Lecture(-1, "", "")],
  [new Lecture(-1, "", ""), new Lecture(-1, "", ""), new Lecture(-1, "", ""), new Lecture(-1, "", ""), new Lecture(-1, "", ""), new Lecture(-1, "", ""), new Lecture(-1, "", ""), new Lecture(-1, "", ""), new Lecture(-1, "", ""), new Lecture(-1, "", ""),
    new Lecture(-1, "", ""), new Lecture(-1, "", ""), new Lecture(-1, "", ""), new Lecture(-1, "", ""), new Lecture(-1, "", ""), new Lecture(-1, "", ""), new Lecture(-1, "", ""), new Lecture(-1, "", ""), new Lecture(-1, "", ""), new Lecture(-1, "", "")],];

  List info1 = [[["", 0, 1],["9", 0, 2],["10", 0,2],["11", 0,2],["12", 0,2],["13", 0,2],["14", 0,2],["15", 0,2],["16", 0,2],["17", 0,2],["18", 0,2]],
    [["월", 0, 1],["마케팅관리", 500,3, "58동 304호"],["마케팅관리",0,0,""],["",0,0],["",0,1],["",0,1],["",0,1],["",0,1],["",0,1],["",0,1],["",0,1],["",0,1],["",0,1],["",0,1],["",0,1],["",0,1],["",0,1],["",0,1],["",0,1],["",0,1],["",0,1]],
    [["화", 0, 1],["",0,1],["",0,1],["",0,1],["",0,1],["",0,1],["",0,1],["",0,1],["",0,1],["",0,1],["",0,1],["",0,1],["",0,1],["",0,1],["",0,1],["",0,1],["",0,1],["",0,1],["",0,1],["",0,1],["",0,1]],
    [["수", 0, 1],["마케팅관리", 500,3,""],["",0,0],["",0,0],["",0,1],["",0,1],["",0,1],["",0,1],["",0,1],["",0,1],["",0,1],["",0,1],["",0,1],["",0,1],["",0,1],["",0,1],["",0,1],["",0,1],["",0,1],["",0,1],["",0,1]],
    [["목", 0, 1],["",0,1],["",0,1],["",0,1],["",0,1],["",0,1],["",0,1],["",0,1],["",0,1],["",0,1],["",0,1],["",0,1],["",0,1],["",0,1],["",0,1],["",0,1],["",0,1],["",0,1],["",0,1],["",0,1],["",0,1]],
    [["금", 0, 1],["",0,1],["",0,1],["",0,1],["",0,1],["",0,1],["",0,1],["",0,1],["",0,1],["",0,1],["",0,1],["",0,1],["",0,1],["",0,1],["",0,1],["",0,1],["",0,1],["",0,1],["",0,1],["",0,1],["",0,1]]];



  @override
  Widget build(BuildContext context) {
    screen_width = MediaQuery.of(context).size.width;
    screen_height = MediaQuery.of(context).size.height;
    double basic_height = (screen_height - widget.appBarHeight - widget.bottomBarHeight-60-20) / 21; // (30분길이)



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
                onPressed: () {
                  on_off = false;
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddLecture(info : info1)));
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
        body: Column(
          children: [
            SizedBox(
              height : basic_height,
              width: screen_width,
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index_day) {
                    return SizedBox(
                      width: index_day == 0 ? (screen_width-6) / 11 : (screen_width-6) / 11*2,
                      child: Text(day[index_day][0])
                    );
                  },
                  separatorBuilder: (context, index) => Container(color: Colors.black26, width:1),
                  itemCount: day.length)
            ),
            Container(color: Colors.black26, height:1),
            Row(
              children: [
                SizedBox(
                    height : basic_height*20+10,
                    width: (screen_width-6) / 11,
                    child: ListView.separated(
                        itemBuilder: (context, index_time) {
                          return SizedBox(
                              height: basic_height*2,
                              child: Text(time[index_time][0])
                          );
                        },
                        separatorBuilder: (context, index) => Container(color: Colors.black26, height:1),
                        itemCount: time.length)
                ),
                Container(color: Colors.black26, width:1, height: basic_height*20+10,),
                SizedBox(
                  height : basic_height * 20+10,
                  width: (screen_width-6) / 11*10,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (context, index) => Container(color: Colors.black26, width:1),
                    itemCount: 5,
                    itemBuilder: (context, index_five) {
                      return SizedBox(
                        width: (screen_width-6) / 11*2,
                        child: ListView.separated(
                          itemCount: 20,
                          separatorBuilder: (context, index) => Container(color: Colors.black26, height:0.5),
                          itemBuilder: (context, index_twenty) {
                            return Container(
                              height: info[index_five][index_twenty].idx == -1 ? basic_height :
                              basic_height * (info[index_five][index_twenty].time.EndTime - info[index_five][index_twenty].time.StartTime),
                              child: Column(
                                children: [
                                  Text('${info[index_five][index_twenty].name}'),
                                  //Text('${info[index_five][index_twenty].professor}')
                                ],
                              )
                            );
                          },
                        )
                      );
                    },
                  )

                ),
              ],
            ),
            Container(color: Colors.black26, height:1),

            /*SizedBox(
              height : basic_height * 21,
              width: screen_width,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) => Container(color: Colors.black26, width:1),
                itemCount: 6,
                itemBuilder: (context, index_main) {
                  return SizedBox(
                    width: index_main == 0 ? (screen_width-6) / 11 : (screen_width-6) / 11*2, // 열 넓이
                    child: ListView.builder(
                      //separatorBuilder: (context, index) => Divider(color: Colors.black26, height:1),
                      itemCount:  index_main == 0 ? 11 : 21,
                      itemBuilder: (context, index_each) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder : (context) => LecturePage(lecture : info1[index_main][index_each]))
                            );
                            //print(test);

                            // 각각 강의마다 고유 번호를 달 생각은...?
                            setState(() {
                            });
                          },
                          onLongPress: () {
                            // 바로 지워지긴 함 (연결된 container, 다른 요일의 container를 어떻게 이을 것인가..!)
                            setState(() {
                              info1[5][1][0] = info[0].name;
                              info1[index_main][index_each] = ["", 0, 0, ""];
                            });
                          },
                          child: Container(
                            height : basic_height * info1[index_main][index_each][2],
                            child: Container( // 굳이 없어도 될듯. column으로 구성 변경하기
                              padding: index_each != 0 ? EdgeInsets.all(5) : EdgeInsets.all(0),
                              // 각 리스트의 마지막 객체의 자료형이 String일 때는 Column (강의명 + 강의실) : 그렇지 않으면 Text (시간 or 요일)
                              child : info1[index_main][index_each][info1[index_main][index_each].length-1] is String ?
                              Column(children:
                               [Text('${info1[index_main][index_each][0]}',
                                textAlign: index_main != 0 ? TextAlign.center : TextAlign.right, maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 10),),
                                Text('${info1[index_main][index_each][3]}',
                                  textAlign: index_main != 0 ? TextAlign.center : TextAlign.right, maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 10),),
                              ]) :
                              Text('${info1[index_main][index_each][0]}',
                                textAlign: index_main != 0 ? TextAlign.center : TextAlign.right, maxLines: 2, overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black26, width: 1)),color: Colors.amber[info1[index_main][index_each][1]]), // 내용물이 없을 경우(height == 0) 다르게 처리
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ) */
            ],
        ),
    );
  }
  void _onButtonPressed() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: Color(0xFF737373),
            height: 80,
            child: Container(
              child: _buildButtonMenu(info : info1),
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

class _buildButtonMenu extends StatefulWidget {
  List info;
  _buildButtonMenu({Key? key, required this.info}) : super(key: key);

  @override
  __buildButtonMenuState createState() => __buildButtonMenuState();
}

class __buildButtonMenuState extends State<_buildButtonMenu> {
  @override
  Widget build(BuildContext context) {
    List info = widget.info;

    // 왜 바로 안바뀔까요..? (너무 느린가...?)
    void deleteAll(List list) {
      setState(() {
        for (var i=0; i < list.length; i++) {
          if (i != 0) {
            for (var j=0; j < list[i].length; j++) {
              if(j != 0) {
                list[i][j][0] = "";
                list[i][j][3] = "";
              }}}}}
      );
    }

    void showDeleteMessage(List list) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape : RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)
            ),
            title: Text("모든 강의를 삭제하시겠습니까?"),
            actions: <Widget>[
              TextButton(
                child: new Text("취소"),
                onPressed: () {
                  Navigator.pop(context);},),
              TextButton(
                child: new Text("확인"),
                onPressed: () {
                  Navigator.pop(context);
                  deleteAll(list);
                },
              )
            ],
          );
        },
      );
    }
    return Column(
      children: [SizedBox(height: 20),
        ListTile(
          leading: Icon(Icons.delete),
          title: Text("삭제"),
          onTap: () {
            Navigator.pop(context);
            showDeleteMessage(info);
          },
        )],
    );
  }
}

class LecturePage extends StatefulWidget {
  List lecture;
  LecturePage({Key? key, required this.lecture}) : super(key: key);

  @override
  _LecturePageState createState() => _LecturePageState();
}

class _LecturePageState extends State<LecturePage> {
  @override
  Widget build(BuildContext context) {
    List lecture = widget.lecture;
    List itemGroup1 = ['강의명','교수명', '강의실', '강의시간', '색'];
    List itemGroup2 = ['학점', '개설학과', '학년', '교과구분', '과정구분', '교과목 번호', '비고'];
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
            separatorBuilder: (BuildContext context, int index) => const Divider(),
            itemCount : 2,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                  height: index == 0 ? 25.0 * itemGroup1.length : 25.0 * itemGroup2.length,
                  child : ListView.separated(
                    separatorBuilder: (BuildContext context, int index) => const Divider(color: Colors.white, height: 5),
                    itemCount : index == 0 ? itemGroup1.length : itemGroup2.length,
                    itemBuilder: (BuildContext context, int index_each) {
                      return Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Align(alignment: Alignment.centerLeft,
                                  child:Text(index == 0 ? itemGroup1[index_each] : itemGroup2[index_each], style: TextStyle(color: Colors.black))),
                            ),
                            Expanded(child:Container(), flex : 1),
                            Expanded(flex : 10, child: Align(alignment: Alignment.centerLeft, child:Text('hi'),)),
                          ]
                      );
                    },
                  )
              );
            },
          ),
        ),
      ),
    );
  }
}


List<Lecture> lecturess = [new Lecture(0, "고급영어", "최현빈", ),
  new Lecture(1, "고급영어1", "최현빈", ),
  new Lecture(2, "고급영어2", "최현빈", ),
  new Lecture(3, "고급영어3", "최현빈", ),
  new Lecture(4, "고급영어4", "최현빈", ),
];

class LectureTile extends StatelessWidget {
  LectureTile(this._lecturess);

  final Lecture _lecturess;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(_lecturess.name),
        subtitle: Text(_lecturess.professor),
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
  Widget build(BuildContext context) {

    List<dynamic>  info = widget._info;

    return Scaffold(
      appBar: AppBar(
        title: Text('시간표를 검색하세요')
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: lecturess.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
              child: LectureTile(lecturess[index]),
           onTap: () {
                setState(() {
                  double startTime = lecturess[index].time.StartTime;
                  double endTime = lecturess[index].time.EndTime;

                  for (var i = startTime; i < endTime; i++) {
                    if (i == startTime) {
                      info[lecturess[index].time.day][i] = lecturess[index];
                    } else {
                      Lecture newLecture = new Lecture(lecturess[index].idx, "","");
                      newLecture.time.EndTime = newLecture.time.StartTime;
                      info[lecturess[index].time.day][i] = newLecture;
                    }
                    print(info[lecturess[index].time.day][i].time);
                  }



                });

           },);
        }
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
  Widget build(BuildContext context) {
    List info = widget.info;
    List lectureAdd = ["", 0, 0, ""];
    String time = "시간";
    return Scaffold(
        appBar: AppBar(
          title: Text('시간표 추가', style: TextStyle(color: Colors.black),),
          elevation: 1,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body : Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
                children : [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: TextField(
                      cursorColor: Colors.grey,
                      decoration: InputDecoration(hintText: "강의명"),
                      onChanged: (value) {
                        lectureAdd[0] = value;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: TextField(
                      cursorColor: Colors.grey,
                      decoration: InputDecoration(hintText: "교수명"),
                      onChanged: (value) {

                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
                    child: Align(alignment: Alignment.centerLeft,
                        child: Text('요일 및 시간 선택')),
                  ),
                  TextButton(onPressed: () {
                    showPicker(time);
                  },
                      child: Text(time))

                ]
            )
        )
    );
  }

  void showPicker(String time) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
              color: Colors.white,
              height: 250,
              child: Container(
                  child : CupertinoPicker(
                      itemExtent: 30,
                      magnification: 1,
                      scrollController: FixedExtentScrollController(initialItem: 1),
                      onSelectedItemChanged: (value) {
                        setState() {
                          time = value.toString();
                        }
                      },
                      children : [Text('월'),Text('화'), Text('수'), Text('목'), Text('금')]
                  )
              )
          );
        }
    );
  }
}



int day = 1;
double start_time = 9;
double end_time = 9.5;
String lecture_name = "";
String lecture_professor = "";
String lecture_place = "";
var on_off = false;

class SelfAdd extends StatefulWidget {
  const SelfAdd({Key? key}) : super(key: key);

  void deleteAll(context) {

  }

  @override
  _SelfAddState createState() => _SelfAddState();

}

class _SelfAddState extends State<SelfAdd> {
  @override
  Widget build(BuildContext context) {

    void _showDialog () {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object  of type Dialog
          return CupertinoAlertDialog(
            title: new Text("강좌명을 입력해주세요"),
            actions: <Widget>[
              new TextButton(
                child: new Text("확인"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: TextButton(
                  child: Text("취소",textAlign: TextAlign.left,),
                  onPressed: () {
                    Navigator.pop(context, "");
                  },
                ),
              ),
              Expanded(
                flex :3,
                child: Text(
                  "직접 추가하기",
                  style: TextStyle(fontSize: 15),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                flex: 1,
                child: TextButton(
                  child: Text("확인", textAlign: TextAlign.right),
                  onPressed: () {
                    print(start_time);
                    if (lecture_name != "") {
                      Navigator.pop(context, "");
                      setState(() {
                        day = 1;
                        start_time = 9;
                        end_time = 9.5;
                        lecture_name = "";
                        lecture_professor = "";
                      });
                      print(vertical);
                      print(height);
                      print(start_time);
                    } else if (true) {_showDialog();}
                  },
                ),
              ),
            ],
          ),
          Container(height: 1, color: Colors.black26,),
          ListTile(
            // horizontalTitleGap: -10,
            // leading: Icon(Icons.check, size: 20, color: Colors.white,),
            title: Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: TextField(
                cursorColor: Colors.grey,
                decoration: InputDecoration(hintText: "강의명"),
                onChanged: (value) {
                  lecture_name = value;
                },
              ),
            ),
          ),
          ListTile(
            title: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: TextField(
                cursorColor: Colors.grey,
                decoration: InputDecoration(hintText: "교수명"),
                onChanged: (value) {
                  lecture_professor = value;
                },
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.fromLTRB(40, 20, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  '요일 및 시간 선택',
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
          ),
          TimeSelect(),
          Visibility(child: TimeSelect(), visible: on_off,),
        ],
      ),
    );
  }
}


class TimeSelect extends StatefulWidget {
  //const TimeSelect({Key? key}) : super(key: key);

  @override
  _TimeSelectState createState() => _TimeSelectState();
}

class _TimeSelectState extends State<TimeSelect> {

  List selectedtime = [];
  String start_hour = '9';
  String start_minute = '00';
  String end_hour = '9';
  String end_minute = '30';

  int picker_start_hour = 9;
  int picker_start_minute = 0;
  int picker_end_hour = 9;
  int picker_end_minute = 0;

  void _showDatePicker(context) {
    List<int> _minutes = [0,10,20,30,40,50];

    new Picker(
        adapter: NumberPickerAdapter(data: [
          NumberPickerColumn(begin: 9, end: 18, initValue: picker_start_hour),
          NumberPickerColumn(begin: 0, end: 59, initValue: picker_start_minute, items: _minutes),
          NumberPickerColumn(begin: 9, end: 18, initValue: picker_end_hour),
          NumberPickerColumn(begin: 0, end: 59, initValue: picker_end_minute, items: _minutes),
        ]),
        hideHeader: true,
        /*
        delimiter: [
         // 구분자
          PickerDelimiter(
              child: Container(
               width: 10.0, alignment: Alignment.center, child: Text(':'),
          )),
        ],
         */
        title: Text("시작 시간   ~   종료 시간", textAlign: TextAlign.center,),
        confirmText: "확인",
        cancelText: "취소",
        onConfirm: (Picker picker, List value) {
          setState(() {
            print(value.toString());
            selectedtime = picker.getSelectedValues();
            picker_start_hour = selectedtime[0];
            picker_start_minute = selectedtime[1];
            picker_end_hour = selectedtime[2];
            picker_end_minute = selectedtime[3];

            start_hour = selectedtime[0].toString();
            if (selectedtime[1] < 10) {
              start_minute = selectedtime[1].toString();
              start_minute = '0' + start_minute;
            } else {start_minute = selectedtime[1].toString();
            }
            end_hour = selectedtime[2].toString();
            if (selectedtime[3] < 10) {
              end_minute = selectedtime[3].toString();
              end_minute = '0' + end_minute;
            } else {end_minute = selectedtime[3].toString();
            }
            print(picker.getSelectedValues());
            start_time = selectedtime[0] + selectedtime[1]/60;
            end_time = selectedtime[2] + selectedtime[3]/60;
          });
        }).showDialog(context);
  }

  List<bool> _selections = List.generate(5, (_) => false);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(35, 0, 0, 0),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: Row(
              children: [
                ToggleButtons(
                  children:[
                    Text("월"),
                    Text("화"),
                    Text("수"),
                    Text("목"),
                    Text("금"),],
                  isSelected: _selections,
                  constraints: BoxConstraints(minHeight: 30, minWidth: 40),
                  onPressed: (int index) {
                    setState(() {
                      _selections=List.filled(_selections.length, false);
                      _selections[index] = true;
                      if (_selections[0] == true) {
                        day = 1;
                      } else if (_selections[1] == true) {
                        day = 2;
                      } else if (_selections[2] == true) {
                        day = 3;
                      } else if (_selections[3] == true) {
                        day = 4;
                      } else if (_selections[4] == true) {
                        day = 5;
                      }
                    });
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(5, 0, 40, 0),
            child: Column(
              children: [
                Row(
                  children: [Text("시간",),
                    SizedBox(width: 20,),
                    TextButton(
                      child: Text(start_hour +
                          ':' +
                          start_minute +
                          ' ~ ' +
                          end_hour +
                          ':' +
                          end_minute),
                      onPressed: () => _showDatePicker(context),
                    ),
                  ],
                ),
                /*
                Container(height: 1, color: Colors.black26,),
                Row(
                  children: [
                    TextButton(
                      child: Text("추가"),
                      onPressed: () {
                        setState(() {
                          on_off = true;
                        });},),
                    TextButton(
                      child: Text("삭제"),
                        onPressed: () {
                       setState(() {
                       on_off = false;});},),
                  ],
                )

                 */
              ],
            ),
          ),
        ],
      ),
    );
  }
}

