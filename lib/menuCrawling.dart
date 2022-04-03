import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;
import 'package:html_unescape/html_unescape.dart';
import 'package:tuple/tuple.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

String pricePattern = r'[0-9]{0,2}(,?[0-9]*)원$';
RegExp priceRegex = RegExp(pricePattern);

String getToday() {
  DateTime now = DateTime.now();
  DateFormat formatter = DateFormat('yyyy-MM-dd');
  String strToday = formatter.format(now);
  return strToday;
}

class MenuInfo {
  final int? id;
  final String date;
  final String restaurant;
  final String meal;
  final String menuName;
  final String price;
  final String menuType;

  MenuInfo({
    this.id,
    required this.date,
    required this.restaurant,
    required this.meal,
    required this.menuName,
    required this.price,
    required this.menuType,
  });

  factory MenuInfo.fromMap(Map<String, dynamic> json) => new MenuInfo(
      id: json['id'],
      date: json['date'],
      restaurant: json['restaurant'],
      meal: json['meal'],
      menuName: json['menuName'],
      price: json['price'],
      menuType: json['menuType']);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'restaurant': restaurant,
      'meal': meal,
      'menuName': menuName,
      'price': price,
      'menuType': menuType,
    };
  }
}

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'menuInfo.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
      '''
      CREATE TABLE menuInfo(
        id INTEGER PRIMARY KEY,
        date Text,
        restaurant TEXT,
        meal TEXT,
        menuName TEXT,
        price TEXT,
        menuType TEXT
      )
      '''
    );
  }

  Future<List<MenuInfo>> getMenuInfoFromDb() async {
    Database db = await instance.database;
    var menuData = await db.query('menuInfo');
    List<MenuInfo> menuInfoList = menuData.isNotEmpty
      ? menuData.map((e) => MenuInfo.fromMap(e)).toList()
        : [];
    return menuInfoList;
  }

  Future<int> addMenu(MenuInfo menuInfo) async {
    Database db = await instance.database;
    return await db.insert('menuInfo', menuInfo.toMap());
  }

  Future<int> removeAll() async {
    Database db = await instance.database;
    return await db.delete('menuInfo');
  }
}

Tuple2<String, String> menuAndPrice(String menuData) {
  final match = priceRegex.firstMatch(menuData);
  String tempMenuPrice = match!.group(0).toString();
  String tempMenuName = menuData.substring(0, menuData.length - tempMenuPrice.length - 1);
  return new Tuple2(tempMenuName, tempMenuPrice);
}

String removeSpace(String restaurant) {
  return restaurant.replaceAll(' ', '');
}

//rds pwd: snulecturemap!!
Future<void> getMenuInfo() async {
  // List<List<dynamic>> totalMenuData = [];
  // List<MenuInfo> _totalMenuData = [];
  // List<String> rowHeader = ["date", "restaurant", "meal", "menuName", "price", "menuType"];
  //
  // totalMenuData.add(rowHeader);

  var unescape = HtmlUnescape();

  // String date = getToday();
  // int day = date.
  String date = "2022-03-11";
  String snuMenuUrl = 'https://snuco.snu.ac.kr/ko/foodmenu?field_menu_date_value_1%5Bvalue%5D%5Bdate%5D=&field_menu_date_value%5Bvalue%5D%5Bdate%5D=04%2F04%2F2022';
  final http.Response response = await http.get(Uri.parse(snuMenuUrl));
  dom.Document document = parser.parse(response.body);

  document.getElementsByTagName("tr").skip(1)
          .forEach((dom.Element element) async { // 1 element : 1 restaurant
            String restaurant = '';
            String meal = '';

            var elements = element.getElementsByTagName('td'); // elements : rest, breakfast, lunch, dinner
            
            elements.forEach((elem) async {
              var className = elem.className;

              if (className == 'views-field views-field-field-restaurant') {
                restaurant = removeSpace(elem.innerHtml);
                print(restaurant);
              } else if (className == 'views-field views-field-field-breakfast') {
                meal = '아침';
                print(meal);

                if (restaurant.contains('소담마루') || restaurant.contains('라운지오') || restaurant.contains('공대간이식당')) {
                  return;
                }

                var rows = elem.getElementsByTagName('p');
                rows.forEach((e) async {
                  String menuData = unescape.convert(e.innerHtml.toString());
                  
                  if (menuData.contains('운영시간') || menuData.contains('혼잡시간')) {
                    return;
                  }

                  if (menuData.length > 1) {
                    print(menuData);
                    final menuData2 = menuAndPrice(menuData);
                    String menuName = menuData2.item1;
                    String menuPrice = menuData2.item2;
                    print('메뉴: ' + menuName);
                    print('가격: ' + menuPrice);
                    String menuType = '학생';

                    try {
                      await DatabaseHelper.instance.addMenu(
                        MenuInfo(
                          date: date,
                          restaurant: restaurant,
                          meal: meal,
                          menuName: menuName,
                          price: menuPrice,
                          menuType: menuType,
                        ),
                      );
                      // print('data inserted');
                    } catch(err) {
                      print(err);
                    }
                  }
                });
              } else if (className == 'views-field views-field-field-lunch') {
                meal = '점심';
                print(meal);

                if (restaurant.contains('소담마루') || restaurant.contains('라운지오') || restaurant.contains('공대간이식당')) {
                  return;
                }

                var rows = elem.getElementsByTagName('p');

                if (restaurant.contains('두레미담') || restaurant.contains('감골식당')){
                  List menuList = [];

                  String menuData = unescape.convert(rows[0].innerHtml.toString());
                  final menuData2 = menuAndPrice(menuData);
                  String menuName = menuData2.item1;
                  String menuPrice = menuData2.item2;

                  rows.skip(1).forEach((e) {
                    String menuNames = unescape.convert(e.innerHtml.toString());
                    if (menuNames.contains('운영시간') || menuNames.contains('혼잡시간')) {
                      return;
                    } else {
                      menuList.add(menuNames);
                    }
                  });

                  print('메뉴: ' + menuName);
                  print(menuList);
                  print('가격: ' + menuPrice);
                  String menuType = "학생";

                  try {
                    await DatabaseHelper.instance.addMenu(
                      MenuInfo(
                        date: date,
                        restaurant: restaurant,
                        meal: meal,
                        menuName: menuName,
                        price: menuPrice,
                        menuType: menuType,
                      ),
                    );
                    // print('data inserted');
                  } catch(err) {
                    print(err);
                  }
                } else if (restaurant.contains('301동식당')) {
                  rows.length -= 2;
                  rows.forEach((e) async {
                    String menuData = unescape.convert(e.innerHtml.toString());
                    List _menuData = menuData.split('<br>\n');
                    List menuList = _menuData[_menuData.length-1].split(',');

                    final menuData2 = menuAndPrice(_menuData[_menuData.length-2]);
                    String menuName = menuData2.item1;
                    String menuPrice = menuData2.item2;

                    print('메뉴: ' + menuName);
                    print(menuList);
                    print('가격: ' + menuPrice);
                    String menuType = "학생";

                    try {
                      await DatabaseHelper.instance.addMenu(
                        MenuInfo(
                          date: date,
                          restaurant: restaurant,
                          meal: meal,
                          menuName: menuName,
                          price: menuPrice,
                          menuType: menuType,
                        ),
                      );
                      // print('data inserted');
                    } catch(err) {
                      print(err);
                    }
                  });
                } else {
                  rows.forEach((e) async {
                    String menuData = unescape.convert(e.innerHtml.toString());
                    if (menuData.contains('운영시간') || menuData.contains('혼잡시간')) {
                      return;
                    }

                    if (menuData.length > 1){
                      if (menuData.contains('교직원')) {
                        final menuData2 = menuAndPrice(menuData);
                        String menuName = menuData2.item1;
                        String menuPrice = menuData2.item2;
                        print('메뉴: ' + menuName);
                        print('가격: ' + menuPrice);
                        String menuType = "교직";

                        try {
                          await DatabaseHelper.instance.addMenu(
                            MenuInfo(
                              date: date,
                              restaurant: restaurant,
                              meal: meal,
                              menuName: menuName,
                              price: menuPrice,
                              menuType: menuType,
                            ),
                          );
                          // print('data inserted');
                        } catch(err) {
                          print(err);
                        }
                        return;
                      } else if (menuData.contains('교직메뉴')) {
                        String menuType = '교직';
                        print(menuType);
                        return;
                      }
                      List _menuData = menuData.split('<br>\n');
                      print(_menuData);
                      _menuData.forEach((elem) async {
                        if (elem.length <= 1) {
                          return;
                        }
                        final menuData2 = menuAndPrice(elem);
                        String menuName = menuData2.item1;
                        String menuPrice = menuData2.item2;
                        print('메뉴: ' + menuName);
                        print('가격: ' + menuPrice);
                        String menuType = "학생";

                        try {
                          await DatabaseHelper.instance.addMenu(
                            MenuInfo(
                              date: date,
                              restaurant: restaurant,
                              meal: meal,
                              menuName: menuName,
                              price: menuPrice,
                              menuType: menuType,
                            ),
                          );
                          // print('data inserted');
                        } catch(err) {
                          print(err);
                        }
                      });
                    }
                  });
                }

              } else if (className == 'views-field views-field-field-dinner') {
                meal = '저녁';
                print(meal);

                if (restaurant.contains('소담마루') || restaurant.contains('라운지오') || restaurant.contains('공대간이식당')) {
                  return;
                }

                var rows = elem.getElementsByTagName('p');

                if (restaurant.contains('두레미담')){
                  List menuList = [];

                  String menuData = unescape.convert(rows[0].innerHtml.toString());
                  final menuData2 = menuAndPrice(menuData);
                  String menuName = menuData2.item1;
                  String menuPrice = menuData2.item2;

                  rows.skip(1).forEach((e) {
                    String menuNames = unescape.convert(e.innerHtml.toString());
                    if (menuNames.contains('운영시간') || menuNames.contains('혼잡시간')) {
                      return;
                    } else {
                      menuList.add(menuNames);
                    }
                  });

                  print('메뉴: ' + menuName);
                  print(menuList);
                  print('가격: ' + menuPrice);
                  String menuType = "학생";

                  try {
                    await DatabaseHelper.instance.addMenu(
                      MenuInfo(
                        date: date,
                        restaurant: restaurant,
                        meal: meal,
                        menuName: menuName,
                        price: menuPrice,
                        menuType: menuType,
                      ),
                    );
                    // print('data inserted');
                  } catch(err) {
                    print(err);
                  }
                } else {
                  rows.forEach((e) {
                    String menuData = unescape.convert(e.innerHtml.toString());
                    if (menuData.contains('운영시간') || menuData.contains('혼잡시간')) {
                      return;
                    }
                    if (menuData.length > 1){
                      if (menuData.contains('교직메뉴')) {
                        String menuType = '교직';
                        print(menuType);
                        return;
                      }
                      List _menuData = menuData.split('<br>\n');
                      print(_menuData);
                      _menuData.forEach((elem) async {
                        if (elem.length <= 1) {
                          return;
                        }
                        final menuData2 = menuAndPrice(elem);
                        String menuName = menuData2.item1;
                        String menuPrice = menuData2.item2;
                        print('메뉴: ' + menuName);
                        print('가격: ' + menuPrice);
                        String menuType = "학생";

                        try {
                          await DatabaseHelper.instance.addMenu(
                            MenuInfo(
                              date: date,
                              restaurant: restaurant,
                              meal: meal,
                              menuName: menuName,
                              price: menuPrice,
                              menuType: menuType,
                            ),
                          );
                          // print('data inserted');
                        } catch(err) {
                          print(err);
                        }
                      });
                    }
                  });
                }
              }
            });
  });
  print('data inserted');
}