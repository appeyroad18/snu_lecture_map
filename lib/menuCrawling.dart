import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;

class MenuInfo {
  final String restaurant;
  final String meal;
  final String menuName;
  final String price;
  MenuInfo(
      {
        required this.restaurant,
        required this.meal,
        required this.menuName,
        required this.price,
      }
      );
}

Future<List<MenuInfo>> getMenuInfo() async {
  List<MenuInfo> menuData = [];
  List<String> rawMenuData = [];

  String snuMenuUrl = 'https://snuco.snu.ac.kr/ko/foodmenu?field_menu_date_value_1%5Bvalue%5D%5Bdate%5D=&field_menu_date_value%5Bvalue%5D%5Bdate%5D=02%2F03%2F2022';
  final http.Response response = await http.get(Uri.parse(snuMenuUrl));
  dom.Document document = parser.parse(response.body);
  document.getElementsByTagName("tr").skip(1)
          .forEach((dom.Element element) {
            String restaurant = '';
            String meal = '';
            String menuPattern = r'[ㄱ-ㅎ|가-힣]+.*[0-9]{1,2}(,[0-9]*)원$';
            RegExp menuRegex = RegExp(menuPattern);
            var elements = element.getElementsByTagName('td');
            elements.forEach((elem) {
              var className = elem.className;
              if (className == 'views-field views-field-field-restaurant') {
                restaurant = elem.innerHtml;
                print(restaurant);
              } else if (className == 'views-field views-field-field-breakfast') {
                meal = '아침';
                print(meal);
                var rows = elem.getElementsByTagName('p');
                rows.forEach((e) {

                  String menuData = e.innerHtml.toString();
                  String menuName = menuData.split('&nbsp;')[0];
                  String menuPrice = menuData.split('&nbsp; ')[1];
                  print(menuName);
                  print(menuPrice);
                });
              } else if (className == 'views-field views-field-field-lunch') {
                meal = '점심';
                print(meal);
                var rows = elem.getElementsByTagName('p');
                rows.forEach((element) {print(element.innerHtml);});
              } else if (className == 'views-field views-field-field-dinner') {
                meal = '저녁';
                print(meal);
                var rows = elem.getElementsByTagName('p');
                rows.forEach((element) {print(element.innerHtml);});
              }
            // 메뉴 정규표현식
            // ^\[ㄱ-ㅎ가-힣]+.[0-9]{1,2}(,[0-9]*)원$
            });

  });

  return menuData;
}