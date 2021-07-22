import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

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

class _MapScreenState extends State<MapScreen> {
  bool _showInfo = false;
  @override
  Widget build(BuildContext context) {
     final double _width = MediaQuery.of(context).size.width;
     final double _height = MediaQuery.of(context).size.height;

     // child: AnimatedBuilder(
     //   animation: _controller,
     //   child: GestureDetector(
     //     onDoubleTap: (){
     //       setState(() {
     //         transform_matrix = Matrix4.identity();
     //       });
     //     },
     //     child: MatrixGestureDetector(
     //       shouldRotate: true,
     //       shouldScale: true,
     //       shouldTranslate: true,
     //       onMatrixUpdate: (Matrix4 matrix, Matrix4 translationMatrix, Matrix4 scaleMatrix, Matrix4 rotationMatrix){
     //         setState(() {
     //           double _scale = 2;
     //           scaleMatrix[0] = 2;
     //           scaleMatrix[5] = 2;
     //           if (translationMatrix[13] > 935*(1-1/_scale)){
     //             translationMatrix[13] = 935*(1-1/_scale);
     //           }
     //           transform_matrix = MatrixGestureDetector.compose(transform_matrix, translationMatrix, scaleMatrix, rotationMatrix);
     //   double _scale = scaleMatrix[0];
     //   if (_scale < 1){
     //     transform_matrix[0] = 1;
     //     transform_matrix[5] = 1;
     //   }
     //   if (transform_matrix[13] < -height*(1-1/_scale)){
     //     transform_matrix[13] = -height*(1-1/_scale);
     //   }
     //   else if (transform_matrix[13] > height*(1-1/_scale)){
     //     transform_matrix[13] = height*(1-1/_scale);
     //   }
     //   else if (transform_matrix[12] < -width*(1-1/_scale)){
     //     transform_matrix[12] = -width*(1-1/_scale);
     //   }
     //   else if (transform_matrix[12] > width*(1-1/_scale)){
     //     transform_matrix[12] = width*(1-1/_scale);
     //   }
     //   });
     //   print(transform_matrix);
     // },
     // child: Transform(
     //   transform: transform_matrix,

    return Align(
      alignment: Alignment.topCenter,
        child: GestureDetector(
          onDoubleTap: (){
            setState(() {
              Transform.scale(scale: 2);
            });
          },
          child: Container(
            height : _height - 50,
            width: _width,
            child: Stack(
              children: [
                PhotoView.customChild(
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
                      Container(
                        margin: EdgeInsets.fromLTRB(200, 200, 0, 0),
                        child: IconButton(
                          icon: Icon(Icons.restaurant_menu),
                          onPressed: (){},
                        ),
                      )
                    ]
                ),
                backgroundDecoration: BoxDecoration(color: Colors.white10),
                minScale: PhotoViewComputedScale.contained * 1,
                maxScale: PhotoViewComputedScale.covered * 3.5,
              ),
              Visibility(
                child: Infobox(),
                visible: _showInfo,
              ),
              ]
            ),
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
  const Buildings({Key? key}) : super(key: key);

  @override
  _BuildingsState createState() => _BuildingsState();
}

class _BuildingsState extends State<Buildings> {
  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          Container(
            width: 10,
            height: 20,
            color: Color.fromRGBO(80, 176, 209, 100),
            margin: EdgeInsets.fromLTRB(262, 180, 0, 0),
          ),
        ]
    );
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
                  Column(
                    children: [
                      Text("301동", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                      Text("(기계공학, 항공우주, 컴퓨터공학, 전기정보)", style: TextStyle(fontSize: 15),),
                      Expanded(child: Container()),
                    ],
                  ),
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
                        AnimatedOpacity(
                          opacity: _showResMenu?1:0,
                          duration: Duration(milliseconds: 300),
                          child: ResMenuBox(),
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
    return Container(
      height: 90,
      margin: EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(const Radius.circular(5)),
      ),
      // child: Padding(
      //   padding: const EdgeInsets.all(10),
      //   child: Align(
      //     alignment: Alignment.,
      //   ),
      // ),
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
