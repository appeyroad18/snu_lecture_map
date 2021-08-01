import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TimeTable extends StatefulWidget {
  const TimeTable({Key? key}) : super(key: key);

  @override
  _TimeTableState createState() => _TimeTableState();
}

class _TimeTableState extends State<TimeTable> {
  @override
  Widget build(BuildContext context) {
    BoxSize _boxSize = Provider.of<BoxSize>(context);
    return
      ChangeNotifierProvider(
        create: (BuildContext context) => BoxSize(),
        child:
        Scaffold(
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
                    showSearch(context: context, delegate: DataSearch());
                    // Navigator.push(context, MaterialPageRoute(
                    //   builder: (context) => SearchPage()));
                  },
                ),
                IconButton(
                  icon: Icon(Icons.add_box_outlined),
                  color: Colors.black,
                  onPressed: () => _onButtonPressed(),
                ),
                IconButton(
                  icon: Icon(Icons.settings),
                  color: Colors.black,
                  onPressed: () {
                    _boxSize.delete_all();
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
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 15),
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
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 15),
                            ),
                          )
                        ]),
                  ),
                ],
              ),
            ),
            body: SingleChildScrollView(
              child: _Table(),
            )
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
  const TimeSelect({Key? key}) : super(key: key);

  @override
  _TimeSelectState createState() => _TimeSelectState();
}

class _TimeSelectState extends State<TimeSelect> {
  String _chosenDateTime = '';

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
                        _chosenDateTime = '월요일';
                      } else if (val == 1) {
                        _chosenDateTime = '화요일';
                      } else if (val == 2) {
                        _chosenDateTime = '수요일';
                      } else if (val == 3) {
                        _chosenDateTime = '목요일';
                      } else if (val == 4) {
                        _chosenDateTime = '금요일';
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
    return Column(
      children: [
        CupertinoButton(
          padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
          child: Text(
            '요일 및 시간 선택',
            style: TextStyle(fontSize: 15),
          ),
          onPressed: () => _showDatePicker(context),
        ),
        Text(_chosenDateTime),
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
    double screen_width = MediaQuery.of(context).size.width;
    double screen_height = MediaQuery.of(context).size.height;
    //double screen_width = double.infinity;
    //double screen_height = double.infinity;

    //List<String> my_lecture = ['기초영어', ];
    //if (context.read<BoxSize>().mlecture.length == 0) {
    //  String a = "";}
    // else if (context.read<BoxSize>().mlecture.length == 1) {
    //String a =  context.read<BoxSize>().mlecture[1];
    //}


    return Padding(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Container(
        height: screen_height - 150,
        decoration: BoxDecoration(
            border: Border(
                left: BorderSide(
                  color: Colors.grey,
                  width: 1,
                ),
                top: BorderSide(
                  color: Colors.grey,
                  width: 1,
                ))),
        child: Stack(children: [
          Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                      child: Text(
                        '',
                        textAlign: TextAlign.center,
                        style: TextStyle(height: 1.25),
                      ),
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                          border: Border(
                              right: BorderSide(
                                color: Colors.grey,
                                width: 1,
                              ),
                              bottom: BorderSide(
                                color: Colors.grey,
                                width: 1,
                              )))),
                  Container(
                      child: Text(
                        '월',
                        textAlign: TextAlign.center,
                        style: TextStyle(height: 1.25),
                      ),
                      width: (screen_width - 41) / 5,
                      height: 20,
                      decoration: BoxDecoration(
                          border: Border(
                              right: BorderSide(
                                color: Colors.grey,
                                width: 1,
                              ),
                              bottom: BorderSide(
                                color: Colors.grey,
                                width: 1,
                              )))),
                  Container(
                      child: Text(
                        '화',
                        textAlign: TextAlign.center,
                        style: TextStyle(height: 1.25),
                      ),
                      width: (screen_width - 41) / 5,
                      height: 20,
                      decoration: BoxDecoration(
                          border: Border(
                              right: BorderSide(
                                color: Colors.grey,
                                width: 1,
                              ),
                              bottom: BorderSide(
                                color: Colors.grey,
                                width: 1,
                              )))),
                  Container(
                      child: Text(
                        '수',
                        textAlign: TextAlign.center,
                        style: TextStyle(height: 1.25),
                      ),
                      width: (screen_width - 41) / 5,
                      height: 20,
                      decoration: BoxDecoration(
                          border: Border(
                              right: BorderSide(
                                color: Colors.grey,
                                width: 1,
                              ),
                              bottom: BorderSide(
                                color: Colors.grey,
                                width: 1,
                              )))),
                  Container(
                      child: Text(
                        '목',
                        textAlign: TextAlign.center,
                        style: TextStyle(height: 1.25),
                      ),
                      width: (screen_width - 41) / 5,
                      height: 20,
                      decoration: BoxDecoration(
                          border: Border(
                              right: BorderSide(
                                color: Colors.grey,
                                width: 1,
                              ),
                              bottom: BorderSide(
                                color: Colors.grey,
                                width: 1,
                              )))),
                  Container(
                      child: Text(
                        '금',
                        textAlign: TextAlign.center,
                        style: TextStyle(height: 1.25),
                      ),
                      width: (screen_width - 41) / 5,
                      height: 20,
                      decoration: BoxDecoration(
                          border: Border(
                              right: BorderSide(
                                color: Colors.grey,
                                width: 1,
                              ),
                              bottom: BorderSide(
                                color: Colors.grey,
                                width: 1,
                              )))),
                ],
              ),
              Row(
                children: [
                  Container(
                      padding: EdgeInsets.all(2),
                      child: Text(
                        '9',
                        textAlign: TextAlign.right,
                        style: TextStyle(fontSize: 13),
                      ),
                      width: 20,
                      height: (screen_height - 171) / 10,
                      decoration: BoxDecoration(
                          border: Border(
                              right: BorderSide(
                                color: Colors.grey,
                                width: 1,
                              ),
                              bottom: BorderSide(
                                color: Colors.grey,
                                width: 1,
                              )))),
                  TableRow()
                ],
              ),
              Row(
                children: [
                  Container(
                      padding: EdgeInsets.all(2),
                      child: Text('10',
                          textAlign: TextAlign.right,
                          style: TextStyle(fontSize: 13)),
                      width: 20,
                      height: (screen_height - 171) / 10,
                      decoration: BoxDecoration(
                          border: Border(
                              right: BorderSide(
                                color: Colors.grey,
                                width: 1,
                              ),
                              bottom: BorderSide(
                                color: Colors.grey,
                                width: 1,
                              )))),
                  TableRow()
                ],
              ),
              Row(
                children: [
                  Container(
                      padding: EdgeInsets.all(2),
                      child: Text('11',
                          textAlign: TextAlign.right,
                          style: TextStyle(fontSize: 13)),
                      width: 20,
                      height: (screen_height - 171) / 10,
                      decoration: BoxDecoration(
                          border: Border(
                              right: BorderSide(
                                color: Colors.grey,
                                width: 1,
                              ),
                              bottom: BorderSide(
                                color: Colors.grey,
                                width: 1,
                              )))),
                  TableRow()
                ],
              ),
              Row(
                children: [
                  Container(
                      padding: EdgeInsets.all(2),
                      child: Text('12',
                          textAlign: TextAlign.right,
                          style: TextStyle(fontSize: 13)),
                      width: 20,
                      height: (screen_height - 171) / 10,
                      decoration: BoxDecoration(
                          border: Border(
                              right: BorderSide(
                                color: Colors.grey,
                                width: 1,
                              ),
                              bottom: BorderSide(
                                color: Colors.grey,
                                width: 1,
                              )))),
                  TableRow()
                ],
              ),
              Row(
                children: [
                  Container(
                      padding: EdgeInsets.all(2),
                      child: Text('1',
                          textAlign: TextAlign.right,
                          style: TextStyle(fontSize: 13)),
                      width: 20,
                      height: (screen_height - 171) / 10,
                      decoration: BoxDecoration(
                          border: Border(
                              right: BorderSide(
                                color: Colors.grey,
                                width: 1,
                              ),
                              bottom: BorderSide(
                                color: Colors.grey,
                                width: 1,
                              )))),
                  TableRow()
                ],
              ),
              Row(
                children: [
                  Container(
                      padding: EdgeInsets.all(2),
                      child: Text('2',
                          textAlign: TextAlign.right,
                          style: TextStyle(fontSize: 13)),
                      width: 20,
                      height: (screen_height - 171) / 10,
                      decoration: BoxDecoration(
                          border: Border(
                              right: BorderSide(
                                color: Colors.grey,
                                width: 1,
                              ),
                              bottom: BorderSide(
                                color: Colors.grey,
                                width: 1,
                              )))),
                  TableRow()
                ],
              ),
              Row(
                children: [
                  Container(
                      padding: EdgeInsets.all(2),
                      child: Text('3',
                          textAlign: TextAlign.right,
                          style: TextStyle(fontSize: 13)),
                      width: 20,
                      height: (screen_height - 171) / 10,
                      decoration: BoxDecoration(
                          border: Border(
                              right: BorderSide(
                                color: Colors.grey,
                                width: 1,
                              ),
                              bottom: BorderSide(
                                color: Colors.grey,
                                width: 1,
                              )))),
                  TableRow()
                ],
              ),
              Row(
                children: [
                  Container(
                      padding: EdgeInsets.all(2),
                      child: Text('4',
                          textAlign: TextAlign.right,
                          style: TextStyle(fontSize: 13)),
                      width: 20,
                      height: (screen_height - 171) / 10,
                      decoration: BoxDecoration(
                          border: Border(
                              right: BorderSide(
                                color: Colors.grey,
                                width: 1,
                              ),
                              bottom: BorderSide(
                                color: Colors.grey,
                                width: 1,
                              )))),
                  TableRow()
                ],
              ),
              Row(
                children: [
                  Container(
                      padding: EdgeInsets.all(2),
                      child: Text('5',
                          textAlign: TextAlign.right,
                          style: TextStyle(fontSize: 13)),
                      width: 20,
                      height: (screen_height - 171) / 10,
                      decoration: BoxDecoration(
                          border: Border(
                              right: BorderSide(
                                color: Colors.grey,
                                width: 1,
                              ),
                              bottom: BorderSide(
                                color: Colors.grey,
                                width: 1,
                              )))),
                  TableRow()
                ],
              ),
              Row(
                children: [
                  Container(
                      padding: EdgeInsets.all(2),
                      child: Text('6',
                          textAlign: TextAlign.right,
                          style: TextStyle(fontSize: 13)),
                      width: 20,
                      height: (screen_height - 171) / 10,
                      decoration: BoxDecoration(
                          border: Border(
                              right: BorderSide(
                                color: Colors.grey,
                                width: 1,
                              ),
                              bottom: BorderSide(
                                color: Colors.grey,
                                width: 1,
                              )))),
                  TableRow()
                ],
              ),
            ],
          ),
          //LectureBox(), =====> change
          //List.unmodifiable(elements),
          ClassBox(lectureName: context.read<BoxSize>().mlecture[1],),
          ClassBox(lectureName: '',),
          ClassBox(lectureName: '',),
          ClassBox(lectureName: '',),

          // 1
          // 2
          // 3
          //_TableBox(),
          //AddBox(),
        ]),
      ),
    );
  }
}

class TableRow extends StatefulWidget {
  const TableRow({Key? key}) : super(key: key);

  @override
  _TableRowState createState() => _TableRowState();
}

class _TableRowState extends State<TableRow> {
  @override
  Widget build(BuildContext context) {
    double screen_width = MediaQuery.of(context).size.width;
    double screen_height = MediaQuery.of(context).size.height;

    return Row(
      children: [
        Column(
          children: [
            Container(
                width: (screen_width - 41) / 5,
                height: (screen_height - 171) / 20,
                decoration: BoxDecoration(
                    border: Border(
                        right: BorderSide(
                          color: Colors.grey,
                          width: 1,
                        ),
                        bottom: BorderSide(
                          color: Colors.grey,
                          width: 0.5,
                        )))),
            Container(
                width: (screen_width - 41) / 5,
                height: (screen_height - 171) / 20,
                decoration: BoxDecoration(
                    border: Border(
                        right: BorderSide(
                          color: Colors.grey,
                          width: 1,
                        ),
                        bottom: BorderSide(
                          color: Colors.grey,
                          width: 1,
                        )))),
          ],
        ),
        Column(
          children: [
            Container(
                width: (screen_width - 41) / 5,
                height: (screen_height - 171) / 20,
                decoration: BoxDecoration(
                    border: Border(
                        right: BorderSide(
                          color: Colors.grey,
                          width: 1,
                        ),
                        bottom: BorderSide(
                          color: Colors.grey,
                          width: 0.5,
                        )))),
            Container(
                width: (screen_width - 41) / 5,
                height: (screen_height - 171) / 20,
                decoration: BoxDecoration(
                    border: Border(
                        right: BorderSide(
                          color: Colors.grey,
                          width: 1,
                        ),
                        bottom: BorderSide(
                          color: Colors.grey,
                          width: 1,
                        )))),
          ],
        ),
        Column(
          children: [
            Container(
                width: (screen_width - 41) / 5,
                height: (screen_height - 171) / 20,
                decoration: BoxDecoration(
                    border: Border(
                        right: BorderSide(
                          color: Colors.grey,
                          width: 1,
                        ),
                        bottom: BorderSide(
                          color: Colors.grey,
                          width: 0.5,
                        )))),
            Container(
                width: (screen_width - 41) / 5,
                height: (screen_height - 171) / 20,
                decoration: BoxDecoration(
                    border: Border(
                        right: BorderSide(
                          color: Colors.grey,
                          width: 1,
                        ),
                        bottom: BorderSide(
                          color: Colors.grey,
                          width: 1,
                        )))),
          ],
        ),
        Column(
          children: [
            Container(
                width: (screen_width - 41) / 5,
                height: (screen_height - 171) / 20,
                decoration: BoxDecoration(
                    border: Border(
                        right: BorderSide(
                          color: Colors.grey,
                          width: 1,
                        ),
                        bottom: BorderSide(
                          color: Colors.grey,
                          width: 0.5,
                        )))),
            Container(
                width: (screen_width - 41) / 5,
                height: (screen_height - 171) / 20,
                decoration: BoxDecoration(
                    border: Border(
                        right: BorderSide(
                          color: Colors.grey,
                          width: 1,
                        ),
                        bottom: BorderSide(
                          color: Colors.grey,
                          width: 1,
                        )))),
          ],
        ),
        Column(
          children: [
            Container(
                width: (screen_width - 41) / 5,
                height: (screen_height - 171) / 20,
                decoration: BoxDecoration(
                    border: Border(
                        right: BorderSide(
                          color: Colors.grey,
                          width: 1,
                        ),
                        bottom: BorderSide(
                          color: Colors.grey,
                          width: 0.5,
                        )))),
            Container(
                width: (screen_width - 41) / 5,
                height: (screen_height - 171) / 20,
                decoration: BoxDecoration(
                    border: Border(
                        right: BorderSide(
                          color: Colors.grey,
                          width: 1,
                        ),
                        bottom: BorderSide(
                          color: Colors.grey,
                          width: 1,
                        )))),
          ],
        ),
      ],
    );
  }
}

class BoxSize with ChangeNotifier {
  String _selectedLecture = '초기화';
  double _width = 0; // 고정값
  double _height = 0;
  double _horizontal = 0;
  double _vertical = 0;
  List _mlecture = ["","",""]; // =====>change
  // List<Widget> _lectureList = <Widget>[Container(height: 20,width: 20,color: Colors.black,)]; =====>change

  String get selectedLecture => _selectedLecture;
  double get width => _width;
  double get height => _height;
  double get horizontal => _horizontal;
  double get vertical => _vertical;
  List get mlecture => _mlecture; // =====>change
  //List<Widget> get lectureList => _lectureList; // =====>change

  box() {

  }
  add() {
    _mlecture.add(_selectedLecture);
    print(_mlecture);
  }
/*
  add() {
    _lectureList.add(
        Align(
          alignment: Alignment(2, 2), //set position depend on lecture date and time
          child:
          Container(
            height : 50, //set height depend on lecture duration
            width : 50, //set width
            color: Colors.blue,

    ),),);
    pr(_lectureList);
    notifyListeners();
  }

 */
  delete_all() {
    _mlecture = [""];
  }
  //delete_all(){
  //  _lectureList = <Widget>[Container(height: 20,width: 20,color: Colors.black,)];
  //}

  pass(String lecture_name) {
    _selectedLecture = lecture_name;
    notifyListeners();
  }

  pr() {
    print(_selectedLecture);
    notifyListeners();
  }

  setweek(int week) {
    if (week  == 1) {
      _horizontal = -0.87;
    } else if (week  == 2) {
      _horizontal = -0.405;
    } else if (week == 3) {
      _horizontal = 0.065;
    } else if (week == 4) {
      _horizontal = 0.53;
    } else if (week  == 5) {
      _horizontal = 0.997;
    }
    notifyListeners();
  }

  setothers(double start_time, double end_time) {
    _vertical = start_time; // 연산추가 필요
    _height = end_time - start_time; //연산추가 필요
    print(_vertical);
    print(_height);
  }
  notifyListeners();
}
/*
class _TableBox extends StatefulWidget {
  const _TableBox({Key? key}) : super(key: key);

  @override
  __TableBoxState createState() => __TableBoxState();
}

class __TableBoxState extends State<_TableBox> {
  @override
  Widget build(BuildContext context) {
    BoxSize _boxSize = Provider.of<BoxSize>(context);
    return Stack(children: [
      GestureDetector(
        onTap: () {
          _boxSize.add();
        },
        child: Opacity(
            opacity: 0.0,
            child: Container(
              color: Colors.red,
            )),
      ),
    ]);
  }
}
*/

class DataSearch extends SearchDelegate<String> {

  final lectures = [
    "대학글쓰기1",
    "대학글쓰기2",
    "대학영어1",
    "대학영어2",
    "통계학",
    "통계학실험",
    "굿 라이프 심리학",
    "재무관리"
  ];
  final recentLectures = ["대학글쓰기1", "대학글쓰기2"];
  final lectureinfo = [["대학글쓰기1",1,3.0,5.0,"가나다","58동 401호"],
    ["대학글쓰기2",2,9.0,10.0,"라마바","58동 402호"],
    ["대학영어1",4,2.0,5.0,"사아자","58동 403호"],
    ["대학영어2",4,2.0,5.0,"차카타파하","58동 404호"]];

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
    final String lecName = context.read<BoxSize>().selectedLecture;
    List selectedinfo = ["","","","",""];

    for (List each in lectureinfo) {
      if (each[0] == lecName) {
        int lec_week = each[1];
        /*
        if (lec_week == 1) {
          selectedinfo[0] = '월요일';
        } else if (lec_week == 2) {
          selectedinfo[0] = '화요일';
        } else if (lec_week == 3) {
          selectedinfo[0] = '수요일';
        } else if (lec_week == 4) {
          selectedinfo[0] = '목요일';
        } else if (lec_week == 5) {
          selectedinfo[0] = '금요일';
        }
*/
        selectedinfo[0] = lec_week;
        double lec_start_time = each[2];
        selectedinfo[1] = lec_start_time;
        double lec_end_time = each[3];
        selectedinfo[2] = lec_end_time;
        String professor_name = each[4];
        selectedinfo[3] = professor_name;
        String place = each[5];
        selectedinfo[4] = place;

      };
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
                  Text(selectedinfo[3]),
                  SizedBox(width: 5,),
                  Text(selectedinfo[4]),
                ],
              ),
              Row(
                  children:[
                    Text(selectedinfo[0].toString()),
                    SizedBox(width: 5,),
                    Text(selectedinfo[1].toString()),
                    Text("-"),
                    Text(selectedinfo[2].toString()),
                  ]
              ),
            ],
          ),
          trailing: IconButton(
              icon: AnimatedIcon(
                icon: AnimatedIcons.event_add,
                progress: transitionAnimation,),
              onPressed: () {
                close(context, "bye");
                _boxSize.setweek(selectedinfo[0]);
                _boxSize.pr();
                _boxSize.add();
                _boxSize.setothers(selectedinfo[1], selectedinfo[2]);

                //print(context.read<BoxSize>().lectureList);
                print(context.read<BoxSize>().mlecture);
              }),
        ),
        ListTile(
          title: Text(lecName),
          subtitle: Column(
            children: [
              Row(
                children: [
                  Text(selectedinfo[3]),
                  SizedBox(width: 5,),
                  Text(selectedinfo[4]),
                ],
              ),
              Row(
                  children:[
                    Text(selectedinfo[0].toString()),
                    SizedBox(width: 5,),
                    Text(selectedinfo[1].toString()),
                    Text("-"),
                    Text(selectedinfo[2].toString()),
                  ]
              ),
            ],
          ),
          trailing: IconButton(
              icon: AnimatedIcon(
                icon: AnimatedIcons.event_add,
                progress: transitionAnimation,),
              onPressed: () {
                close(context, "bye");
                _boxSize.setweek(selectedinfo[0]);
                _boxSize.pr();
                _boxSize.add();
                _boxSize.setothers(selectedinfo[1], selectedinfo[2]);

                //print(context.read<BoxSize>().lectureList);
                print(context.read<BoxSize>().mlecture);
              }),
        ),

      ],
    );
  }
}

/*
class LectureBox extends StatefulWidget {
  const LectureBox({Key? key}) : super(key: key);

  @override
  _LectureBoxState createState() => _LectureBoxState();
}

class _LectureBoxState extends State<LectureBox> {
  @override
  List<Widget> getListFiles() {
    List<Widget> list = context.read<BoxSize>().lectureList;
    return list;
  }
  Widget build(BuildContext context) {
    //context.read<BoxSize>().lectureList.forEach((lec) => );
    return// Stack(
      //children: [
        //  context.read<BoxSize>().lectureList.forEach((lec) => lec.createElement())
     // ],
   // );

    Stack(
      children: List.unmodifiable(() sync* {
        yield* getListFiles();
      }()
      ),
    );
  }
}

*/

//참고용 widget
class ClassBox extends StatefulWidget {
  String lectureName;

  ClassBox({required this.lectureName});

  @override
  _ClassBoxState createState() => _ClassBoxState();
}

class _ClassBoxState extends State<ClassBox> {
  List<Widget> testList = <Widget>[
    Container(
        width : 50,
        height : 50,
        color : Colors.black
    ),
  ];

  void AddWidget(Widget adding){
    testList.add(adding);
  }

  double findStartTime(String lectureName){
    // in data find start time
    double startTime = 1;
    return startTime;
  }


  double ClassTime(String lectureName){

    return 31;
  }

  @override
  Widget build(BuildContext context) {
    double screen_width = MediaQuery.of(context).size.width;
    double screen_height = MediaQuery.of(context).size.height;
    double hor = context.read<BoxSize>().horizontal;
    double ver = context.read<BoxSize>().vertical;
    double hei = context.read<BoxSize>().height;

    return
      Align(
        alignment: Alignment(hor, -0.326), //set position depend on lecture date and time
        child: GestureDetector(
          child: Container(
            height : ClassTime(widget.lectureName), //set height depend on lecture duration
            width : (screen_width - 41) / 5, //set width
            color: Colors.blue,
          ),
          onTap:() {
            print(hor);
          },
        ),
      );
  }
}

