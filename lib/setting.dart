import 'package:flutter/material.dart';
import 'dart:math';

class SettingScreen extends StatefulWidget {
  double bottomBarHeight;
  double appBarHeight;

  SettingScreen({Key? key, required this.bottomBarHeight, required this.appBarHeight}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool containerVisible = true;
  List<Color> _containerColorList = [Colors.red, Colors.green, Colors.blue, Colors.orange, Colors.brown, Colors.yellow];
  int colorNum = 0;
  void containerinvert(){
    setState(() {
      // containerVisible = !containerVisible;
      colorNum = Random().nextInt(_containerColorList.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    double _currentScreenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Visibility(
              visible: containerVisible,
              child: Container(
                height: _currentScreenHeight - widget.appBarHeight - widget.bottomBarHeight - 50,
                width: 50,
                color: _containerColorList[colorNum],
              ),
            ),
            TempButton(inFunction: containerinvert,),
          ],
        ),
      ),
    );
  }
}

class TempButton extends StatelessWidget {
  Function inFunction;
  TempButton({Key? key, required this.inFunction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 50,
        width: 100,
        child: Text("This is Button"),
      ),
      onTap: (){
        inFunction();
      },
    );
  }
}
