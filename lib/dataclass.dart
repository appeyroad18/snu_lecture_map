class LectureTime{
  int? day;
  double? StartTime;
  double? EndTime;
}

class LectureBR{
  String? Building;
  String? Room;
}


class Dataclass {
  String? n1;
  String? n2;
  String? n3;
  String? n4;
  String? n5;
  String? n6;
  String? n7;
  String? n8;
  String? n9;
  String? n10;
  String? n11;
  String? n12;
  String? n13;
  String? n14;
  String? n15;
  String? n16;
  String? n17;
  String? n18;
  List<LectureTime>? lecture_time;
  List<LectureBR>? lecture_br;


  Dataclass({this.n1,this.n2,this.n3,this.n4,this.n5,this.n6,this.n7,this.n8,this.n9,
    this.n10,this.n11,this.n12,this.n13,this.n14,this.n15,this.n16,this.n17,this.n18,});

  factory Dataclass.fromJson(dynamic json){
    return Dataclass(
      n1: "${json['교과구분']}",
      n2: "${json['개설대학']}",
      n3: "${json['개설학과']}",
      n4: "${json['이수과정']}",
      n5: "${json['학년']}",
      n6: "${json['교과목번호']}",
      n7: "${json['강좌번호']}",
      n8: "${json['교과목명']}",
      n9: "${json['학점']}",
      n10: "${json['강의']}",
      n11: "${json['실습']}",
      n12: "${json['수업교시']}",
      n13: "${json['수업형태']}",
      n14: "${json['강의실']}",
      n15: "${json['담당교수']}",
      n16: "${json['정원']}",
      n17: "${json['비고']}",
      n18: "${json['강의언어']}",



    );
  }

  Map toJson() => {
    "교과구분": n1,
    "개설대학": n2,
    "개설학과": n3,
    "이수과정": n4,
    "학년": n5,
    "교과목번호": n6,
    "강좌번호": n7,
    "교과목명": n8,
    "학점": n9,
    "강의": n10,
    "실습": n11,
    "수업교시": n12,
    "수업형태": n13,
    "강의실": n14,
    "담당교수": n15,
    "정원":n16,
    "비고":n17,
    "강의언어":n18,
  };
}