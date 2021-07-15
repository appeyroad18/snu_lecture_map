import 'package:flutter/material.dart';
import 'package:matrix_gesture_detector/matrix_gesture_detector.dart';

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
  Matrix4 transform_matrix = Matrix4.identity();
  CurrentScreenNumber csn = CurrentScreenNumber(currentNum: 0);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double _duration = 0.5;
    return Center(
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
                transform_matrix = MatrixGestureDetector.compose(transform_matrix, translationMatrix, scaleMatrix, rotationMatrix);
                double _scale = scaleMatrix[0];
                if (_scale < 1){
                  transform_matrix[0] = 1;
                  transform_matrix[5] = 1;
                }
                if (transform_matrix[13] < -height*(1-1/_scale)){
                  transform_matrix[13] = -height*(1-1/_scale);
                }
                else if (transform_matrix[13] > height*(1-1/_scale)){
                  transform_matrix[13] = height*(1-1/_scale);
                }
                else if (transform_matrix[12] < -width*(1-1/_scale)){
                  transform_matrix[12] = -width*(1-1/_scale);
                }
                else if (transform_matrix[12] > width*(1-1/_scale)){
                  transform_matrix[12] = width*(1-1/_scale);
                }
              });
              print(transform_matrix);
            },
            child: Transform(
              transform: transform_matrix,
              child: MapContainer(
                imagePath: 'assets/images/snumap.jpg',
              ),
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
    double screen_height = MediaQuery.of(context).size.height;
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