import 'dart:core';


import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:snu_lecture_map/dataclass.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'dart:async';

class SearchScreen extends StatefulWidget {
  double bottomBarHeight;
  double appBarHeight;

  SearchScreen({Key? key, required this.bottomBarHeight, required this.appBarHeight}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment(0.8, -0.9),
            child: InkWell(
              onTap: (){
                print("get course catalog");
                getDataFromSheet();
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.all(Radius.circular(3.0)),
                ),

                child : Padding(

                  child: Text("refresh course catalog"),
                  padding: EdgeInsets.all(10.0),
                ),
              ),
            ),

          ),
        ],
      ),


    );
  }
}

List<Dataclass> dataclass = [];

getDataFromSheet() async{
  var raw = await http.get(Uri.parse("https://script.google.com/macros/s/AKfycby0aVRkupDPMY_9IQTyzSweHM4fhiRLzEMjccNABoC5EVTq2Ik/exec"));

  var jsonData = convert.jsonDecode(raw.body);

  jsonData.forEach((element) {
    //print('$element');
    Dataclass data = new Dataclass();
    data.curriculum_division = element['교과구분'];
    data.department = element['개설대학'];
    data.major = element['개설학과'];
    data.comple_course = element['이수과정'];
    data.grade = element['학년'];
    data.class_number = element['교과목번호'];
    data.lecture_number = element['강좌번호'];
    data.name = element['교과목명'];
    data.credit = element['학점'];
    data.lecture_credit = element['강의'];
    data.experiment_credit = element['실습'];
    data.time = element['수업교시'];
    data.type = element['수업형태'];
    data.n14 = element['강의실'];
    data.professor = element['담당교수'];
    data.capacity = element['정원'];
    data.note = element['비고'];
    data.language = element['강의언어'];

    dataclass.add(data);
    //print('length of DATAS : ${dataclass.length}');
  });
  //print('${dataclass[8075].time}');
  //print('${dataclass[8075].time!.indexOf('~')}');
  double temp = double.tryParse(dataclass[8075].time!.substring(2,4))!;
  temp += double.tryParse(dataclass[8075].time!.substring(5,7))!/60;
  //print('$temp');

  PreProcessingData();
  SaveData();

/*
  var tempa = SearchingBuilding("301");
  for(int i=0;i<tempa.length;i++){
    print("${tempa[i]}");
  }

 */
/*
  var tempb = SearchingNameData("경제");
  for(int i=0;i<tempb.length;i++){
    print("${tempb[i]} : ${dataclass[tempb[i]].lecture_time![0].EndTime}");
  }


 */

}

PreProcessingData(){
  for(int i = 0 ; i<dataclass.length ; i++)
  {
    //수업 교시 전처리
    int NumOfSlash_time = 0;
    List<LectureTime> lecturetime = [];

    if(dataclass[i].time != '^^^'){
      for(int j = 0 ; j<dataclass[i].time!.length ; j++)
      {
        if(dataclass[i].time![j]=='/')
        {
          NumOfSlash_time++;
        }
      }

      for(int j = 0 ; j<NumOfSlash_time+1 ; j++)
      {
        LectureTime newlecturetime = new LectureTime();
        newlecturetime.day=999;
        newlecturetime.StartTime=999;
        newlecturetime.EndTime=999;


        //day 지정
        switch(dataclass[i].time![15*j])
            {
          case '월':
            newlecturetime.day = 1;
            break;
          case '화':
            newlecturetime.day = 2;
            break;
          case '수':
            newlecturetime.day = 3;
            break;
          case '목':
            newlecturetime.day = 4;
            break;
          case '금':
            newlecturetime.day = 5;
            break;
          case '토':
            newlecturetime.day = 6;
            break;
          case '일':
            newlecturetime.day = 0;
            break;
        }
        //StartTime 지정
        double temp = double.tryParse(dataclass[i].time!.substring(2+15*j,4+15*j))!;
        double temp_end = double.tryParse(dataclass[i].time!.substring(5+15*j,7+15*j))!/60;
        if(temp_end>=0.15 && temp_end<=0.5)
        {
          temp_end=0.5;
        }
        if(temp_end>=0.65 && temp_end<=0.99)
        {
          temp_end=1;
        }
        temp+=temp_end;

        double new_temp=0;
        new_temp=2*temp-17;

        newlecturetime.StartTime=new_temp;
        //EndTime 지정
        temp=0;
        temp_end=0;
        temp = double.tryParse(dataclass[i].time!.substring(8+15*j,10+15*j))!;
        temp_end = double.tryParse(dataclass[i].time!.substring(11+15*j,13+15*j))!/60;
        if(temp_end>=0.15 && temp_end<=0.5)
        {
          temp_end=0.5;
        }
        if(temp_end>=0.65 && temp_end<=0.99)
        {
          temp_end=1;
        }
        temp+=temp_end;

        new_temp=0;
        new_temp=2*temp-17;


        newlecturetime.EndTime=new_temp;

        lecturetime.add(newlecturetime);
      }
    }
    else{
      LectureTime newlecturetime = new LectureTime();
      newlecturetime.day=999;
      newlecturetime.StartTime=999;
      newlecturetime.EndTime=999;
      lecturetime.add(newlecturetime);
    }

    dataclass[i].lecture_time = lecturetime;
    //print('${dataclass[i].lecture_time![0].StartTime!}');
  }

  //강의동 전처리

  for(int i = 0 ; i<dataclass.length ; i++)
  {
    int NumOfSlash_time = 0;
    List<int> SlashIndex = List.generate(10, (index) => 0);
    List<String> SlicedString = List.generate(10, (index) => "0");
    if (dataclass[i].n14![0]=='/' || dataclass[i].n14![0]=='*') {
      dataclass[i].n14 = dataclass[i].n14!.substring(1);
    }
    if (dataclass[i].n14![dataclass[i].n14!.length-1]=='/') {
      dataclass[i].n14 = dataclass[i].n14!.substring(0,dataclass[i].n14!.length-1);
    }
    for(int j = 0 ; j<dataclass[i].n14!.length ; j++) {

      if (dataclass[i].n14![j] == '/') {
        NumOfSlash_time++;
        SlashIndex[NumOfSlash_time]=j;
      }
    }
    if(NumOfSlash_time>0) {
      for (int k = 0; k <= NumOfSlash_time; k++) {
        if (k == 0) {
          SlicedString[k] = dataclass[i].n14!.substring(0, SlashIndex[k + 1]);
        }
        else if (k == NumOfSlash_time) {
          SlicedString[k] = dataclass[i].n14!.substring(SlashIndex[k] + 1);
        }
        else {
          SlicedString[k] = dataclass[i].n14!.substring(
              SlashIndex[k] + 1, SlashIndex[k + 1]);
        }
        //print("${SlicedString[k]}");
      }
      var temp = '0';
      bool coincidence = true;

      int idx = SlicedString[0].indexOf("-");
      temp = SlicedString[0].substring(0, idx);

      for(int l=1;l<=NumOfSlash_time;l++){
        int idx_new = SlicedString[l].indexOf("-");
        var temp_new = SlicedString[l].substring(0,idx_new);
        //print("${temp_new}");
        if(temp_new != temp){
          coincidence = false;
        }
        temp=temp_new;
        idx=idx_new;
        //print("${coincidence}");
      }
    }


    //print("${dataclass[i].n14}");

    if(NumOfSlash_time==0) {
      int NumOfHyphen = 0;
      List<int> HyphenIndex = List.generate(10, (index) => 0);
      for (int j = 0; j < dataclass[i].n14!.length; j++) {
        if (dataclass[i].n14![j] == '-') {
          NumOfHyphen++;
          HyphenIndex[NumOfHyphen] = j;
        }
      }
      if (NumOfHyphen == 1) {
        var temp_building = dataclass[i].n14!.substring(0, HyphenIndex[1]);
        var temp_room = dataclass[i].n14!.substring(HyphenIndex[1] + 1);
        LectureBR temp_lecturebr = new LectureBR();
        temp_lecturebr.Building = temp_building;
        temp_lecturebr.Room = temp_room;
        dataclass[i].lecture_buildingroom=[];
        dataclass[i].lecture_buildingroom!.add(temp_lecturebr);
        //print("${dataclass[i].lecture_buildingroom![0].Building}");
      }
    }
  }


  //print("${dataclass.length}");
  //수업 교시 전처리
}

SearchingNameData(String info){
  List<int> coincidence = [];
  for (int i=0; i<dataclass.length;i++){
    var haystack_size = dataclass[i].name!.length;
    var needle_size = info.length;
    for(int j=0;j<haystack_size - needle_size;++j){
      int k=0;
      for(k=0;k<needle_size;++k){
        if(dataclass[i].name![j+k] == info[k]){
          continue;
        }
        break;
      }
      if(k==needle_size){
        coincidence.add(i);
      }
    }
  }
  return coincidence;
}

SearchingBuilding(String info){
  List<int> coincidence = [];
  for (int i=0; i<dataclass.length;i++){

    for(int j=0; j<dataclass[i].lecture_buildingroom!.length; j++) {
      var haystack_size = dataclass[i].lecture_buildingroom![j].Building!.length;
      var needle_size = info.length;
      for (int l = 0; l < haystack_size - needle_size; ++l) {
        int k = 0;
        for (k = 0; k < needle_size; ++k) {
          if (dataclass[i].lecture_buildingroom![j].Building![l + k]== info[k]) {
            continue;
          }
          break;
        }
        if (k == needle_size) {
          coincidence.add(i);
        }
      }
    }

  }
  return coincidence;
}

SaveData() async{

  //Generate or Open Database
  final Future<Database> database = openDatabase(
    join(await getDatabasesPath(), 'datanamed.db'),
    onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE data(idx INTEGER PRIMARY KEY, name TEXT)",
      );
    },
    version: 1,
  );
  print("done");

  //Function : insert Dataclass into DB
  Future<void> insertData(Dataname dataname) async {

    final Database db = await database;

    await db.insert(
      'data',
      dataname.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  //dataclass(dataname) 의 변수를 얻는 함수
  Future<List<Dataname>> data() async {
    final Database db = await database;

    final List<Map<String, dynamic>> maps = await db.query('data');

    return List.generate(maps.length, (i) {
      return Dataname(
        idx: maps[i]['idx'],
        name: maps[i]['name'],
      );
    });
  }

  //db 수정 함수
  Future<void> updateDataname(Dataname dataname) async {
    final db = await database;

    await db.update(
      'data',
      dataname.toMap(),
      where: "idx = ?",
      whereArgs: [dataname.idx],
    );
  }

  //db 제거 함수
  Future<void> deleteData(int idx) async {
    // 데이터베이스 reference를 얻습니다.
    final db = await database;

    // 데이터베이스에서 Dog를 삭제합니다.
    await db.delete(
      'data',
      where: "idx = ?",
      whereArgs: [idx],
    );
  }

  //db로부터 데이터를 얻어서 내부 변수로 추출
  List<Dataname> datanames = await data();

  ///*
  //dataclass 적용용 test
  //Generate or Open Database
  final Future<Database> dataclassbase = openDatabase(
    join(await getDatabasesPath(), 'datanameclass.db'),
    onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE data(idx INTEGER PRIMARY KEY, name TEXT)",
      );
    },
    version: 1,
  );
  print("done");

  //Function : insert Dataclass into DB
  Future<void> insertDataclass(Dataclass dataclass) async {

    final Database db = await database;

    await db.insert(
      'data',
      dataclass.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  //dataclass(dataname) 의 변수를 얻는 함수
  Future<List<Dataclass>> datac() async {
    final Database db = await database;

    final List<Map<String, dynamic>> maps = await db.query('data');

    return List.generate(maps.length, (i) {
      return Dataclass(
        idx: maps[i]['idx'],
        name: maps[i]['name'],
      );
    });
  }

  //db 수정 함수
  Future<void> updateDataclass(Dataclass dataclass) async {
    final db = await database;

    await db.update(
      'data',
      dataclass.toMap(),
      where: "idx = ?",
      whereArgs: [dataclass.idx],
    );
  }

  //db 제거 함수
  Future<void> deleteDataclass(int idx) async {
    // 데이터베이스 reference를 얻습니다.
    final db = await database;

    // 데이터베이스에서 Dog를 삭제합니다.
    await db.delete(
      'data',
      where: "idx = ?",
      whereArgs: [idx],
    );
  }

   //*/



  //db insert test
  final testdata = Dataname(
    idx: 0,
    name: "Junghyun",
  );
  await insertData(testdata);

  //db update

  await updateDataname(Dataname(
    idx: 0,
    name: "YeWon",

  ));

  //db check test
  datanames = await data();
  //print("${datanames[0].name},${datanames[0].idx}");


  //dataclass용 test
  /*
  for(int i=0;i<dataclass.length;i++){
    dataclass[i].idx = i;

    await insertDataclass(dataclass[i]);
  }

   */

  List<Dataclass> dataclasss = await datac();
  print("start");
  for(int i=0;i<dataclasss.length;i++){
    print("${dataclasss[i].idx}:${dataclasss[i].name}");
  }







}



class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<Dataclass> dataclass = [];

  getDataFromSheet() async{
    var raw = await http.get(Uri.parse("https://script.google.com/macros/s/AKfycby0aVRkupDPMY_9IQTyzSweHM4fhiRLzEMjccNABoC5EVTq2Ik/exec"));

    var jsonData = convert.jsonDecode(raw.body);

    jsonData.forEach((element) {
      //print('$element');
      Dataclass data = new Dataclass();
      data.curriculum_division = element['교과구분'];
      data.department = element['개설대학'];
      data.major = element['개설학과'];
      data.comple_course = element['이수과정'];
      data.grade = element['학년'];
      data.class_number = element['교과목번호'];
      data.lecture_number = element['강좌번호'];
      data.name = element['교과목명'];
      data.credit = element['학점'];
      data.lecture_credit = element['강의'];
      data.experiment_credit = element['실습'];
      data.time = element['수업교시'];
      data.type = element['수업형태'];
      data.n14 = element['강의실'];
      data.professor = element['담당교수'];
      data.capacity = element['정원'];
      data.note = element['비고'];
      data.language = element['강의언어'];

      dataclass.add(data);
      //print('length of DATAS : ${dataclass.length}');
    });
    //print('${dataclass[8075].time}');
    //print('${dataclass[8075].time!.indexOf('~')}');
    double temp = double.tryParse(dataclass[8075].time!.substring(2,4))!;
    temp += double.tryParse(dataclass[8075].time!.substring(5,7))!/60;
    //print('$temp');

    PreProcessingData();
    SaveData();

/*
    var tempa = SearchingBuilding("301");
    for(int i=0;i<tempa.length;i++){
      print("${tempa[i]}");
    }

 */
  }

  PreProcessingData(){
    for(int i = 0 ; i<dataclass.length ; i++)
    {
      //수업 교시 전처리
      int NumOfSlash_time = 0;
      List<LectureTime> lecturetime = [];

      if(dataclass[i].time != '^^^'){
        for(int j = 0 ; j<dataclass[i].time!.length ; j++)
        {
          if(dataclass[i].time![j]=='/')
          {
            NumOfSlash_time++;
          }
        }

        for(int j = 0 ; j<NumOfSlash_time+1 ; j++)
        {
          LectureTime newlecturetime = new LectureTime();
          newlecturetime.day=999;
          newlecturetime.StartTime=999;
          newlecturetime.EndTime=999;


          //day 지정
          switch(dataclass[i].time![15*j])
              {
            case '월':
              newlecturetime.day = 1;
              break;
            case '화':
              newlecturetime.day = 2;
              break;
            case '수':
              newlecturetime.day = 3;
              break;
            case '목':
              newlecturetime.day = 4;
              break;
            case '금':
              newlecturetime.day = 5;
              break;
            case '토':
              newlecturetime.day = 6;
              break;
            case '일':
              newlecturetime.day = 0;
              break;
          }
          //StartTime 지정
          double temp = double.tryParse(dataclass[i].time!.substring(2+15*j,4+15*j))!;
          double temp_end = double.tryParse(dataclass[i].time!.substring(5+15*j,7+15*j))!/60;
          if(temp_end>=0.15 && temp_end<=0.5)
          {
            temp_end=0.5;
          }
          if(temp_end>=0.65 && temp_end<=0.99)
          {
            temp_end=1;
          }
          temp+=temp_end;

          double new_temp=0;
          new_temp=2*temp-17;

          newlecturetime.StartTime=new_temp;
          //EndTime 지정
          temp=0;
          temp_end=0;
          temp = double.tryParse(dataclass[i].time!.substring(8+15*j,10+15*j))!;
          temp_end = double.tryParse(dataclass[i].time!.substring(11+15*j,13+15*j))!/60;
          if(temp_end>=0.15 && temp_end<=0.5)
          {
            temp_end=0.5;
          }
          if(temp_end>=0.65 && temp_end<=0.99)
          {
            temp_end=1;
          }
          temp+=temp_end;

          new_temp=0;
          new_temp=2*temp-17;


          newlecturetime.EndTime=new_temp;

          lecturetime.add(newlecturetime);
        }
      }
      else{
        LectureTime newlecturetime = new LectureTime();
        newlecturetime.day=999;
        newlecturetime.StartTime=999;
        newlecturetime.EndTime=999;
        lecturetime.add(newlecturetime);
      }

      dataclass[i].lecture_time = lecturetime;
      //print('${dataclass[i].lecture_time![0].StartTime!}');
    }

    //강의동 전처리

    for(int i = 0 ; i<dataclass.length ; i++)
    {
      int NumOfSlash_time = 0;
      List<int> SlashIndex = List.generate(10, (index) => 0);
      List<String> SlicedString = List.generate(10, (index) => "0");
      if (dataclass[i].n14![0]=='/' || dataclass[i].n14![0]=='*') {
        dataclass[i].n14 = dataclass[i].n14!.substring(1);
      }
      if (dataclass[i].n14![dataclass[i].n14!.length-1]=='/') {
        dataclass[i].n14 = dataclass[i].n14!.substring(0,dataclass[i].n14!.length-1);
      }
      for(int j = 0 ; j<dataclass[i].n14!.length ; j++) {

        if (dataclass[i].n14![j] == '/') {
          NumOfSlash_time++;
          SlashIndex[NumOfSlash_time]=j;
        }
      }
      if(NumOfSlash_time>0) {
        for (int k = 0; k <= NumOfSlash_time; k++) {
          if (k == 0) {
            SlicedString[k] = dataclass[i].n14!.substring(0, SlashIndex[k + 1]);
          }
          else if (k == NumOfSlash_time) {
            SlicedString[k] = dataclass[i].n14!.substring(SlashIndex[k] + 1);
          }
          else {
            SlicedString[k] = dataclass[i].n14!.substring(
                SlashIndex[k] + 1, SlashIndex[k + 1]);
          }
          //print("${SlicedString[k]}");
        }
        var temp = '0';
        bool coincidence = true;

        int idx = SlicedString[0].indexOf("-");
        temp = SlicedString[0].substring(0, idx);

        for(int l=1;l<=NumOfSlash_time;l++){
          int idx_new = SlicedString[l].indexOf("-");
          var temp_new = SlicedString[l].substring(0,idx_new);
          //print("${temp_new}");
          if(temp_new != temp){
            coincidence = false;
          }
          temp=temp_new;
          idx=idx_new;
          //print("${coincidence}");
        }

      }


      print("${dataclass[i].n14}");

      if(NumOfSlash_time==0) {
        int NumOfHyphen = 0;
        List<int> HyphenIndex = List.generate(10, (index) => 0);
        for (int j = 0; j < dataclass[i].n14!.length; j++) {
          if (dataclass[i].n14![j] == '-') {
            NumOfHyphen++;
            HyphenIndex[NumOfHyphen] = j;
          }
        }
        if (NumOfHyphen == 1) {
          var temp_building = dataclass[i].n14!.substring(0, HyphenIndex[1]);
          var temp_room = dataclass[i].n14!.substring(HyphenIndex[1] + 1);
          LectureBR temp_lecturebr = new LectureBR();
          temp_lecturebr.Building = temp_building;
          temp_lecturebr.Room = temp_room;
          dataclass[i].lecture_buildingroom=[];
          dataclass[i].lecture_buildingroom!.add(temp_lecturebr);
          //print("${dataclass[i].lecture_buildingroom![0].Building}");
        }



      }







    }


    print("${dataclass.length}");
    //수업 교시 전처리
  }

  SearchingNameData(String info){
    List<int> coincidence = [];
    for (int i=0; i<dataclass.length;i++){
      var haystack_size = dataclass[i].name!.length;
      var needle_size = info.length;
      for(int j=0;j<haystack_size - needle_size;++j){
        int k=0;
        for(k=0;k<needle_size;++k){
          if(dataclass[i].name![j+k] == info[k]){
            continue;
          }
          break;
        }
        if(k==needle_size){
          coincidence.add(i);
        }
      }
    }
    return coincidence;
  }

  SearchingBuilding(String info){
    List<int> coincidence = [];
    for (int i=0; i<dataclass.length;i++){

      if(dataclass[i].lecture_buildingroom!= null)
      {
        for(int j=0; j<dataclass[i].lecture_buildingroom!.length; j++) {
          var haystack_size = dataclass[i].lecture_buildingroom![j].Building!.length;
          var needle_size = info.length;
          for (int l = 0; l < haystack_size - needle_size; ++l) {
            int k = 0;
            for (k = 0; k < needle_size; ++k) {
              if (dataclass[i].lecture_buildingroom![j].Building![l + k]== info[k]) {
                continue;
              }
              break;
            }
            if (k == needle_size) {
              coincidence.add(i);
            }
          }
        }
      }

    }
    return coincidence;
  }

  SaveData() async{
    final Future<Database> database = openDatabase(
      join(await getDatabasesPath(), 'assets/data/dogs.db'),
      onCreate: (db, version) {
        return db.execute(
        "CREATE TABLE dogs(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)",
        );
      },
    version: 1,
    );
    print("done");
  }

  @override

  void initState(){
    super.initState();
    getDataFromSheet();



  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Students"),
        elevation: 0,
      ),
      body: Container(

      ),
    );
  }
}