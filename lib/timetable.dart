import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'dart:convert';


String selectedLecture = '초기화';
String selectedLecture_classroom = '강의실';
double width = 0; // 고정값
double height = 0;
double horizontal = 0;
double vertical = 0;
List<Widget> lectureList = <Widget>[
  /*Opacity(key: ValueKey(0), child: Container(height: 20,width: 20,color: Colors.black,), opacity: 0.0,),*/
];
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
            //toolbarHeight: 60,
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
                  // Navigator.push(context, MaterialPageRoute(
                  //   builder: (context) => SearchPage()));
                },
              ),
              IconButton(
                  icon: Icon(Icons.add_box_outlined),
                  color: Colors.black,
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SelfAdd()));
                  }
                  //_onButtonPressed(),
                  ),
              IconButton(
                icon: Icon(Icons.settings),
                color: Colors.black,
                onPressed: () {
                  print(lectureList);
                  _boxSize.delete_all();
                  print(lectureList);
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
                        // SizedBox(height: 10,),
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
                        // SizedBox(height: 10,),
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
              // Navigator.push(context, MaterialPageRoute(
              //   builder: (context) => SearchPage()));
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

class SelfAdd extends StatelessWidget {
  const SelfAdd({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context3) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Row(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                child: Text("취소"),
                onPressed: () {
                  Navigator.pop(context3, "");
                  print('hello');
                },
              ),
              SizedBox(
                width: 80,
              ),
              Text(
                "직접 추가하기",
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(
                width: 80,
              ),
              TextButton(
                child: Text("확인"),
                onPressed: () {
                  Navigator.pop(context3, "");
                  print('hello');
                },
              ),
            ],
          ),
          Container(
            height: 1,
            color: Colors.black12,
          ),
          ListTile(
            // horizontalTitleGap: -10,
            // leading: Icon(Icons.check, size: 20, color: Colors.white,),
            title: Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: TextField(
                cursorColor: Colors.grey,
                decoration: InputDecoration(hintText: "강의명"),
              ),
            ),
          ),
          ListTile(
            title: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: TextField(
                cursorColor: Colors.grey,
                decoration: InputDecoration(hintText: "교수명"),
              ),
            ),
          ),
          TimeSelect()
        ],
      ),
    );
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
    //  BoxSize _boxSize = Provider.of<BoxSize>(context);
    return Column(
      children: [
        SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "직접 추가하기",
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(
              width: 70,
            ),
            TextButton(
              child: Text("확인"),
              onPressed: () {
                Navigator.pop(context, "");
                //_boxSize.add();
                print('hello');
              },
            ),
            SizedBox(
              width: 20,
            )
          ],
        ),
        ListTile(
          // horizontalTitleGap: -10,
          // leading: Icon(Icons.check, size: 20, color: Colors.white,),
          title: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: TextField(
              cursorColor: Colors.grey,
              decoration: InputDecoration(hintText: "강의명"),
            ),
          ),
        ),
        ListTile(
          title: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: TextField(
              cursorColor: Colors.grey,
              decoration: InputDecoration(hintText: "교수명"),
            ),
          ),
        ),
        TimeSelect()
      ],
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
  //static const PickerData = [["9:00","9:30"], ["9:00","9:30"]];
  /*
  showPickerDialog(BuildContext context) {
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
          NumberPickerColumn(begin: 0, end: 30, jump: 30),
        ]),
        hideHeader: true,
        delimiter: [
          // 구분자
          PickerDelimiter(
              child: Container(
               width: 10.0, alignment: Alignment.center, child: Text(':'),
          ))
        ],
        title: new Text("시간 선택"),
        onConfirm: (Picker picker, List value) {
          setState(() {
            print(value.toString());
            selectedtime = picker.getSelectedValues();
            start_hour = selectedtime[0].toString();
            start_minute = selectedtime[1].toString();
            end_hour = selectedtime[2].toString();
            end_minute = selectedtime[3].toString();
            print(picker.getSelectedValues());
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
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Text(
                  '요일 및 시간 선택',
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
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
                        //_selections[index] =! _selections[index];
                      });
                  },
                    )
                //OutlinedButton(
                //  onPressed: () {}, child: Text('월요일'),
                  //  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.black2),))
              ],
            ),
          ),
          Align(
            alignment: Alignment(-1, 0),
            child: Column(
              children: [
                Row(
                  children: [Text("시작 시간"),
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

double need = 0;
class _Table extends StatefulWidget {
  const _Table({Key? key}) : super(key: key);

  @override
  __TableState createState() => __TableState();
}

class __TableState extends State<_Table> {
  final height_key = GlobalKey();
  Size? height_size;
  /*
  void getSize() {
    setState(() {
      height_size = height_key.currentContext!.size!;
      need = height_size!.height;
    });
  }
   */
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
              key: height_key,
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
       LectureBox()
        ]),
    );
  }
}


class BoxSize with ChangeNotifier {
  add() {
    int mykey = count;
    int mykey_check = mykey;
    lectureList.add(
      Positioned(
        key: ValueKey(mykey),
        left: screen_width / 16 * horizontal,
        top : vertical,
        //alignment: Alignment(horizontal, vertical),
        //set position depend on lecture date and time
        child: GestureDetector(
          child: Container(
            height: height,
            //set height depend on lecture duration
            width: (screen_width / 16 * 3) - 1,
            //set width
            color: Colors.orange,
            child: Column(
              children: [
                Text(selectedLecture, style: TextStyle(fontSize: 10)),
                Text(
                  selectedLecture_classroom,
                  style: TextStyle(fontSize: 10),
                )
              ],
            ),
          ),
          onTap: () {
            print('hello');
          },
          onLongPress: () {
            print("hi");
            lectureList
                .removeWhere((k) => (k.key as ValueKey).value == mykey_check);
            notifyListeners();
            print("hi");
          },
        ),
      ),
    );
    count = count + 1;
    notifyListeners();
  }

  delete_all() {
    lectureList = <Widget>[];
    count = 100;
    print(need);
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
    height = screen_height * 0.82/31 * (end_time - start_time)*1.5;
    vertical = screen_height * 0.82/31 * (1+ 1.5*start_time);
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
    ["대학글쓰기1", 1, 10.0, 14.0, "가나다", "58동 401호"],
    ["대학글쓰기2", 2, 0.0, 2.0, "라마바", "58동 402호"],
    ["Physics", 4, 3.0, 6.0, "사아자", "58동 403호"],
    ["Statistics", 5, 14.0, 17.0, "차카타파하", "58동 404호"],
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

          // Navigator.pop(context);
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
                _boxSize.setweek(selectedinfo[0]);
                _boxSize.setheight(selectedinfo[1], selectedinfo[2]);
                _boxSize.pr();
                _boxSize.add();
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
                _boxSize.setweek(selectedinfo[0]);
                _boxSize.pr();
                _boxSize.add();
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
  List<Widget> getListFiles() {
    List<Widget> list = lectureList;
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
