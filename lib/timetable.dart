import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'dart:math';

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
  const TimeTable({Key? key}) : super(key: key);

  @override
  _TimeTableState createState() => _TimeTableState();
}

class _TimeTableState extends State<TimeTable> {
  @override
  Widget build(BuildContext context) {
    BoxSize _boxSize = Provider.of<BoxSize>(context);
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
                        MaterialPageRoute(builder: (context) => SelfAdd()));
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
          body: SingleChildScrollView(child: _Table())
      ),
    );
  }
  void _onButtonPressed() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: Color(0xFF737373),
            height: 460,
            child: Container(
              child: _buildButtonMenu(),
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
  const _buildButtonMenu({Key? key}) : super(key: key);

  @override
  __buildButtonMenuState createState() => __buildButtonMenuState();
}

class __buildButtonMenuState extends State<_buildButtonMenu> {
  @override
  Widget build(BuildContext context) {

    void _showDeleteMessage () {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          BoxSize _boxSize = Provider.of<BoxSize>(context);
          // return object  of type Dialog
          return CupertinoAlertDialog(
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
                  print(lectureList);
                  print(check_info);
                  _boxSize.delete_all();
                  print(lectureList);
                },
              ),
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
            _showDeleteMessage ();
          },
        )],
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
                      _boxSize.add(lecture_name, lecture_professor, lecture_place, day, start_time, end_time, context);
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

  /*showPickerDialog(BuildContext context) {
    //BoxSize _boxSize = Provider.of<BoxSize>(context);
    Picker(
        adapter: PickerDataAdapter<String>(pickerdata: ["9:00","9:30"],),
        hideHeader: true,
        title: Text("시간 선택"),
        selectedTextStyle: TextStyle(color: Colors.blue),
        onConfirm: (Picker picker, List value) {
          print(value.toString());
          print(picker.getSelectedValues());
          String a = value.toString();
          print(a);
          if (a==[1]) {print(1);};
          //double value1 = value[0] as double;
          //_boxSize.setheight(value1, 3);
          //print(value1);
        }
    ).showDialog(context);
  }
   */

  void _showDatePicker(context) {
    new Picker(
        adapter: NumberPickerAdapter(data: [
          NumberPickerColumn(begin: 9, end: 18),
          NumberPickerColumn(begin: 0, end: 59),
          NumberPickerColumn(begin: 9, end: 18),
          NumberPickerColumn(begin: 0, end: 59),
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
            start_hour = selectedtime[0].toString();
            if (selectedtime[1] < 10) {
              start_minute = selectedtime[1].toString();
              start_minute = '0' + start_minute;
            } else () {start_minute = selectedtime[1].toString();
            };
            end_hour = selectedtime[2].toString();
            if (selectedtime[3] < 10) {
              end_minute = selectedtime[3].toString();
              end_minute = '0' + end_minute;
            } else () {end_minute = selectedtime[3].toString();
            };
            print(picker.getSelectedValues());
            start_time = selectedtime[0] + selectedtime[1]/60;
            end_time = selectedtime[2] + selectedtime[3]/60;
          });
        }).showDialog(context);
  }

  List<bool> _selections = List.generate(5, (_) => false);

  @override
  Widget build(BuildContext context) {
    BoxSize _boxSize = Provider.of<BoxSize>(context);
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

/*
class TimeSelect extends StatefulWidget {
  const TimeSelect({Key? key}) : super(key: key);

  @override
  _TimeSelectState createState() => _TimeSelectState();
}

class _TimeSelectState extends State<TimeSelect> {



  String week = '';

  void _showDatePicker(ctx) {
    showCupertinoModalPopup(
        context: ctx,
        builder: (_) => Container(
          height: 200,
          color: Color.fromARGB(255, 255, 255, 255),
          child: Column(
            children: [
              Container(
                height: 130,
                child: CupertinoPicker(
                  onSelectedItemChanged: (val) {
                    setState(() {
                      //_chosenDateTime = val;
                      if (val == 0) {
                        week = '월요일';
                      } else if (val == 1) {
                        week = '화요일';
                      } else if (val == 2) {
                        week  = '수요일';
                      } else if (val == 3) {
                        week = '목요일';
                      } else if (val == 4) {
                        week = '금요일';
                      }
                    });
                  },
                  itemExtent: 32,
                  children: [
                    Text('월'),
                    Text('화'),
                    Text('수'),
                    Text('목'),
                    Text('금')
                  ],
                ),
              ),

              // Close the modal
              CupertinoButton(
                child: Text('OK'),
                padding: EdgeInsets.zero,
                onPressed: () => Navigator.of(ctx).pop(),
              )
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
      child: Column(
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CupertinoButton(
                //padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Text(
                  '요일 및 시간 선택',
                  style: TextStyle(fontSize: 15),
                ),
                onPressed: () => _showDatePicker(context),
              ),
            ],
          ),
          Text(week),
        ],
      ),
    );


  }
}
*/


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


class BoxSize with ChangeNotifier {

  add(String name, String professor, String place, int week, double start_time, double end_time, BuildContext context) {
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

    check_info.forEach((x) {
      if (x[1] !=
          week) //&& (x[2] < start_time || start_time <= x[3]) && (x[2] < end_time || end_time <= x[3]))
          {
        check_list.add(true);
      }
      else {check_list.add(false);}
    });

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
      //Random random = new Random();
      int index = lectureList.length;
      int mykey = count;
      int mykey_check = mykey;

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
      count = count + 1;
      check_list = [];
      print(check_info);
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
    "재무관리"
  ];
  final recentLectures = ["대학글쓰기1", "대학글쓰기2", "Physics", "Statistics"];
  final lectureinfo = [
    ["대학글쓰기1", 1, 13.0, 14.5,"가나다", "58동 401호"],
    ["대학글쓰기2", 2, 9.0, 10.25, "라마바", "58동 402호"],
    ["Physics", 4, 11.5, 12.75, "사아자", "58동 403호"],
    ["Statistics", 5, 14.0, (16+5/6), "차카타파하", "58동 404호"],
  ];

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
    List selectedinfo = ["대학글쓰기1", 1, 3.0, 5.0, "정다은", "58동 404호"];

    for (List each in lectureinfo) {
      if (each[0] == lecName) {
        int lec_week = each[1];
        selectedinfo[0] = lec_week;
        double lec_start_time = each[2];
        selectedinfo[1] = lec_start_time;
        double lec_end_time = each[3];
        selectedinfo[2] = lec_end_time;
        String professor_name = each[4];
        selectedinfo[3] = professor_name;
        String place = each[5];
        selectedinfo[4] = place;
        selectedLecture_classroom = place;
      }
      ;
    }
    ;

    return ListView(
      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
      children: [
        ListTile(
          title: Text(lecName),
          subtitle: Column(
            children: [
              Row(
                children: [
                  Text(selectedinfo[3]),
                  SizedBox(
                    width: 5,
                  ),
                  Text(selectedinfo[4]),
                ],
              ),
              Row(children: [
                Text(selectedinfo[0].toString()),
                SizedBox(
                  width: 5,
                ),
                Text(selectedinfo[1].toString()),
                Text("-"),
                Text(selectedinfo[2].toString()),
              ]),
            ],
          ),
          trailing: IconButton(
              icon: AnimatedIcon(
                icon: AnimatedIcons.event_add,
                progress: transitionAnimation,
              ),
              onPressed: () {
                close(context, "bye");
                //_boxSize.setweek(selectedinfo[0]);
                //_boxSize.setheight(selectedinfo[1], selectedinfo[2]);
                _boxSize.pr();
                _boxSize.add(lecName,selectedinfo[3], selectedinfo[4], selectedinfo[0], selectedinfo[1],selectedinfo[2], context);
                print(lectureList);
              }),
        ),
        ListTile(
          title: Text(lecName),
          subtitle: Column(
            children: [
              Row(
                children: [
                  Text(selectedinfo[3]),
                  SizedBox(
                    width: 5,
                  ),
                  Text(selectedinfo[4]),
                ],
              ),
              Row(children: [
                Text(selectedinfo[0].toString()),
                SizedBox(
                  width: 5,
                ),
                Text(selectedinfo[1].toString()),
                Text("-"),
                Text(selectedinfo[2].toString()),
              ]),
            ],
          ),
          trailing: IconButton(
              icon: AnimatedIcon(
                icon: AnimatedIcons.event_add,
                progress: transitionAnimation,
              ),
              onPressed: () {
                close(context, "bye");
                //_boxSize.setweek(selectedinfo[0]);
                _boxSize.pr();
                _boxSize.add(lecName,selectedinfo[3], selectedinfo[4], selectedinfo[0], selectedinfo[1],selectedinfo[2], context);
                print(lectureList);
              }),
        ),
      ],
    );
  }
}

class LectureBox extends StatefulWidget {
  @override
  _LectureBoxState createState() => _LectureBoxState();
}

class _LectureBoxState extends State<LectureBox> {
  @override
  List getListFiles() {
    List list = lectureList;
    return list;
  }

  Widget build(BuildContext context) {
    return Stack(
      children: List.from(() sync* {
        yield* getListFiles();
      }()),
    );
  }
}
