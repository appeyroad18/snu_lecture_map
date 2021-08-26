import 'package:flutter/material.dart';
import 'package:snu_lecture_map/dataclass.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

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
      data.n1 = element['교과구분'];
      data.n2 = element['개설대학'];
      data.n3 = element['개설학과'];
      data.n4 = element['이수과정'];
      data.n5 = element['학년'];
      data.n6 = element['교과목번호'];
      data.n7 = element['강좌번호'];
      data.n8 = element['교과목명'];
      data.n9 = element['학점'];
      data.n10 = element['강의'];
      data.n11 = element['실습'];
      data.n12 = element['수업교시'];
      data.n13 = element['수업형태'];
      data.n14 = element['강의실'];
      data.n15 = element['담당교수'];
      data.n16 = element['정원'];
      data.n17 = element['비고'];
      data.n18 = element['강의언어'];

      dataclass.add(data);
      //print('length of DATAS : ${dataclass.length}');
    });
    print('${dataclass[8075].n12}');
    print('${dataclass[8075].n12!.indexOf('~')}');
    double temp = double.tryParse(dataclass[8075].n12!.substring(2,4))!;
    temp += double.tryParse(dataclass[8075].n12!.substring(5,7))!/60;
    print('$temp');
    PreProcessingData();

    var tempa = SearchingNameData("경제");
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

      if(dataclass[i].n12 != '^^^'){
        for(int j = 0 ; j<dataclass[i].n12!.length ; j++)
        {
          if(dataclass[i].n12![j]=='/')
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
          switch(dataclass[i].n12![15*j])
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
          double temp = double.tryParse(dataclass[i].n12!.substring(2+15*j,4+15*j))!;
          temp += double.tryParse(dataclass[i].n12!.substring(5+15*j,7+15*j))!/60;
          newlecturetime.StartTime=temp;
          //EndTime 지정
          temp=0;
          temp = double.tryParse(dataclass[i].n12!.substring(8+15*j,10+15*j))!;
          temp += double.tryParse(dataclass[i].n12!.substring(11+15*j,13+15*j))!/60;
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
      print('${dataclass[i].lecture_time![0].StartTime!}');
    }

    //강의동 전처리
    /*
    for(int i = 0 ; i<dataclass.length ; i++)
    {
      int NumOfSlash_time = 0;
      List<int> SlashIndex = [];
      List<String> SlicedString = List.generate(10, (index) => "0");
      if (dataclass[i].n14![0]=='/' || dataclass[i].n14![0]=='*') {
        dataclass[i].n14 = dataclass[i].n14!.substring(1);
      }
      for(int j = 0 ; j<dataclass[i].n14!.length ; j++) {

        if (dataclass[i].n14![j] == '/') {
          NumOfSlash_time++;
          SlashIndex.add(j);
        }
      }

      if(NumOfSlash_time>0){
        for(int k=0;k<=NumOfSlash_time;k++){
          if(k==0){
            SlicedString[k]=dataclass[i].n14!.substring(0,SlashIndex[k]);
          }
          else if(k==NumOfSlash_time){
            SlicedString[k]=dataclass[i].n14!.substring(SlashIndex[k-1]+1);
          }
          else{
            SlicedString[k]=dataclass[i].n14!.substring(SlashIndex[k-1]+1,SlashIndex[k]);
          }
          print("${SlicedString[k]}");

          var temp = '0';
          bool coincidence = true;

          int idx = SlicedString[0].indexOf("-");
          temp = SlicedString[0].substring(0,idx);
          for(int l=1;l<=NumOfSlash_time;l++){
            int idx_new = SlicedString[l].indexOf("-");
            var temp_new = SlicedString[l].substring(0,idx_new);
            if(temp_new != temp){
              coincidence = false;
              break;
            }
            temp=temp_new;
            idx=idx_new;
          }


         }
      }
      print("${dataclass[i].n14}");
      /*
      else if(NumOfSlash_time==0){
         int NumOfHyphen = 0;
         List<int> HyphenIndex = [];
         for(int j=0;j<=dataclass[i].n14!.length;j++){
           if(dataclass[i].n14![j]=='-'){
             NumOfHyphen++;
             HyphenIndex.add(j);
           }
           if(NumOfHyphen == 1){
             var temp_building = dataclass[i].n14!.substring(0,HyphenIndex[0]);
             var temp_room = dataclass[i].n14!.substring(HyphenIndex[0] + 1);
             LectureBR temp_lecturebr = new LectureBR();
             temp_lecturebr.Building = temp_building;
             temp_lecturebr.Room = temp_room;
             dataclass[i].lecture_br!.add(temp_lecturebr);
             print("${dataclass[i].lecture_br![0].Building}");
           }
         }

      }*/




    }
    */

    print("${dataclass.length}");
    //수업 교시 전처리
  }

  SearchingNameData(String info){
    List<int> coincidence = [];
    for (int i=0; i<dataclass.length;i++){
      var haystack_size = dataclass[i].n8!.length;
      var needle_size = info.length;
      for(int j=0;j<haystack_size - needle_size;++j){
        int k=0;
        for(k=0;k<needle_size;++k){
          if(dataclass[i].n8![j+k] == info[k]){
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


  @override

  void initState(){
    getDataFromSheet();
    super.initState();


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
