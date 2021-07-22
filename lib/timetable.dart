import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';


class TimeTable extends StatefulWidget {
  const TimeTable({Key? key}) : super(key: key);

  @override
  _TimeTableState createState() => _TimeTableState();
}

class _TimeTableState extends State<TimeTable> {
  @override
  Widget build(BuildContext context) {
    return
      //ChangeNotifierProvider(
      //create: (BuildContext context) => BoxSize(),
      //child:
      Scaffold(
          appBar: AppBar(
            title: Text('시간표',
              style: TextStyle(
                  color: Colors.black
              ),),
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
                  //Container(color: Colors.yellow,),
                  //Container(color: Colors.red,)],);
                  print('Setting button is clicked');
                },
              ),
            ],
          ),
          drawer: Drawer(

            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                ListTile(
                  contentPadding: EdgeInsets.fromLTRB(20,30,10,10),
                  title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("2021 여름학기", style: TextStyle(color: Colors.black,fontSize: 20),),
                        SizedBox(height: 10,),
                        TextButton(
                          onPressed: () {
                          },
                          child: Text("시간표", style: TextStyle(color: Colors.black54,fontSize: 15),),
                        ),
                        // SizedBox(height: 10,),
                        TextButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => SecondPage()));
                            },
                            child: Text("시간표1", style: TextStyle(color: Colors.black54,fontSize: 15),)),
                        // SizedBox(height: 10,),
                        TextButton(
                          onPressed: (){},
                          child: Text("시간표2", style: TextStyle(color: Colors.black54,fontSize: 15),),)]
                  ),
                ),
              ],
            ),
          ),
          body: SingleChildScrollView(child: _Table(),)
        //  ),
      );
  }
  void _onButtonPressed() {
    showModalBottomSheet(context: context, builder: (context){
      return Container(
        color: Color(0xFF737373),
        height : 460,
        child:Container(
          child: _buildButtonMenu(),
          decoration: BoxDecoration(
              color: Theme.of(context).canvasColor,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(30),
                topRight: const Radius.circular(30),
              )
          ),
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
        title: Text('시간표',
          style: TextStyle(
              color: Colors.black
          ),),
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
        SizedBox(height: 30,
        ),
        Row(mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text("직접 추가하기", style: TextStyle(fontSize: 15),),
            SizedBox(width:70,),
            TextButton(
              child: Text("확인"),
              onPressed: () {
                Navigator.pop(context,"");
                //_boxSize.add();
                print('hello');
              },
            ),
            SizedBox(width:20,)
          ],
        ),
        ListTile(

          // horizontalTitleGap: -10,
          // leading: Icon(Icons.check, size: 20, color: Colors.white,),
          title: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: TextField(
              cursorColor: Colors.grey,
              decoration: InputDecoration(
                  hintText: "강의명"
              ),
            ),
          ),
        ),
        ListTile(
          title: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: TextField(
              cursorColor: Colors.grey,
              decoration: InputDecoration(
                  hintText: "교수명"
              ),
            ),
          ),
        ),
        TimeSelect()
      ],);
  }
}

class TimeSelect extends StatefulWidget {
  const TimeSelect({Key? key}) : super(key: key);

  @override
  _TimeSelectState createState() => _TimeSelectState();
}

class _TimeSelectState extends State<TimeSelect> {
  String _chosenDateTime='';

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
                      if (val==0) {
                        _chosenDateTime = '월요일';
                      } else if (val==1) {
                        _chosenDateTime = '화요일';
                      } else if (val==2) {
                        _chosenDateTime = '수요일';
                      } else if (val==3) {
                        _chosenDateTime = '목요일';
                      } else if (val==4) {
                        _chosenDateTime = '금요일';
                      }
                    });
                  },
                  itemExtent: 32,
                  children: [Text('월'),Text('화'),Text('수'),Text('목'),Text('금')],),
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
          child: Text('요일 및 시간 선택', style: TextStyle(fontSize: 15),),
          onPressed: () => _showDatePicker(context),
        ),
        Text(_chosenDateTime), ],

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

    return Padding(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      child:
      Container(height: screen_height-150,
        decoration: BoxDecoration(border: Border(left : BorderSide(color: Colors.grey, width: 1,),top:BorderSide(color: Colors.grey, width: 1,))),
        child: Stack(
            children: [Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(child: Text('', textAlign: TextAlign.center,style: TextStyle(height: 1.25),),width: 20, height: 20,
                        decoration: BoxDecoration(border: Border(
                            right : BorderSide(color: Colors.grey, width: 1,),bottom:BorderSide(color: Colors.grey, width: 1,)))),
                    Container(child: Text('월', textAlign: TextAlign.center, style: TextStyle(height: 1.25),), width: (screen_width-41)/5, height: 20,
                        decoration: BoxDecoration(border: Border(
                            right : BorderSide(color: Colors.grey, width: 1,),bottom:BorderSide(color: Colors.grey, width: 1,)))),
                    Container(child: Text('화', textAlign: TextAlign.center, style: TextStyle(height: 1.25),), width: (screen_width-41)/5, height: 20,
                        decoration: BoxDecoration(border: Border(
                            right : BorderSide(color: Colors.grey, width: 1,),bottom:BorderSide(color: Colors.grey, width: 1,)))),
                    Container(child: Text('수', textAlign: TextAlign.center, style: TextStyle(height: 1.25),), width: (screen_width-41)/5, height: 20,
                        decoration: BoxDecoration(border: Border(
                            right : BorderSide(color: Colors.grey, width: 1,),bottom:BorderSide(color: Colors.grey, width: 1,)))),
                    Container(child: Text('목', textAlign: TextAlign.center, style: TextStyle(height: 1.25),), width: (screen_width-41)/5, height: 20,
                        decoration: BoxDecoration(border: Border(
                            right : BorderSide(color: Colors.grey, width: 1,),bottom:BorderSide(color: Colors.grey, width: 1,)))),
                    Container(child: Text('금', textAlign: TextAlign.center, style: TextStyle(height: 1.25),), width: (screen_width-41)/5, height: 20,
                        decoration: BoxDecoration(border: Border(
                            right : BorderSide(color: Colors.grey, width: 1,),bottom:BorderSide(color: Colors.grey, width: 1,)))),
                  ],
                ),
                Row(
                  children: [
                    Container(
                        padding: EdgeInsets.all(2),
                        child: Text('9', textAlign: TextAlign.right,style: TextStyle(fontSize: 13),),width:20, height: (screen_height-171)/10,
                        decoration: BoxDecoration(border: Border(
                            right : BorderSide(color: Colors.grey, width: 1,),bottom:BorderSide(color: Colors.grey, width: 1,)))),
                    TableRow()
                  ],
                ),
                Row(
                  children: [
                    Container(
                        padding: EdgeInsets.all(2),
                        child: Text('10', textAlign: TextAlign.right,style: TextStyle(fontSize: 13)),width:20, height: (screen_height-171)/10,
                        decoration: BoxDecoration(border: Border(
                            right : BorderSide(color: Colors.grey, width: 1,),bottom:BorderSide(color: Colors.grey, width: 1,)))),
                    TableRow()
                  ],
                ),
                Row(
                  children: [
                    Container(
                        padding: EdgeInsets.all(2),
                        child: Text('11', textAlign: TextAlign.right,style: TextStyle(fontSize: 13)),width:20, height: (screen_height-171)/10,
                        decoration: BoxDecoration(border: Border(
                            right : BorderSide(color: Colors.grey, width: 1,),bottom:BorderSide(color: Colors.grey, width: 1,)))),
                    TableRow()
                  ],
                ),
                Row(
                  children: [
                    Container(
                        padding: EdgeInsets.all(2),
                        child: Text('12', textAlign: TextAlign.right,style: TextStyle(fontSize: 13)),width:20, height: (screen_height-171)/10,
                        decoration: BoxDecoration(border: Border(
                            right : BorderSide(color: Colors.grey, width: 1,),bottom:BorderSide(color: Colors.grey, width: 1,)))),
                    TableRow()
                  ],
                ),
                Row(
                  children: [
                    Container(
                        padding: EdgeInsets.all(2),
                        child: Text('1', textAlign: TextAlign.right,style: TextStyle(fontSize: 13)),width:20, height: (screen_height-171)/10,
                        decoration: BoxDecoration(border: Border(
                            right : BorderSide(color: Colors.grey, width: 1,),bottom:BorderSide(color: Colors.grey, width: 1,)))),
                    TableRow()
                  ],
                ),
                Row(
                  children: [
                    Container(
                        padding: EdgeInsets.all(2),
                        child: Text('2', textAlign: TextAlign.right,style: TextStyle(fontSize: 13)),width:20, height: (screen_height-171)/10,
                        decoration: BoxDecoration(border: Border(
                            right : BorderSide(color: Colors.grey, width: 1,),bottom:BorderSide(color: Colors.grey, width: 1,)))),
                    TableRow()
                  ],
                ),
                Row(
                  children: [
                    Container(
                        padding: EdgeInsets.all(2),
                        child: Text('3', textAlign: TextAlign.right,style: TextStyle(fontSize: 13)),width:20, height: (screen_height-171)/10,
                        decoration: BoxDecoration(border: Border(
                            right : BorderSide(color: Colors.grey, width: 1,),bottom:BorderSide(color: Colors.grey, width: 1,)))),
                    TableRow()
                  ],
                ),
                Row(
                  children: [
                    Container(
                        padding: EdgeInsets.all(2),
                        child: Text('4', textAlign: TextAlign.right,style: TextStyle(fontSize: 13)),width:20, height: (screen_height-171)/10,
                        decoration: BoxDecoration(border: Border(
                            right : BorderSide(color: Colors.grey, width: 1,),bottom:BorderSide(color: Colors.grey, width: 1,)))),
                    TableRow()
                  ],
                ),
                Row(
                  children: [
                    Container(
                        padding: EdgeInsets.all(2),
                        child: Text('5', textAlign: TextAlign.right,style: TextStyle(fontSize: 13)),width:20, height: (screen_height-171)/10,
                        decoration: BoxDecoration(border: Border(
                            right : BorderSide(color: Colors.grey, width: 1,),bottom:BorderSide(color: Colors.grey, width: 1,)))),
                    TableRow()
                  ],
                ),
                Row(
                  children: [
                    Container(
                        padding: EdgeInsets.all(2),
                        child: Text('6', textAlign: TextAlign.right,style: TextStyle(fontSize: 13)),width:20, height: (screen_height-171)/10,
                        decoration: BoxDecoration(border: Border(
                            right : BorderSide(color: Colors.grey, width: 1,),bottom:BorderSide(color: Colors.grey, width: 1,)))),
                    TableRow()
                  ],
                ),
              ],
            ),
              _TableBox(),
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
            Container(width: (screen_width-41)/5, height: (screen_height-171)/20,
                decoration: BoxDecoration(border: Border(
                    right : BorderSide(color: Colors.grey, width: 1,),bottom:BorderSide(color: Colors.grey, width: 0.5,)))),
            Container(width: (screen_width-41)/5, height: (screen_height-171)/20,
                decoration: BoxDecoration(border: Border(
                    right : BorderSide(color: Colors.grey, width: 1,),bottom:BorderSide(color: Colors.grey, width: 1,)))),
          ],),
        Column(
          children: [
            Container(width: (screen_width-41)/5, height: (screen_height-171)/20,
                decoration: BoxDecoration(border: Border(
                    right : BorderSide(color: Colors.grey, width: 1,),bottom:BorderSide(color: Colors.grey, width: 0.5,)))),
            Container(width: (screen_width-41)/5, height: (screen_height-171)/20,
                decoration: BoxDecoration(border: Border(
                    right : BorderSide(color: Colors.grey, width: 1,),bottom:BorderSide(color: Colors.grey, width: 1,)))),
          ],),
        Column(
          children: [
            Container(width: (screen_width-41)/5, height: (screen_height-171)/20,
                decoration: BoxDecoration(border: Border(
                    right : BorderSide(color: Colors.grey, width: 1,),bottom:BorderSide(color: Colors.grey, width: 0.5,)))),
            Container(width: (screen_width-41)/5, height: (screen_height-171)/20,
                decoration: BoxDecoration(border: Border(
                    right : BorderSide(color: Colors.grey, width: 1,),bottom:BorderSide(color: Colors.grey, width: 1,)))),
          ],),
        Column(
          children: [
            Container(width: (screen_width-41)/5, height: (screen_height-171)/20,
                decoration: BoxDecoration(border: Border(
                    right : BorderSide(color: Colors.grey, width: 1,),bottom:BorderSide(color: Colors.grey, width: 0.5,)))),
            Container(width: (screen_width-41)/5, height: (screen_height-171)/20,
                decoration: BoxDecoration(border: Border(
                    right : BorderSide(color: Colors.grey, width: 1,),bottom:BorderSide(color: Colors.grey, width: 1,)))),
          ],),
        Column(
          children: [
            Container(width: (screen_width-41)/5, height: (screen_height-171)/20,
                decoration: BoxDecoration(border: Border(
                    right : BorderSide(color: Colors.grey, width: 1,),bottom:BorderSide(color: Colors.grey, width: 0.5,)))),
            Container(width: (screen_width-41)/5, height: (screen_height-171)/20,
                decoration: BoxDecoration(border: Border(
                    right : BorderSide(color: Colors.grey, width: 1,),bottom:BorderSide(color: Colors.grey, width: 1,)))),
          ],),
      ],
    );
  }
}

class BoxSize with ChangeNotifier {
  double _boxwidth = 0;
  double get boxwidth => _boxwidth;
  add() {
    _boxwidth = _boxwidth + 10;
    notifyListeners();
  }
  pr(){
    print("hello");
    notifyListeners();
  }
}

class _TableBox extends StatefulWidget {
  const _TableBox({Key? key}) : super(key: key);

  @override
  __TableBoxState createState() => __TableBoxState();
}

class __TableBoxState extends State<_TableBox> {
  @override
  Widget build(BuildContext context) {
    // BoxSize _boxSize = Provider.of<BoxSize>(context);
    return Stack(
        children: [
          GestureDetector(
            onTap: () {
              // _boxSize.add();
            },
            child: Opacity(

                opacity: 0.0, child:
            Container(color: Colors.red,)),
          ),

        ]);
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
  Widget build(BuildContext context) {
    double screen_width = MediaQuery.of(context).size.width;
    double screen_height = MediaQuery.of(context).size.height;
    return Positioned(bottom: 10, right: 10,
        top: screen_height / 43 + screen_height / 500,
        left: screen_width / 18 + screen_width / 250 +(screen_width / 250 + screen_width / 5.8) * 0,
        child: Container(color: Colors.yellow,)
    );
  }
}
*/
/*
class AddBox extends StatefulWidget {
  const AddBox({Key? key}) : super(key: key);

  @override
  _AddBoxState createState() => _AddBoxState();
}

class _AddBoxState extends State<AddBox> {
  @override
  Widget build(BuildContext context) {

    return Container(color: Colors.red,
        width: Provider.of<BoxSize>(context).boxwidth,
        height: Provider.of<BoxSize>(context).boxwidth);

  }
}
*/
class DataSearch extends SearchDelegate<String> {
  final lectures = [
    "대학글쓰기1", "대학글쓰기2", "대학영어1", "대학영어2", "통계학", "통계학실험", "굿 라이프 심리학", "재무관리"
  ];
  final recentLectures = ["대학글쓰기1", "대학글쓰기2"];
  @override
  List<Widget> buildActions(BuildContext context) {
    // actions for app bar
    return [IconButton(icon: Icon(Icons.clear), onPressed: () {
      query = "";
    })];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // leading icon on the left of the app bar
    // BoxSize _boxSize = Provider.of<BoxSize>(context);
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed:() {
          // _boxSize.add();
          close(context, "");
          // Navigator.pop(context);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    // show some result based on the selection
    //BoxSize _boxSize = Provider.of<BoxSize>(context);
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed:() {
          close(context, "");
          // _boxSize.add();
          // _boxSize.pr();


          /*Stack(
            children: [_TableBox(),
              // Positioned(bottom: 10, right: 10,
              // top: screen_height / 43 + screen_height / 500,
               //  left: screen_width / 18 + screen_width / 250 +(screen_width / 250 + screen_width / 5.8) * 0,
                // child:
                  Container(color: Colors.yellow,)]
          );

          // Navigator.pop(context);
          */

        });
  }


  //     Scaffold(
  //     body: Text('hello'),
  //   );
  // }

  @override
  Widget buildSuggestions(BuildContext context) {
    // show when someone searches for something
    final suggestionList = query.isEmpty?recentLectures
        :lectures.where((p)=>p.startsWith(query)).toList();

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: (){
          showResults(context);
        },
        leading: Icon(Icons.circle),
        title: RichText(text: TextSpan(
            text: suggestionList[index].substring(0,query.length),
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            children: [TextSpan(
                text: suggestionList[index].substring(query.length),
                style: TextStyle(color: Colors.grey))
            ]),
        ),
      ),
      itemCount: suggestionList.length,
    );
  }
}
