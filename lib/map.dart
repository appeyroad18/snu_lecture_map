import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photo_view/photo_view.dart';
import 'package:flutter/animation.dart';
import 'package:provider/provider.dart';

//test1

//for saving current screen number
class CurrentScreenNumber{
  int? currentNum;
  CurrentScreenNumber({this.currentNum});

  void changeCurrentNum(int changeTo){
    this.currentNum = changeTo;
  }
}

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> with SingleTickerProviderStateMixin {
  bool _showInfo = false;
  int? _buildingNum;
  @override
  Widget build(BuildContext context) {
    final double _width = MediaQuery.of(context).size.width;
    final double _height = MediaQuery.of(context).size.height;
    //Showing showInfo = Provider.of<Showing>(context);

    return Align(
          alignment: Alignment.topCenter,
          child: Container(
              height : _height - 50,
              width: _width,
              child: Stack(
                  children: [
                    GestureDetector(
                      onDoubleTap: (){
                        setState(() {
                          Transform.scale(scale: 2);
                        });
                      },
                      child: PhotoView.customChild(
                        child: Stack(
                            children: [
                              MapContainer(
                                imagePath: "assets/images/snumap.jpg",
                              ),
                              GestureDetector(
                                child: Buildings(),
                                onTap: (){
                                  setState(() {
                                    _showInfo = !_showInfo;
                                  });
                                },),
                            ]
                        ),
                        backgroundDecoration: BoxDecoration(color: Colors.white10),
                        minScale: PhotoViewComputedScale.contained * 1,
                        maxScale: PhotoViewComputedScale.covered * 3.5,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: AnimatedSize(
                        vsync: this,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOutCubic,
                        child: Container(
                          height: _showInfo ? 150 : 0,
                          child: Stack(
                              children: [
                                Infobox(),
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.arrow_back),
                                        onPressed: (){
                                          setState(() {
                                            //Showing();
                                            _showInfo = !_showInfo;
                                          });
                                        },
                                      ),
                                      Container(
                                        height: 100,
                                        width: 1,
                                      ),
                                    ]
                                  )
                                )
                              ]
                          ),
                        ),
                      ),
                    ),
                  ]
              ),
            ),
    );
  }
}

//modify this class
class MapContainer extends StatelessWidget {

  final Widget? child;
  final String imagePath;

  MapContainer({this.child, required this.imagePath, Key? key}) : super(key: key);

  //const MapBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screen_height = MediaQuery.of(context).size.height - 50;
    double screen_width = MediaQuery.of(context).size.width;
    //number of pixel of snu map image
    double image_height = 3508;
    double image_width = 2481;

    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: (image_height/screen_height < image_width/screen_width) ?
            BoxFit.fitWidth : BoxFit.fitHeight,
          )
      ),
      child: child,
    );
  }
}

class Buildings extends StatefulWidget {
  Buildings({Key? key}) : super(key: key);

  @override
  _BuildingsState createState() => _BuildingsState();
}

class _BuildingsState extends State<Buildings> {
  List<double> axis_x = <double>[0.37, 0.365];
  List<double> axis_y = <double>[-0.51, -0.578];
  int? buildingNumber;
  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          Align(
            alignment: Alignment(axis_x[0], axis_y[0]),
            child: Container(
              width: 10,
              height: 10,
              color: Color.fromRGBO(80, 176, 209, 100),
            ),
          ),
          Align(
            alignment: Alignment(axis_x[1], axis_y[1]),
            child: Container(
              width: 10,
              height: 10,
              color: Color.fromRGBO(80, 176, 209, 100),
            ),
          ),
        ]
    );
  }
}

class Showing extends ChangeNotifier {
  bool _showInfo = false;
  bool getShowInfo() => _showInfo;

  void chgState(){
    _showInfo = !_showInfo;
    notifyListeners();
  }
}


class Building301 extends StatefulWidget {
  const Building301({Key? key}) : super(key: key);

  @override
  _Building301State createState() => _Building301State();
}

class _Building301State extends State<Building301> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}


class Infobox extends StatefulWidget {
  const Infobox({Key? key}) : super(key: key);

  @override
  _InfoboxState createState() => _InfoboxState();
}

class _InfoboxState extends State<Infobox> {
  bool _showResMenu = false;
  bool _showLectures = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: Visibility(
            visible: _showResMenu,
            child: GestureDetector(
              child: Container(
                height: 980,
                width: 500,
                color: Color.fromRGBO(100, 100, 100, 0),
              ),
              onTap: (){
                setState(() {
                  _showResMenu = !_showResMenu;
                });
              },
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.blueGrey,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child:
                    //Visibility(
                    //  visible: ,
                    //  child:
                        Column(
                        children: [
                          Text("301동", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                          Text("(기계공학, 항공우주, 컴퓨터공학, 전기정보)", style: TextStyle(fontSize: 15),),
                          Expanded(child: Container()),
                        ],
                      ),
                    ),
                  //),
                  Align(
                    alignment: Alignment.center,
                    child:
                    //Visibility(
                     // visible: ,
                     // child:
                      Column(
                        children: [
                          Text("301동", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                          Text("(기계공학, 항공우주, 컴퓨터공학, 전기정보)", style: TextStyle(fontSize: 15),),
                          Expanded(child: Container()),
                        ],
                      ),
                    ),
                  //)
                  Align(
                    alignment: Alignment.bottomRight,
                    child: RaisedButton(
                      onPressed: () {
                        setState(() {
                          _showLectures = !_showLectures;
                        });
                      },
                      child: Text("강의 보기"),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Expanded(child: Container()),
                            IconButton(
                              icon: Icon(Icons.restaurant_rounded),
                              onPressed: (){
                                setState(() {
                                  _showResMenu = !_showResMenu;
                                });
                              },
                            ),
                          ],
                        ),
                        Visibility(
                          visible: _showResMenu,
                          child:
                          ResMenuBox(),

                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Visibility(
              visible: _showLectures,
              child: ShowLectures()),
        ),
      ],
    );
  }
}

class ResMenuBox extends StatefulWidget {
  const ResMenuBox({Key? key}) : super(key: key);

  @override
  _ResMenuBoxState createState() => _ResMenuBoxState();
}

class _ResMenuBoxState extends State<ResMenuBox> {
  @override
  Widget build(BuildContext context) {
    return
      Container(
        height: 90,
        margin: EdgeInsets.only(left: 10, right: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(const Radius.circular(5)),
        ),
      );
  }
}

class ShowLectures extends StatefulWidget {
  const ShowLectures({Key? key}) : super(key: key);

  @override
  _ShowLecturesState createState() => _ShowLecturesState();
}

class _ShowLecturesState extends State<ShowLectures> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 20, 20, 50),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: const BorderRadius.all(const Radius.circular(5)),
      ),
      child: Stack(
        children: [

        ],
      ),
    );
  }
}
