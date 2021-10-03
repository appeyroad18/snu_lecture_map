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
    print('${dataclass[8075].time}');
    print('${dataclass[8075].time!.indexOf('~')}');
    double temp = double.tryParse(dataclass[8075].time!.substring(2,4))!;
    temp += double.tryParse(dataclass[8075].time!.substring(5,7))!/60;
    print('$temp');

    PreProcessingData();
    SaveData();


    var tempa = SearchingBuilding("301");
    for(int i=0;i<tempa.length;i++){
      print("${tempa[i]}");
    }
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
          temp += double.tryParse(dataclass[i].time!.substring(5+15*j,7+15*j))!/60;
          newlecturetime.StartTime=temp;
          //EndTime 지정
          temp=0;
          temp = double.tryParse(dataclass[i].time!.substring(8+15*j,10+15*j))!;
          temp += double.tryParse(dataclass[i].time!.substring(11+15*j,13+15*j))!/60;
          newlecturetime.EndTime=temp;

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
          print("${dataclass[i].lecture_buildingroom![0].Building}");
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
          for (int l = 0; l < haystack_size - needle_size; ++j) {
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
      join(await getDatabasesPath(), 'data.db'),
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