
import 'package:finance_manager/controller/HomeNavigationController.dart';
import 'package:finance_manager/controller/AuthInfoController.dart';
import 'package:finance_manager/model/BalanceItemData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../data/BalanceItem.dart';

class Utility
{
  static Utility? _instance;

  static Utility getInstance()
  {
    if(_instance == null)
      {
        _instance = Utility();
      }
    return _instance!;
  }


  int totals = 0;
  final List<String> day = [
    'Monday',
    'Tuesday',
    'Wendsday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];


  int total()
  {
    var controller = Get.find<AuthInfoController>();
    var data = controller.getData().value!.itemList;
    List list = [0, 0];
    for (int i = 0; i < data.length; i++) {
      list.add(data[i].IN == 'Income'
          ? int.parse(data[i].amount)
          : int.parse(data[i].amount) * -1);
    }
    totals = list.reduce((value, element) => value + element);
    return totals;
  }

  int totalChart()
  {
    var controller = Get.find<AuthInfoController>();
    var data = controller.getData().value!.itemList;
    List list = [0, 0];
    for (int i = 0; i < data.length; i++) {
      list.add(data[i].IN == 'Income'
          ? int.parse(data[i].amount)
          : int.parse(data[i].amount) * -1);
    }
    totals = list.reduce((value, element) => value + element);
    return totals;
  }

  int incomes()
  {
    var controller = Get.find<AuthInfoController>();
    var data = controller.getData().value!.itemList;
    List list = [0, 0];
    for (int i = 0; i < data.length; i++) {
      list.add(data[i].IN == 'Income' ? int.parse(data[i].amount) : 0);
    }
    totals = list.reduce((value, element) => value + element);
    return totals;
  }

  int expands()
  {
    var controller = Get.find<AuthInfoController>();
    var data = controller.getData().value!.itemList;
    List list = [0, 0];
    for (int i = 0; i < data.length; i++) {
      list.add(data[i].IN == 'Income' ? 0 : int.parse(data[i].amount) * -1);
    }
    totals = list.reduce((value, element) => value + element);
    return totals;
  }

  List<BalanceItem> week()
  {
    var controller = Get.find<AuthInfoController>();
    var data = controller.getData().value!.itemList;
    List<BalanceItem> list = [];
    DateTime date = DateTime.now();
    for (var i = 0; i < data.length; i++) {
      if (date.day - 7 <= data[i].dateTime.day &&
          data[i].dateTime.day <= date.day) {
        list.add(data[i]);
      }
    }
    list.sort((a, b) => a.dateTime.compareTo(b.dateTime));
    return list;
  }

  List<BalanceItem> today()
  {
    var controller = Get.find<AuthInfoController>();
    var data = controller.getData().value!.itemList;
    List<BalanceItem> list = [];
    DateTime date = DateTime.now();
    for (var i = 0; i < data.length; i++) {
      if (date.day == data[i].dateTime.day) {
        list.add(data[i]);
      }
    }
    list.sort((a, b) => a.dateTime.compareTo(b.dateTime));
    return list;
  }

  List<BalanceItem> month()
  {
    var controller = Get.find<AuthInfoController>();
    var data = controller.getData().value!.itemList;
    List<BalanceItem> list = [];
    DateTime date = DateTime.now();
    for (var i = 0; i < data.length; i++) {
      if (date.month == data[i].dateTime.month) {
        list.add(data[i]);
      }
    }
    list.sort((a, b) => a.dateTime.compareTo(b.dateTime));
    return list;
  }

  List<BalanceItem> year()
  {
    var controller = Get.find<AuthInfoController>();
    var data = controller.getData().value!.itemList;
    List<BalanceItem> list = [];
    DateTime date = DateTime.now();
    for (var i = 0; i < data.length; i++) {
      if (date.year == data[i].dateTime.year) {
        list.add(data[i]);
      }
    }
    list.sort((a, b) => a.dateTime.compareTo(b.dateTime));
    print(list.toString());
    return list;
  }

  void showErrorMessage(String errorMessage) {
    Get.snackbar('Error', errorMessage,
        colorText: Colors.white,
        backgroundColor: Colors.black,
        snackPosition: SnackPosition.BOTTOM,
        snackStyle: SnackStyle.GROUNDED,
        duration: Duration(milliseconds: 1000),
        animationDuration: Duration(milliseconds: 300));
  }

  void showSuccessMessage(String successMessage) {
    Get.snackbar('Success', successMessage,
        colorText: Colors.green,
        backgroundColor: Colors.black,
        snackPosition: SnackPosition.BOTTOM,
        snackStyle: SnackStyle.GROUNDED,
        duration: Duration(milliseconds: 1000),
        animationDuration: Duration(milliseconds: 300));
  }

  String getWelcomeTitle()
  {
    var data = DateTime.now();
    if(data.hour < 12 && data.hour > 6)
      {
        return 'Good Morning';
      }
    else if(data.hour > 12 && data.hour < 19)
      {
        return 'Good Afternoon';
      }
    return 'Good night';
  }
}



