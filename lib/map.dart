import 'dart:ffi';
import 'dart:math';

import 'package:snu_lecture_map/search.dart';
import 'package:snu_lecture_map/timetable.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photo_view/photo_view.dart';
import 'package:flutter/animation.dart';
import 'package:provider/provider.dart';

//test1
//for saving current screen number


class CurrentScreenNumber {
  int? currentNum;

  CurrentScreenNumber({this.currentNum});

  void changeCurrentNum(int changeTo) {
    this.currentNum = changeTo;
  }
}


class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen>
    with SingleTickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    final double _width = MediaQuery.of(context).size.width;
    final double _height = MediaQuery.of(context).size.height;
    Showing showing = Provider.of<Showing>(context);

    return Align(
        alignment: Alignment.topCenter,
        child: Container(
          height: _height - 50,
          width: _width,
          child: Stack(children: [
            PhotoView.customChild(
              child: Stack(children: [
                MapContainer(
                  imagePath: "assets/images/snumap.jpg",
                ),
                Buildings(),
              ]),
              backgroundDecoration: BoxDecoration(color: Colors.white10),
              minScale: PhotoViewComputedScale.contained * 1,
              maxScale: PhotoViewComputedScale.covered * 3.5,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: AnimatedSize(
                vsync: this,
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOutCubic,
                child: ChangeNotifierProvider(
                  create: (BuildContext context) => Showing(),
                  child: Container(
                    height: showing.showInfo.isNotEmpty ? 150 : 0,
                    child: Stack(
                        children: [
                          Infobox(buildingnum: showing._buildingNum, showingmenu: showing._showMenu,),
                          Align(
                            alignment: Alignment.topLeft,
                            child: IconButton(
                                icon: Icon(Icons.arrow_back),
                                padding: EdgeInsets.all(17),
                                onPressed: () {
                                  setState(() {
                                    showing.showingOff();
                                  });
                                  print(showing._showInfo);
                                }),
                          ),
                        ]),
                  ),
                ),
              ),
            ),
            // ChangeNotifierProvider(
            //   create: (BuildContext context) => Showing(),
            //   child: Visibility(
            //       visible: showing._showLectures,
            //       child: SearchScreen()),
            // )
          ]),
        ),
    );
  }
}

//modify this class
class MapContainer extends StatelessWidget {
  final Widget? child;
  final String imagePath;

  MapContainer({this.child, required this.imagePath, Key? key})
      : super(key: key);

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
        fit: (image_height / screen_height < image_width / screen_width)
            ? BoxFit.fitWidth
            : BoxFit.fitHeight,
      )),
      child: Center(
        child: Container(
          height: (image_height / screen_height < image_width / screen_width)
              ? screen_width * image_height / image_width
              : screen_height,
          width: (image_height / screen_height < image_width / screen_width)
              ? screen_width
              : screen_height * image_width / image_height,
          //color: Colors.black54,
          child: child,
        ),
      ),
    );
  }
}


class BuildingPosition {
  List<double> axis_x = <double>[0.345, 0.37, 0.365, 0.52, 0.45, 0.445, 0.44, 0.40, 0.575];
  List<double> axis_y = <double>[-0.6, -0.705, -0.795, -0.805, -0.778, -0.615, -0.585, -0.55, -0.905];
  List<String> buildingNumber = ["300", "301", "302", "310", "311", "312", "313", "314", "316"];
  List<int> menuExist = [1, 1, 1, 1, 0, 0, 0, 0, 0];
}

// Map<String, double> buildingXAxis = {"1": 0.39, "2": 0.33, "300": 0.345, "301": 0.37};
// Map<String, double> buildingYAxis = {"1": 0.205, "2": 0.215, "300": -0.6, "301": -0.705};


class Buildings extends StatefulWidget {
  Buildings({Key? key}) : super(key: key);

  @override
  _BuildingsState createState() => _BuildingsState();
}

class _BuildingsState extends State<Buildings> {

  @override
  Widget build(BuildContext context) {
    double screen_height = MediaQuery.of(context).size.height - 50;
    double screen_width = MediaQuery.of(context).size.width;
    //number of pixel of snu map image
    double image_height = 3508;
    double image_width = 2481;
    // List<String> bn = ["301"];
    Showing showing = Provider.of<Showing>(context);
    return Center(
      child: Container(
        height: (image_height / screen_height < image_width / screen_width)
            ? screen_width * image_height / image_width
            : screen_height,
        width: (image_height / screen_height < image_width / screen_width)
            ? screen_width
            : screen_height * image_width / image_height,
        child: Stack(children: [
          for (int i = 0; i<BuildingPosition().axis_x.length; i++)
          GestureDetector(
            onTap: () {
              setState(() {
                if (!showing._showInfo.remove(i)) {
                  showing.showingOn(i);
                  showing.showingMenu(BuildingPosition().menuExist[i]);
                } else {
                  showing.showingOff();
                }
                showing.currentBuildingNum(BuildingPosition().buildingNumber[i]);
              });
              print(showing._showInfo);
              print(showing._buildingNum);
              print(BuildingPosition().axis_x[i]);
              print(BuildingPosition().axis_y[i]);
              print(showing._showMenu);
            },
            child: Align(
              alignment: Alignment(BuildingPosition().axis_x[i], BuildingPosition().axis_y[i]),
              child: Container(
                width: 10,
                height: 10,
                color: Color.fromRGBO(80, 176, 209, 100),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}


class Showing with ChangeNotifier {
  List<int> _showInfo = [];
  String _buildingNum = "0";
  int _showMenu = 0;
  bool _showLectures = false;

  get showInfo => _showInfo;

  showingOn(int i) {
    _showInfo.clear();
    _showInfo.add(i);
    notifyListeners();
  }

  showingOff() {
    _showInfo.clear();
    notifyListeners();
  }

  currentBuildingNum(String bn) {
    this._buildingNum = bn;
    notifyListeners();
  }

  showingMenu(int i) {
    this._showMenu = i;
    notifyListeners();
  }
}


class Infobox extends StatefulWidget {
  String buildingnum;
  int showingmenu;
  Infobox({required this.buildingnum, required this.showingmenu, Key? key}) : super(key: key);

  @override
  _InfoboxState createState() => _InfoboxState();
}

class _InfoboxState extends State<Infobox> {
  bool _showResMenu = false;
  //bool _showLectures = false;


  @override
  Widget build(BuildContext context) {
    Showing showing = Provider.of<Showing>(context);
    return Stack(
        children: [
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
                         child: BuildingInfo(buildingnumber: widget.buildingnum,)
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: RaisedButton(
                        onPressed: () {
                          setState(() {
                            // showing._showLectures = !showing._showLectures;
                            // Navigator.push(context,
                            // MaterialPageRoute(builder: (context) => SearchLecture()));
                            showSearch(context: context, delegate: DataSearch(), query: widget.buildingnum);
                          });
                        },
                        child: Text("강의 보기"),
                      ),
                    ),
                    Visibility(
                      visible: widget.showingmenu == 1,
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: [
                                Expanded(child: Container()),
                                IconButton(
                                  icon: Icon(Icons.restaurant_rounded),
                                  onPressed: () {
                                    setState(() {
                                      _showResMenu = !_showResMenu;
                                    });
                                  },
                                ),
                              ],
                            ),
                            Visibility(
                              visible: _showResMenu,
                              child: ResMenuBox(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          /*Align(
            alignment: Alignment.topCenter,
            child: */
            //Visibility(visible: showing._showLectures, child: SearchScreen()),
          //),
        ],
     // ),
    );
  }
}

class BuildingInfo extends StatefulWidget {
  String buildingnumber;
  BuildingInfo({required this.buildingnumber, Key? key}) : super(key: key);

  @override
  _BuildingInfoState createState() => _BuildingInfoState();
}

class _BuildingInfoState extends State<BuildingInfo> {
  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          Visibility(
            visible: widget.buildingnumber == "300",
            child: Center(
              child: Column(
                children: [
                  Text("300동 - 공과대학", style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),),
                  Text("유회진학술정보관",
                    style: TextStyle(fontSize: 15),),
                ],
              ),
            ),
          ),
          Visibility(
            visible: widget.buildingnumber == "301",
            child: Center(
              child: Column(
                children: [
                  Text("301동 - 제 1공학관", style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),),
                  Text("기계공학, 항공우주, 컴퓨터공학, 전기정보",
                    style: TextStyle(fontSize: 15),),
                ],
              ),
            ),
          ),
          Visibility(
            visible: widget.buildingnumber == "302",
            child: Center(
              child: Column(
                children: [
                  Text("302동 - 제 2공학관", style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),),
                  Text("화학생명공학",
                    style: TextStyle(fontSize: 15),),
                ],
              ),
            ),
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
    return Container(
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
        children: [],
      ),
    );
  }
}


class SearchLecture extends StatelessWidget {
  const SearchLecture({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
