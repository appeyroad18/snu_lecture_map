import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_picker/flutter_picker.dart';
//import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:math';

import 'package:snu_lecture_map/dataclass.dart';

String selectedLecture = '초기화';
String selectedLecture_classroom = '강의실';
double width = 0; // 고정값
double height = 0;
double horizontal = 0;
double vertical = 0;
List lectureList = [];
List check_info = [];
int count = 10;
double screen_width = 0;
double screen_height = 0;



class TimeTable extends StatefulWidget {
  //final Storage? storage;
  double bottomBarHeight;
  double appBarHeight;

  TimeTable({Key? key, required this.bottomBarHeight, required this.appBarHeight}) : super(key: key);

  @override
  _TimeTableState createState() => _TimeTableState();
}

class _TimeTableState extends State<TimeTable> {

  // 강의명\n 강의실, color, 강의시간(높이)
  // 너비 (index_main으로 조절)
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

    return ChangeNotifierProvider(
      create: (BuildContext context) => BoxSize(),
      child: Scaffold(
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
              onPressed: () {
                showSearch(context: context, delegate: DataSearch());
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SecondPage()));
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

                            // 각각 강의마다 고유 번호를 달 생각은...?
                            setState(() {
                            });
                          },
                          onLongPress: () {
                            // 바로 지워지긴 함 (연결된 container, 다른 요일의 container를 어떻게 이을 것인가..!)
                            setState(() {
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
            )],
        ),
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


class SecondPage extends StatelessWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context2) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '시간표',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            color: Colors.black,
            onPressed: () {
              showSearch(context: context2, delegate: DataSearch());
            },
          ),
          // IconButton(
          //   icon: Icon(Icons.add_box_outlined),
          //   color: Colors.black,
          //   onPressed: () => _onButtonPressed(),
          // ),
          IconButton(
            icon: Icon(Icons.settings),
            color: Colors.black,
            onPressed: () {
              print('Setting button is clicked');
            },
          ),
        ],
      ),
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

    BoxSize _boxSize = Provider.of<BoxSize>(context);
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
                      _boxSize.add(lecture_name, lecture_professor, lecture_place, day, start_time, end_time, context, true);
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

class Table extends StatefulWidget {
  double bottomBarHeight;
  double appBarHeight;

  Table({Key? key, required this.bottomBarHeight, required this.appBarHeight}) : super(key: key);


  @override
  _TableState createState() => _TableState();
}

class _TableState extends State<Table> {
  @override
  Widget build(BuildContext context) {
    screen_width = MediaQuery.of(context).size.width;
    screen_height = MediaQuery.of(context).size.height;


    List info0 = ["","9","10","11","12","13","14","15","16","17","18"];
    List info1 = [['월'],['대학영어1'], ['초급중국어1'], ['수학1']];
    return Row(
      children: [

        ListView.builder(
          itemCount : 21,
          itemBuilder: (BuildContext context, int index) {
            return Container(
                color: Colors.black26,
                height: 30, //(screen_height - widget.appBarHeight - widget.bottomBarHeight - 50) / 21,
                child : Center(child :Text('hi'),)

            );
          },
        ),
      ],
    );
  }
}


/*
class FirstColumn extends StatelessWidget {

  double width = 0;
  String name = "";
  int flex = 0;
  double bottom_border = 1;
  double left_border = 1;
  FirstColumn(this.width, this.name, this.flex, this.bottom_border, this.left_border);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Container(
          child: Align(
            alignment: Alignment.center,
            child: Text(name,
              textAlign: TextAlign.center,
            ),
          ),
          width: width,
          decoration: BoxDecoration(
              border: Border(
                  right: BorderSide(
                    color: Colors.black26,
                    width: left_border,
                  ),
                  bottom: BorderSide(
                    color: Colors.black26,
                    width: bottom_border,
                  )))),
    );
  }
}

class SecondColumn extends StatelessWidget {
  double width = 0;
  String name = "";
  double left_border =1;
  SecondColumn(this.width, this.name, this.left_border);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FirstColumn(width, name, 2,1, left_border),
        FirstColumn(width, "", 3,0.5, left_border),
        FirstColumn(width, "",3,1, left_border),
        FirstColumn(width, "", 3,0.5, left_border),
        FirstColumn(width, "",3,1, left_border),
        FirstColumn(width, "", 3,0.5, left_border),
        FirstColumn(width, "",3,1, left_border),
        FirstColumn(width, "", 3,0.5, left_border),
        FirstColumn(width, "",3,1, left_border),
        FirstColumn(width, "", 3,0.5, left_border),
        FirstColumn(width, "",3,1, left_border),
        FirstColumn(width, "", 3,0.5, left_border),
        FirstColumn(width, "",3,1, left_border),
        FirstColumn(width, "", 3,0.5, left_border),
        FirstColumn(width, "",3,1, left_border),
        FirstColumn(width, "", 3,0.5, left_border),
        FirstColumn(width, "",3,1, left_border),
        FirstColumn(width, "", 3,0.5, left_border),
        FirstColumn(width, "",3,1, left_border),
        FirstColumn(width, "", 3,0.5, left_border),
        FirstColumn(width, "",3,1, left_border),
      ],
    );
  }
}

class _Table extends StatefulWidget {
  const _Table({Key? key}) : super(key: key);

  @override
  __TableState createState() => __TableState();
}

class __TableState extends State<_Table> {
  @override
  Widget build(BuildContext context) {
    screen_width = MediaQuery.of(context).size.width;
    screen_height = MediaQuery.of(context).size.height;
    double width1 = screen_width / 16;
    double width2 = screen_width / 16 * 3;

    return Container(
      height : screen_height*0.82,
      child: Stack(
          children: [Row(
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    FirstColumn(width1, "", 1,1,1),
                    FirstColumn(width1, "9", 3,1,1),
                    FirstColumn(width1, "10",3,1,1),
                    FirstColumn(width1, "11",3,1,1),
                    FirstColumn(width1, "12",3,1,1),
                    FirstColumn(width1, "13",3,1,1),
                    FirstColumn(width1, "14",3,1,1),
                    FirstColumn(width1, "15",3,1,1),
                    FirstColumn(width1, "16",3,1,1),
                    FirstColumn(width1, "17",3,1,1),
                    FirstColumn(width1, "18",3,1,1),
                  ],
                ),
              ),
              Expanded(child: SecondColumn(width2,"월",1),flex:3),
              Expanded(child: SecondColumn(width2,"화",1),flex:3),
              Expanded(child: SecondColumn(width2,"수",1),flex:3),
              Expanded(child: SecondColumn(width2,"목",1),flex:3),
              Expanded(child: SecondColumn(width2,"금",0),flex:3),
            ],
          ),
            LectureBox(),
            //Visibility(child: LectureInfoPage(),visible: true,),
          ]),
    );
  }
}

 */

class LectureInfoPage extends StatelessWidget {
  const LectureInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(""),),
    );
  }
}

void move(context) {
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => LectureInfoPage()));
}

List check_list = [];
List check_list_multi = [];
List before_list = [];

class BoxSize with ChangeNotifier {

  add_multi(String name, String professor, String place, List time, BuildContext context, bool single) {

    void _showDialog () {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object  of type Dialog
          return CupertinoAlertDialog(
            title: new Text("수업 시간이 겹칩니다."),
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

    for (List i in time) {
      int week = i[0];
      double start_time = i[1];
      double end_time = i[2];

      height = screen_height * 0.82 / 31 * (end_time - start_time) * 3;
      vertical = screen_height * 0.82 / 31 * (1 + 3 * (start_time - 9));

      if (week == 1) {
        horizontal = 1;
      } else if (week == 2) {
        horizontal = 4;
      } else if (week == 3) {
        horizontal = 7;
      } else if (week == 4) {
        horizontal = 10;
      } else if (week == 5) {
        horizontal = 13;
      }

      for (List x in check_info) {
        if (x[1] != week) //&& (x[2] < start_time || start_time <= x[3]) && (x[2] < end_time || end_time <= x[3]))
            {
          check_list.add(true);
        }
        else {
          check_list.add(false);
        }
      }

      print('start');
      print(check_info);
      print(check_list);

      if (check_list.contains(false)) {
        print("error");
        check_list_multi.add(false);
        break;
      } else {
        check_list_multi.add(true);
      }
    }

    if (check_list_multi.contains(false)) {
      print("error");
      _showDialog();
      check_list_multi = [];
    } else {
      for (List i in time) {

        int week = i[0];
        double start_time = i[1];
        double end_time = i[2];
        int index_of_element = time.indexOf(i);

        height = screen_height * 0.82 / 31 * (end_time - start_time) * 3;
        vertical = screen_height * 0.82 / 31 * (1 + 3 * (start_time - 9));

        if (week == 1) {
          horizontal = 1;
        } else if (week == 2) {
          horizontal = 4;
        } else if (week == 3) {
          horizontal = 7;
        } else if (week == 4) {
          horizontal = 10;
        } else if (week == 5) {
          horizontal = 13;
        }

        int mykey = count;
        check_info.add(
            [mykey, week, start_time, end_time]
        );

        void _deleteBox(int element) {
          for (int i = 0 - element; i < time.length - element; i++) {
            print(element);
            print(i);
            print(mykey + i);
            lectureList.removeWhere((k) =>
            (k.key as ValueKey).value == mykey + i);
          }
          print(check_info);
          for (int i = 0 - element; i < time.length - element; i++) {
            check_info.removeWhere((k) => (k[0] == mykey + i));
          }
          print(check_info);
        }

        before_list.add(
          Positioned(
            key: ValueKey(mykey),
            left: screen_width / 16 * horizontal,
            top: vertical,
            child: GestureDetector(
              child: Container(
                height: height,
                width: (screen_width / 16 * 3) - 1,
                color: Colors.purple,
                child: Column(
                  children: [
                    Text(name, style: TextStyle(fontSize: 10)),
                    Text(place, style: TextStyle(fontSize: 10),
                    )
                  ],
                ),
              ),
              onTap: () {
                move(context); //new page <실행안됨>
              },
              onLongPress: () {
                print("hi");
                _deleteBox(index_of_element);
                notifyListeners();
                print("hi");
                print(lectureList);
                print(before_list);
              },
            ),
          ),
        );
        count += 1;
        print(index_of_element);
      }
    }
    for (var i in before_list) {
      lectureList.add(i);}
    print(lectureList);
    print(before_list);
    before_list = [];
    notifyListeners();
  }

  add(String name, String professor, String place, int week, double start_time, double end_time, BuildContext context, bool single) {

    void _showDialog () {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object  of type Dialog
          return CupertinoAlertDialog(
            title: new Text("수업 시간이 겹칩니다."),
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

    for (List x in check_info) {
      if (x[1] != week) //&& (x[2] < start_time || start_time <= x[3]) && (x[2] < end_time || end_time <= x[3]))
          {check_list.add(true);}
      else {check_list.add(false);}
    }

    print('start');
    print(check_info);
    print(check_list);

    if (check_list.contains(false)) {
      print("error");
      _showDialog();
      check_list = [];
    }
    else {

      height = screen_height * 0.82 / 31 * (end_time - start_time) * 3;
      vertical = screen_height * 0.82 / 31 * (1 + 3 * (start_time - 9));

      if (week == 1) {
        horizontal = 1;
      } else if (week == 2) {
        horizontal = 4;
      } else if (week == 3) {
        horizontal = 7;
      } else if (week == 4) {
        horizontal = 10;
      } else if (week == 5) {
        horizontal = 13;
      }

      List colors = [
        Colors.red,
        Colors.orange,
        Colors.yellow,
        Colors.green,
        Colors.blue
      ];
      int index = lectureList.length;
      int mykey = count;
      int mykey_check = mykey;

      if (single == true) {
        check_info.add(
            [mykey, week, start_time, end_time]
        );
        lectureList.add(
          Positioned(
            key: ValueKey(mykey),
            left: screen_width / 16 * horizontal,
            top: vertical,
            child: GestureDetector(
              child: Container(
                height: height,
                width: (screen_width / 16 * 3) - 1,
                color: colors[index],
                child: Column(
                  children: [
                    Text(name, style: TextStyle(fontSize: 10)),
                    Text(place, style: TextStyle(fontSize: 10),
                    )
                  ],
                ),
              ),
              onTap: () {
                move(context); //new page <실행안됨>
              },
              onLongPress: () {
                print("hi");
                lectureList
                    .removeWhere((k) =>
                (k.key as ValueKey).value == mykey_check);
                check_info.removeWhere((k) => (k[0] == mykey_check));
                notifyListeners();
                print("hi");
              },
            ),
          ),
        );
      }
      count = count + 1;
      check_list = [];
      //print(check_info);
      notifyListeners();
    }
  }

  delete_all() {
    lectureList = [];
    check_info = [];
    count = 100;
    notifyListeners();
  }

  pass(String lecture_name) {
    selectedLecture = lecture_name;
    notifyListeners();
  }

  pr() {
    print(selectedLecture);
    notifyListeners();
  }

  setheight(double start_time, double end_time) {
    height = screen_height * 0.82/31 * (end_time - start_time)*3;
    vertical = screen_height * 0.82/31 * (1+ 3*(start_time-9));
    notifyListeners();
  }

  setweek(int week) {
    // 화면 위치보고 정함
    if (week == 1) {
      horizontal = 1;
    } else if (week == 2) {
      horizontal = 4;
    } else if (week == 3) {
      horizontal = 7;
    } else if (week == 4) {
      horizontal = 10;
    } else if (week == 5) {
      horizontal = 13;
    }
    notifyListeners();
  }
}

class DataSearch extends SearchDelegate<String> {
  final lectures = [
    "대학글쓰기1",
    "대학글쓰기2",
    "English",
    "Economics",
    "Physics",
    "Statistics",
    "통계학",
    "통계학실험",
    "굿 라이프 심리학",
    "재무관리",
    "초급중국어1",
    "데이터과학"
  ];
  final recentLectures = ["대학글쓰기1", "대학글쓰기2", "Physics", "Statistics","초급중국어1","데이터과학"];
  final lectureinfo = [
    ["대학글쓰기1", [[1, 13.0, 14.5],[2, 9.0, 10.25],[3, 16.0,18.0]], "가나", "58동 401호"],
    ["대학글쓰기2", [[2, 9.0, 10.25]], "다라", "58동 402호"],
    ["Physics", [[4, 11.5, 12.75]], "마바", "58동 403호"],
    ["Statistics", [[5, 14.0, (16+5/6)]], "사아", "58동 404호"],
    ["초급중국어1", [[1,12.5,13.75],[1,17.0,(17+5/6)],[3,12.5,13.75]], "자차", "3동 106호"],
    ["데이터과학",[[2,11.0,12.25],[4,11.0,12.25]],"카타","25동 418호"]];

  @override
  List<Widget> buildActions(BuildContext context) {
    // actions for app bar
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // leading icon on the left of the app bar

    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, "");
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    BoxSize _boxSize = Provider.of<BoxSize>(context);
    // show when someone searches for something
    final suggestionList = query.isEmpty
        ? recentLectures
        : lectures.where((p) => p.startsWith(query)).toList();

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          _boxSize.pass(suggestionList[index]);
          _boxSize.pr();
          showResults(context);
        },
        leading: Icon(Icons.circle),
        title: RichText(
          text: TextSpan(
              text: suggestionList[index].substring(0, query.length),
              style:
              TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                    text: suggestionList[index].substring(query.length),
                    style: TextStyle(color: Colors.grey))
              ]),
        ),
      ),
      itemCount: suggestionList.length,
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // show some result based on the selection
    BoxSize _boxSize = Provider.of<BoxSize>(context);
    final String lecName = selectedLecture;
    List selectedinfo = [[], "교수명", "강의실"];
    List one_time = [];
    String time_day = "";
    String time_start = "";
    String time_end = "";
    String time_info = "";
    List time_info_list = [];
    String time_info_final = "";

    for (List each in lectureinfo) {
      if (each[0] == lecName) {
        for (List one in each[1]) {
          one_time.add(one[0]);
          one_time.add(one[1]);
          one_time.add(one[2]);
          selectedinfo[0].add(one_time);
          one_time = [];

          if (one[0] == 1) {
            time_day = "월";
          } else if (one[0] == 2) {
            time_day = "화";
          } else if (one[0] == 3) {
            time_day = "수";
          } else if (one[0] == 4) {
            time_day = "목";
          } else if (one[0] == 5) {
            time_day = "금";
          }

          int time_start_hour = one[1].toInt();
          String time_start_hour_ = time_start_hour.toString();
          int time_start_minute = (((one[1] - one[1].toInt())*100).ceil()*0.6).toInt();
          String time_start_minute_ = time_start_minute.toString();

          int time_end_hour = one[2].toInt();
          String time_end_hour_ = time_end_hour.toString();
          int time_end_minute = (((one[2] - one[2].toInt())*100).ceil()*0.6).toInt();
          String time_end_minute_ = time_end_minute.toString();

          time_start = time_start_hour_ + ":" + time_start_minute_;
          time_end = time_end_hour_ + ":" + time_end_minute_;
          time_info = time_day + " "+ time_start + "-" + time_end;
          time_info_list.add(time_info);
        }
        print(selectedinfo);
        print(time_info_list);

        for (String i in time_info_list) {
          time_info_final += (i + ", ");
        }
        time_info_final = time_info_final.replaceRange(time_info_final.length-2,time_info_final.length, "");

        String professor_name = each[2];
        selectedinfo[1] = professor_name;
        String place = each[3];
        selectedinfo[2] = place;
        selectedLecture_classroom = place;
      }
    };

    return ListView(
      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
      children: [
        ListTile(
          title: Text(lecName),
          subtitle: Column(
            children: [
              Row(
                children: [
                  Text(selectedinfo[1]),
                  SizedBox(
                    width: 5,
                  ),
                  Text(selectedinfo[2]),
                ],
              ),
              Row(
                children: [
                  Text(time_info_final),
                ],
              ),
            ],
          ),
          trailing: IconButton(
              icon: AnimatedIcon(
                icon: AnimatedIcons.event_add,
                progress: transitionAnimation,
              ),
              onPressed: () {
                close(context, "bye");
                if (selectedinfo[0].length == 1) {
                  _boxSize.add(lecName,selectedinfo[1], selectedinfo[2], selectedinfo[0][0][0], selectedinfo[0][0][1], selectedinfo[0][0][2], context, true);
                  print(lectureList);
                  print(check_info);
                }
                else {
                  _boxSize.add_multi(lecName, selectedinfo[1], selectedinfo[2], selectedinfo[0], context, false);
                  print(lectureList);
                  print(check_info);
                }
              }),
        ),
        ListTile(
          title: Text(lecName),
          subtitle: Column(
            children: [
              Row(
                children: [
                  Text(selectedinfo[1]),
                  SizedBox(
                    width: 5,
                  ),
                  Text(selectedinfo[2]),
                ],
              ),
              Row(
                children: [
                  Text(time_info_final),
                ],
              ),
            ],
          ),
          trailing: IconButton(
              icon: AnimatedIcon(
                icon: AnimatedIcons.event_add,
                progress: transitionAnimation,
              ),
              onPressed: () {
                close(context, "bye");
                if (selectedinfo[0].length == 1) {
                  _boxSize.add(lecName,selectedinfo[1], selectedinfo[2], selectedinfo[0][0][0], selectedinfo[0][0][1], selectedinfo[0][0][2], context, true);
                }
                else {
                  for (List each in selectedinfo[0]) {
                    _boxSize.add(lecName,selectedinfo[1], selectedinfo[2], each[0], each[1],each[2], context, false);
                  }
                }
              }),
        ),
      ],

    );
  }
}

class LectureBox extends StatefulWidget {
  LectureBox({Key? key}) : super(key: key);
  @override
  _LectureBoxState createState() => _LectureBoxState();
}

class _LectureBoxState extends State<LectureBox> {
  @override

  Widget build(BuildContext context) {
    List getListFiles() {
      List list = lectureList;
      return list;
    }

    return Stack(
      children: List.from(() sync* {
        yield* getListFiles();
      }()),
    );
  }
}

// TODO reference @다은
// assume that there is well defined lecture info class (might be "Dataclass")
// for show example, "TempLectureClass" class is used
// maybe, need to make class for lecture tile(not a widget)
class TempLectureClass{
  int startTime;
  int endTime;
  String lectureName;
  TempLectureClass({this.startTime : -1, this.endTime : -1, this.lectureName:"no class"}); //-1 time used for marking null lecture
}


class SampleTable extends StatefulWidget {
  const SampleTable({Key? key}) : super(key: key);

  @override
  _SampleTableState createState() => _SampleTableState();
}

class _SampleTableState extends State<SampleTable> {
  // List<Dataclass> _mondayLectures = [];
  // List<Dataclass> _tuesdayLectures = [];
  // List<Dataclass> _wednesdayLectures = [];
  // List<Dataclass> _thursdayLectures = [];
  // List<Dataclass> _fridayLectures = [];
  List<List<TempLectureClass>> _lectureLists = [];
  TempLectureClass _nullLecture = new TempLectureClass();

  @override
  void initState(){
    // _mondayLectures = List.generate(20, (index) => new Dataclass());
    _lectureLists = List.generate(5, (i) => List.generate(20, (j) => new TempLectureClass(startTime: j, endTime: j)) );
  }

  bool checkOverlap(TempLectureClass newLecture){
    // TODO : check whether there are overlapped lecture
    // if lecture has start time or end time of -1, it mean this time is already occupied
    // of course if there is lecture name, this time is already occupied
    if (newLecture.startTime == -1 || newLecture.endTime == -1) {
      return false;
    } else {
      return true;
    }
  }

  void addLecture(TempLectureClass newLecture, int day){
    if(day < 0 || day >= 5) {
      print("invalid day input");
      return;
    }

    if(checkOverlap(newLecture)){
      print("there are overlapped lecture");
      return;
    }

    setState(() {
      int startTime = newLecture.startTime;
      int endTime = newLecture.endTime;

      for(int period = startTime;period<=endTime;period++){
        _lectureLists[day][period] = _nullLecture;
      }
      _lectureLists[day][startTime] = newLecture;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Text("text"),
          // use Listview.builder
          // make Lecture Container corresponding to each element of "_lectureLists"
          // if start time or end time is -1 do not make corresponding Container
        ),
      ],
    );
  }
}
