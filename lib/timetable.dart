import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_picker/flutter_picker.dart';

String selectedLecture = '초기화';
String selectedLecture_classroom = '강의실';
double width = 0; // 고정값
double height = 0;
double horizontal = 0;
double vertical = 0;
List<Widget> lectureList = <Widget>[/*Opacity(key: ValueKey(0), child: Container(height: 20,width: 20,color: Colors.black,), opacity: 0.0,),*/];
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
    return
      ChangeNotifierProvider(
        create: (BuildContext context) => BoxSize(),
        child:
        Scaffold(
            appBar: AppBar(
              //toolbarHeight: 60,
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
                    onPressed: () { Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SelfAdd()));}
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
            mainAxisAlignment: MainAxisAlignment.center,
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
          Container(height: 1,color: Colors.black12,),
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

  void _showDatePicker(context) {
    new Picker(
        adapter: NumberPickerAdapter(data: [
          NumberPickerColumn(begin: 9, end: 18),
          NumberPickerColumn(begin: 0, end: 59),
          NumberPickerColumn(begin: 9, end: 18),
          NumberPickerColumn(begin: 0, end: 59),
        ]),
        hideHeader: true,
        delimiter: [ // 구분자
          PickerDelimiter(child: Container(
            width: 10.0,
            alignment: Alignment.center,
            child: Text(':'),
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

        }
    ).showDialog(context);
  }
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
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
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
                OutlinedButton(onPressed: () {}, child: Text('월요일'),
                  //  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.black2),)
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment(-1,0),
            child: TextButton(
              child : Text(start_hour+':'+start_minute + ' ~ '+ end_hour+':'+end_minute),
              onPressed: () => _showDatePicker(context), ),
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
    double height1 = (screen_height - 134) / 31;
    double height2 = (screen_height - 134) / 31 * 3;
    double width1 = screen_width / 16;
    double width2 = screen_width / 16 *3;
    // double screen_width = double.infinity;
    //double screen_height = double.infinity;


    return Container(
      height: screen_height - 134, // 50 = 메뉴바, 60 = appbar, 20 =?
      width: screen_width,
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
                    width: width1,
                    height:height1,
                    decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(
                              color: Colors.grey,
                              width: 1,
                            ),
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
                    width: width2,
                    height: height1,
                    decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(
                              color: Colors.grey,
                              width: 1,
                            ),
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
                    width: width2,
                    height: height1,
                    decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(
                              color: Colors.grey,
                              width: 1,
                            ),
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
                    width: width2,
                    height: height1,
                    decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(
                              color: Colors.grey,
                              width: 1,
                            ),
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
                    width: width2,
                    height: height1,
                    decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(
                              color: Colors.grey,
                              width: 1,
                            ),
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
                    width: width2,
                    height: height1,
                    decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(
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
                    width: width1,
                    height: height2,
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
                    width: width1,
                    height: height2,
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
                    width: width1,
                    height: height2,
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
                    width: width1,
                    height: height2,
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
                    width: width1,
                    height: height2,
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
                    width: width1,
                    height: height2,
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
                    width: width1,
                    height: height2,
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
                    width: width1,
                    height: height2,
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
                    width: width1,
                    height: height2,
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
                    width: width1,
                    height: height2,
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
        LectureBox(),

      ]),
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
    double height3 = (screen_height - 134) / 31 * 3 /2;
    double width2 = screen_width / 16 *3 ;

    return Row(
      children: [
        Column(
          children: [
            Container(
                width: width2,
                height: height3,
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
                width: width2,
                height: height3,
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
                width: width2,
                height: height3,
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
                width: width2,
                height: height3,
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
                width: width2,
                height: height3,
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
                width: width2,
                height: height3,
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
                width: width2,
                height: height3,
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
                width: width2,
                height: height3,
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
                width: width2,
                height: height3,
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
                width: width2,
                height: height3,
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

  add() {
    // print((screen_width/16)/(screen_width/2))
    // int i = lectureList.length;
    int mykey = count;
    int mykey_check = mykey;
    lectureList.add(
      Align(
        key: ValueKey(mykey),
        alignment: Alignment(horizontal, 0), //set position depend on lecture date and time
        child:
        GestureDetector(
          child: Container(
            height : (screen_height - 134) / 31 * 3 - 10, //set height depend on lecture duration
            width : (screen_width / 16 * 3)-1, //set width
            color: Colors.orange,
            child: Column(
              children: [
                Text(selectedLecture,style: TextStyle(fontSize: 12) ),
                Text(selectedLecture_classroom, style: TextStyle(fontSize: 10),)
              ],
            ),

          ),
          onTap: () {
            print('hello');
          },
          onLongPress: () {
            print("hi");
            lectureList.removeWhere((k) => (k.key as ValueKey).value == mykey_check);
            notifyListeners();
            print("hi");
          },
        ),
      ),
    );
    count = count +1;
    notifyListeners();
  }

  delete_all(){
    //print(lectureList[0].runtimeType);
    //lectureList = <Widget>[Opacity(key: ValueKey(0) ,child: Container(height: 20,width: 20,color: Colors.black,), opacity: 0.0,),];
    lectureList = <Widget>[];
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

  setweek(int week) {  // 화면 위치보고 정함
    if (week  == 1) {
      horizontal = -0.847;
    } else if (week  == 2) {
      horizontal = -0.386;
    } else if (week == 3) {
      horizontal = 0.0735;
    } else if (week == 4) {
      horizontal = 0.534;
    } else if (week  == 5) {
      horizontal = 0.993;
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
  final recentLectures = ["대학글쓰기1", "대학글쓰기2","Physics", "Statistics"];
  final lectureinfo = [["대학글쓰기1",1,3,5,"가나다","58동 401호"],
    ["대학글쓰기2",2,9,10,"라마바","58동 402호"],
    ["Physics",4,2,5,"사아자","58동 403호"],
    ["Statistics",4,2,5,"차카타파하","58동 404호"],
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
    List selectedinfo = ["대학글쓰기1",1,3,5,"정다은","58동 404호"];

    for (List each in lectureinfo) {
      if (each[0] == lecName) {
        int lec_week = each[1];
        selectedinfo[0] = lec_week;
        int lec_start_time = each[2];
        selectedinfo[1] = lec_start_time;
        int lec_end_time = each[3];
        selectedinfo[2] = lec_end_time;
        String professor_name = each[4];
        selectedinfo[3] = professor_name;
        String place = each[5];
        selectedinfo[4] = place;
        selectedLecture_classroom = place;

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
      }()
      ),
    );
  }
}
