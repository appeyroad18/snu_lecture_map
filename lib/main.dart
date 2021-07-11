import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:matrix_gesture_detector/matrix_gesture_detector.dart';
import 'timetable.dart';

///global variable
class CurrentScreenNumber{
  int? currentNum;
  CurrentScreenNumber({this.currentNum});

  void changeCurrentNum(int changeTo){
    this.currentNum = changeTo;
  }
}

final int content_num = 4;
///

void main(){
  runApp(SNUMap());
}

class SNUMap extends StatelessWidget {
  const SNUMap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SNUMap',
      theme: ThemeData(
        textTheme: Theme.of(context).textTheme.apply(
          bodyColor: Colors.black,
          displayColor: Colors.blue,
        )
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Matrix4 transform_matrix = Matrix4.identity();
  CurrentScreenNumber csn = CurrentScreenNumber(currentNum: 0);
  //Matrix4 resetmatrix = Matrix4.identity();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Visibility(
            visible: csn.currentNum == 0,
            child: Center(
              child: GestureDetector(
                onDoubleTap: (){
                  setState(() {
                    transform_matrix = Matrix4.identity();
                  });
                },
                child: MatrixGestureDetector(
                  shouldRotate: true,
                  shouldScale: true,
                  shouldTranslate: true,
                  onMatrixUpdate: (Matrix4 matrix, Matrix4 translationMatrix, Matrix4 scaleMatrix, Matrix4 rotationMatrix){
                    setState(() {
                      transform_matrix = MatrixGestureDetector.compose(matrix, translationMatrix, scaleMatrix, rotationMatrix);
                    });
                  },
                  child: Transform(
                    transform: transform_matrix,
                    child: MapContainer(
                      imagePath: 'assets/images/snumap.jpg',
                    ),
                  ),
                ),
              ),
            ),
          ),
          Visibility(
            visible: csn.currentNum==1,
            child: TimeTable(),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 50,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  BottomButton(button_pos: 0, content: '지도', csn: csn,),
                  BottomButton(button_pos: 1, content: '검색', csn: csn,),
                  BottomButton(button_pos: 2, content: '내 강의', csn: csn,),
                  BottomButton(button_pos: 3, content: '설정', csn: csn,),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}



class BottomButton extends StatefulWidget {
  int button_pos;
  String content;
  CurrentScreenNumber csn;
  BottomButton({Key? key, required this.button_pos, required this.content, required this.csn}) : super(key: key);

  @override
  _BottomButtonState createState() => _BottomButtonState();
}

class _BottomButtonState extends State<BottomButton> {
  @override
  Widget build(BuildContext context) {
    double screen_width = MediaQuery.of(context).size.width;

    return FlatButton(
      onPressed: (){
        if(widget.csn.currentNum != widget.button_pos){
          setState(() {
            widget.csn.changeCurrentNum(widget.button_pos);
            print(widget.csn.currentNum);
          });
        }
      },
      child: Text(widget.content),
      minWidth: screen_width/content_num,
      color: Colors.blue,
      height: 50,
    );
  }
}

class MapContainer extends StatelessWidget {

  final Widget? child;
  final String imagePath;

  MapContainer({this.child, required this.imagePath, Key? key}) : super(key: key);

  //const MapBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screen_height = MediaQuery.of(context).size.height;
    double screen_width = MediaQuery.of(context).size.width;
    //number of pixel of snu map image
    double image_height = 3508;
    double image_width = 2481;

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: image_height/screen_height < image_width/screen_width?
            BoxFit.fitWidth : BoxFit.fitHeight,
        )
      ),
      child: child,
    );
  }
}
