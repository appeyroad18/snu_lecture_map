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

List<Lecture> lecturesList = [new Lecture(0, "고급영어", "최현빈", [LectureTime(1, 2, 4), LectureTime(3, 2, 4)], Colors.white),
  new Lecture(1, "마케팅관리", "이서진", [LectureTime(2, 8, 12)],Colors.white),
  new Lecture(2, "회계원리", "이창우", [LectureTime(1, 0, 2), LectureTime(3, 0, 2)],Colors.white),
  new Lecture(3, "벤처창업 웹프로그래밍1", "양진환", [LectureTime(1, 15, 16), LectureTime(3, 15, 16), LectureTime(5, 15, 16)],Colors.white),
  new Lecture(4, "통계학", "한상미", [LectureTime(5, 10, 12)],Colors.white),
];

// dataclass에 color도 넣어주세요!
List colorsList = [
  Colors.red,
  Colors.orange,
  Colors.yellow,
  Colors.green,
  Colors.blue];


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
  List time = [LectureTime(3, 1, 7)];
  Color color = Colors.white;

  Lecture(this.idx, this.name, this.professor, this.time, this.color);
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
  [new Lecture(-1, "", "", [], Colors.white), new Lecture(-1, "", "", [],Colors.white), new Lecture(-1, "", "", [], Colors.white), new Lecture(-1, "", "", [], Colors.white), new Lecture(-1, "", "", [], Colors.white), new Lecture(-1, "", "", [], Colors.white), new Lecture(-1, "", "", [],Colors.white), new Lecture(-1, "", "", [], Colors.white), new Lecture(-1, "", "", [], Colors.white), new Lecture(-1, "", "", [], Colors.white),
  new Lecture(-1, "", "", [], Colors.white), new Lecture(-1, "", "", [],Colors.white), new Lecture(-1, "", "", [], Colors.white), new Lecture(-1, "", "", [], Colors.white), new Lecture(-1, "", "", [], Colors.white), new Lecture(-1, "", "", [], Colors.white), new Lecture(-1, "", "", [],Colors.white), new Lecture(-1, "", "", [], Colors.white), new Lecture(-1, "", "", [], Colors.white), new Lecture(-1, "", "", [], Colors.white),],
  [new Lecture(-1, "", "", [], Colors.white), new Lecture(-1, "", "", [],Colors.white), new Lecture(-1, "", "", [], Colors.white), new Lecture(-1, "", "", [], Colors.white), new Lecture(-1, "", "", [], Colors.white), new Lecture(-1, "", "", [], Colors.white), new Lecture(-1, "", "", [],Colors.white), new Lecture(-1, "", "", [], Colors.white), new Lecture(-1, "", "", [], Colors.white), new Lecture(-1, "", "", [], Colors.white),
  new Lecture(-1, "", "", [], Colors.white), new Lecture(-1, "", "", [],Colors.white), new Lecture(-1, "", "", [], Colors.white), new Lecture(-1, "", "", [], Colors.white), new Lecture(-1, "", "", [], Colors.white), new Lecture(-1, "", "", [], Colors.white), new Lecture(-1, "", "", [],Colors.white), new Lecture(-1, "", "", [], Colors.white), new Lecture(-1, "", "", [], Colors.white), new Lecture(-1, "", "", [], Colors.white),],
  [new Lecture(-1, "", "", [], Colors.white), new Lecture(-1, "", "", [],Colors.white), new Lecture(-1, "", "", [], Colors.white), new Lecture(-1, "", "", [], Colors.white), new Lecture(-1, "", "", [], Colors.white), new Lecture(-1, "", "", [], Colors.white), new Lecture(-1, "", "", [],Colors.white), new Lecture(-1, "", "", [], Colors.white), new Lecture(-1, "", "", [], Colors.white), new Lecture(-1, "", "", [], Colors.white),
  new Lecture(-1, "", "", [], Colors.white), new Lecture(-1, "", "", [],Colors.white), new Lecture(-1, "", "", [], Colors.white), new Lecture(-1, "", "", [], Colors.white), new Lecture(-1, "", "", [], Colors.white), new Lecture(-1, "", "", [], Colors.white), new Lecture(-1, "", "", [],Colors.white), new Lecture(-1, "", "", [], Colors.white), new Lecture(-1, "", "", [], Colors.white), new Lecture(-1, "", "", [], Colors.white),],
  [new Lecture(-1, "", "", [], Colors.white), new Lecture(-1, "", "", [],Colors.white), new Lecture(-1, "", "", [], Colors.white), new Lecture(-1, "", "", [], Colors.white), new Lecture(-1, "", "", [], Colors.white), new Lecture(-1, "", "", [], Colors.white), new Lecture(-1, "", "", [],Colors.white), new Lecture(-1, "", "", [], Colors.white), new Lecture(-1, "", "", [], Colors.white), new Lecture(-1, "", "", [], Colors.white),
  new Lecture(-1, "", "", [], Colors.white), new Lecture(-1, "", "", [],Colors.white), new Lecture(-1, "", "", [], Colors.white), new Lecture(-1, "", "", [], Colors.white), new Lecture(-1, "", "", [], Colors.white), new Lecture(-1, "", "", [], Colors.white), new Lecture(-1, "", "", [],Colors.white), new Lecture(-1, "", "", [], Colors.white), new Lecture(-1, "", "", [], Colors.white), new Lecture(-1, "", "", [], Colors.white),],
  [new Lecture(-1, "", "", [], Colors.white), new Lecture(-1, "", "", [],Colors.white), new Lecture(-1, "", "", [], Colors.white), new Lecture(-1, "", "", [], Colors.white), new Lecture(-1, "", "", [], Colors.white), new Lecture(-1, "", "", [], Colors.white), new Lecture(-1, "", "", [],Colors.white), new Lecture(-1, "", "", [], Colors.white), new Lecture(-1, "", "", [], Colors.white), new Lecture(-1, "", "", [], Colors.white),
  new Lecture(-1, "", "", [], Colors.white), new Lecture(-1, "", "", [],Colors.white), new Lecture(-1, "", "", [], Colors.white), new Lecture(-1, "", "", [], Colors.white), new Lecture(-1, "", "", [], Colors.white), new Lecture(-1, "", "", [], Colors.white), new Lecture(-1, "", "", [],Colors.white), new Lecture(-1, "", "", [], Colors.white), new Lecture(-1, "", "", [], Colors.white), new Lecture(-1, "", "", [], Colors.white)]
  ];



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
                onPressed: () async {
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
                            return GestureDetector(

                              onTap: () async {
                                if (info[index_five][index_twenty] != -1) {
                                  final value = await Navigator.push(context,
                                      MaterialPageRoute(builder: (context) =>
                                          LecturePage(
                                              lecture: info[index_five][index_twenty])));
                                  setState(() {});
                                }
                              },
                              onLongPress: () async {
                                // 여기 await 처리가 필요할 거 같은데 어떻게 해야 할지 모르겠어요 ㅜㅜ (이것 때문에 즉시 사라지지 않아요!)
                                // _delete()가 void 함수여서 안된다고 합니다...
                                if (info[index_five][index_twenty] != -1) {
                                  _delete(info[index_five][index_twenty]);
                                  setState(() {});
                                }
                              },
                              child: Container(
                                color: info[index_five][index_twenty].color,
                                height: info[index_five][index_twenty].idx == -1 ? basic_height :
                                basic_height * (info[index_five][index_twenty].time[0].EndTime - info[index_five][index_twenty].time[0].StartTime),
                                child: Column(
                                  children: [
                                    Text('${info[index_five][index_twenty].name}'),
                                    //Text('${info[index_five][index_twenty].professor}')
                                  ],
                                )
                              ),
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
            ],
        ),
    );
  }

  void _delete(Lecture lecture) {
    showDialog(
        context: context,
        barrierDismissible: false, //barrierDismissible - Dialog를 제외한 다른 화면 터치 x
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            title: Column(
              children: <Widget>[
                new Text("강의 삭제"),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "${lecture.name}을(를) 정말 삭제하시겠습니까?",
                ),
              ],
            ),
            actions: <Widget>[
              new TextButton(
                child: new Text("확인"),
                onPressed: () {
                  Navigator.pop(context);

                  for (var i=0; i < info.length; i++) {
                    for (var j=0; j < info[i].length; j++ ) {
                      if (info[i][j].idx == lecture.idx) {
                        info[i][j] = new Lecture(-1, "", "", [], Colors.white);
                      }
                    }
                  }
                },
              ),
              new TextButton(
                  child: new Text("취소"),
                  onPressed: () {
                    Navigator.pop(context);
                  }
              ),
            ],
          );
        });
  }

  void _onButtonPressed() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: Color(0xFF737373),
            height: 80,
            child: Container(
              child: _buildButtonMenu(info : info),
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

    // 모두 삭제하기
    // 바로 적용되지 않음 -> async await 어디에 추가해야 할까요..?
    void deleteAll() {
      for (var i=0; i < info.length; i++) {
        for (var j = 0; j < info[i].length; j++) {
          info[i][j] = new Lecture(-1, "", "", [], Colors.white);
        }
      }
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
                  deleteAll();
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
  Lecture lecture;
  LecturePage({Key? key, required this.lecture}) : super(key: key);

  @override
  _LecturePageState createState() => _LecturePageState();
}

class _LecturePageState extends State<LecturePage> {
  @override
  Widget build(BuildContext context) {
    Lecture lecture = widget.lecture;
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

  final Lecture _lecture;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(_lecture.name),
        subtitle: Text(_lecture.professor),
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

    List<dynamic> info = widget._info;

    return Scaffold(
      appBar: AppBar(
        title: Text('시간표를 검색하세요'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: lecturesList.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            child: LectureTile(lecturesList[index]),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)
                    ),
                    title: Text("${lecturesList[index].name}을(를) 추가하시겠습니까?"),
                    actions: <Widget>[
                      TextButton(
                        child: new Text("취소"),
                        onPressed: () {
                          Navigator.pop(context);
                        },),
                      TextButton(
                          child: new Text("확인"),
                          onPressed: () {
                            for (var time_index = 0; time_index <
                                lecturesList[index].time.length; time_index++) {
                              double startTime = lecturesList[index]
                                  .time[time_index].StartTime;
                              double endTime = lecturesList[index]
                                  .time[time_index].EndTime;

                              for (var i = startTime; i < endTime; i++) {
                                if (i == startTime) {
                                  info[lecturesList[index].time[time_index]
                                      .day - 1][i] = lecturesList[index];
                                  info[lecturesList[index].time[time_index]
                                      .day - 1][i].color = colorsList[0];
                                } else {
                                  Lecture newLecture = new Lecture(
                                      lecturesList[index].idx, "", "",
                                      [LectureTime(0, 0, 0)], colorsList[0]);
                                  info[lecturesList[index].time[time_index]
                                      .day - 1][i] = newLecture;
                                }
                              }
                            }

                            colorsList.add(colorsList[0]);
                            for (var i = 0; i < colorsList.length - 1; i++) {
                              colorsList[i] = colorsList[i + 1];
                            }
                            print(colorsList);

                            Navigator.pop(context);
                          }
                      ),
                    ],
                  );
                },
              );
            }
          );
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
    Lecture lecture = new Lecture(-1, "", "", [], Colors.white);
    int day = -1;
    int startTime = -1;
    int endTime = -1;

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
                if (day == -1 || startTime == -1 || endTime == -1) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)
                        ),
                        title: day == -1 ? Text("요일을 입력하세요") : startTime == -1 ? Text("시작 시각을 입력하세요") : Text("끝나는 시각을 입력하세요"),
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
                  // 인덱스 계속 바꿔줘야 하는데 어떤 규칙으로 넣으면 좋을까요?
                  lecture.idx = 10000000;
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
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
                              lecture.color = colorsList[0];
                              colorsList.add(colorsList[0]);
                              for (var i=0; i < colorsList.length-1; i++) {
                                colorsList[i] = colorsList[i+1];
                              }
                              Navigator.pop(context);
                              info[day][startTime] = lecture;
                            },
                          )
                        ],
                      );
                    },
                  );
                }
              },
            ),
          ],
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
                        lecture.name = value;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: TextField(
                      cursorColor: Colors.grey,
                      decoration: InputDecoration(hintText: "교수명"),
                      onChanged: (value) {
                        lecture.professor = value;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: TextField(
                      cursorColor: Colors.grey,
                      decoration: InputDecoration(hintText: "요일"),
                      onChanged: (value) {
                        lecture.time.add(new LectureTime(0,0,0));
                        lecture.time[0].day = int.parse(value);
                        day = int.parse(value);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: TextField(
                      cursorColor: Colors.grey,
                      decoration: InputDecoration(hintText: "시작 시각"),
                      onChanged: (value) {
                        lecture.time[0].StartTime = int.parse(value);
                        startTime = int.parse(value);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: TextField(
                      cursorColor: Colors.grey,
                      decoration: InputDecoration(hintText: "끝나는 시각"),
                      onChanged: (value) {
                        lecture.time[0].EndTime = int.parse(value);
                        endTime = int.parse(value);
                      },
                    ),
                  ),

                  /*TextButton(onPressed: () {
                    showPicker(time);
                  },
                      child: Text(time))

                   */

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
