import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TimeTable extends StatefulWidget {
  const TimeTable({Key? key}) : super(key: key);

  @override
  _TimeTableState createState() => _TimeTableState();
}

class _TimeTableState extends State<TimeTable> {
  @override
  Widget build(BuildContext context) {
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
                      Text("시간표", style: TextStyle(color: Colors.black54,fontSize: 15),),
                      SizedBox(height: 10,),
                      Text("시간표1", style: TextStyle(color: Colors.black54,fontSize: 15),),
                      SizedBox(height: 10,),
                      Text("시간표2", style: TextStyle(color: Colors.black54,fontSize: 15),),]

                  // leading: Icon(Icons.home,
                  //   color: Colors.grey[850],),
                  // title:
                  // Column(
                  //       children: [
                  //         Text("2021 여름학기", style: TextStyle(color: Colors.black),),
                  //         Text("시간표", style: TextStyle(color: Colors.grey),), //클릭시 시간표 보여주는 기능 추가 필요
                  //       ],
                  //
                ),
              ),
            ],
          ),
        ),
        body: _Table()
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

Column _buildButtonMenu(){
  return Column(
    children: [
      SizedBox(height: 30,
      ),
      Text("직접 추가하기", style: TextStyle(fontSize: 15),),
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

    ],);
}

class _Table extends StatefulWidget {
  const _Table({Key? key}) : super(key: key);

  @override
  __TableState createState() => __TableState();
}

class __TableState extends State<_Table> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Container(color: Colors.grey, height: 591,
        padding: EdgeInsets.all(1.7),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(child: Text('', textAlign: TextAlign.center,),width: 20, height: 20, color: Colors.white,),
                SizedBox(width: 1.7,),
                Container(child: Text('월', textAlign: TextAlign.center,),width: 68, height: 20, color: Colors.white,),
                SizedBox(width: 1.7,),
                Container(child: Text('화', textAlign: TextAlign.center,),width: 68, height: 20, color: Colors.white,),
                SizedBox(width: 1.7,),
                Container(child: Text('수', textAlign: TextAlign.center,),width: 68, height: 20, color: Colors.white,),
                SizedBox(width: 1.7,),
                Container(child: Text('목', textAlign: TextAlign.center,),width: 68, height: 20, color: Colors.white,),
                SizedBox(width: 1.7,),
                Container(child: Text('금', textAlign: TextAlign.center,),width: 68, height: 20, color: Colors.white,),
              ],
            ),
            SizedBox(height: 1.7,),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(2),
                  child: Text('9', textAlign: TextAlign.right,),width: 20, height: 55, color: Colors.white,),
                TableRow()
              ],
            ),
            SizedBox(height: 1.7,),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(2),
                  child: Text('10', textAlign: TextAlign.right,),width: 20, height: 55, color: Colors.white,),
                TableRow()
              ],
            ),
            SizedBox(height: 1.7,),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(2),
                  child: Text('11', textAlign: TextAlign.right,),width: 20, height: 55, color: Colors.white,),
                TableRow()
              ],
            ),
            SizedBox(height: 1.7,),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(2),
                  child: Text('12', textAlign: TextAlign.right,),width: 20, height: 55, color: Colors.white,),
                TableRow()
              ],
            ),
            SizedBox(height: 1.7,),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(2),
                  child: Text('1', textAlign: TextAlign.right,),width: 20, height: 55, color: Colors.white,),
                TableRow()
              ],
            ),
            SizedBox(height: 1.7,),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(2),
                  child: Text('2', textAlign: TextAlign.right,),width: 20, height: 55, color: Colors.white,),
                TableRow()
              ],
            ),
            SizedBox(height: 1.7,),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(2),
                  child: Text('3', textAlign: TextAlign.right,),width: 20, height: 55, color: Colors.white,),
                TableRow()
              ],
            ),
            SizedBox(height: 1.7,),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(2),
                  child: Text('4', textAlign: TextAlign.right,),width: 20, height: 55, color: Colors.white,),
                TableRow()
              ],
            ),
            SizedBox(height: 1.7,),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(2),
                  child: Text('5', textAlign: TextAlign.right,),width: 20, height: 55, color: Colors.white,),
                TableRow()
              ],
            ),
            SizedBox(height: 1.7,),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(2),
                  child: Text('6', textAlign: TextAlign.right,),width: 20, height: 55, color: Colors.white,),
                TableRow()
              ],
            ),
          ],
        ),
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
    return Row(
      children: [
        SizedBox(width: 1.7,),
        Container(color: Colors.white,width: 68, height: 55,),
        SizedBox(width: 1.7,),
        Container(color: Colors.white,width: 68, height: 55,),
        SizedBox(width: 1.7,),
        Container(color: Colors.white,width: 68, height: 55,),
        SizedBox(width: 1.7,),
        Container(color: Colors.white,width: 68, height: 55,),
        SizedBox(width: 1.7,),
        Container(color: Colors.white,width: 68, height: 55,),
      ],
    );
  }
}

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
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed:() {
          close(context, "");
          // Navigator.pop(context);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    // show some result based on the selection
    return Scaffold(
      body: Text('hello'),
    );
  }

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
