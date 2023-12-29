import 'package:finance_manager/controller/HomeNavigationController.dart';
import 'package:finance_manager/screens/AddScreen.dart';
import 'package:finance_manager/screens/MyInformation.dart';
import 'package:finance_manager/screens/Statistics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/Home.dart';

class BottomNavigationView extends StatelessWidget {
  const BottomNavigationView({super.key});

  @override
  Widget build(BuildContext context) {
    int currentIndex = 0;
    final controller = Get.find<HomeNavigationController>();
    List Screen = [Home(), Statistics(), Home(), MyInformation()];

    return Scaffold(

      body: Obx(() {
        return Screen[controller.currentBottomViewIndex.value];
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed('/addItem');
        },
        child: Icon(Icons.add),
        backgroundColor: Color(0xff368983),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Padding(
          padding: const EdgeInsets.only(top: 7.5, bottom: 7.5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(onTap: () {
                controller.setBottomViewIndex(0);
              }, child: Obx(
                () {
                  return Icon(Icons.home,
                      color: controller.currentBottomViewIndex.value == 0
                          ? Color(0xff368983)
                          : Colors.grey,
                      size: 30);
                },
              )),
              GestureDetector(onTap: () {
                controller.setBottomViewIndex(1);
              }, child: Obx(
                () {
                  return Icon(Icons.bar_chart_outlined,
                      color: controller.currentBottomViewIndex.value == 1
                          ? Color(0xff368983)
                          : Colors.grey,
                      size: 30);
                },
              )),
              SizedBox(
                width: 20,
              ),
              GestureDetector(onTap: () {
                controller.setBottomViewIndex(2);
              }, child: Obx(
                () {
                  return Icon(Icons.account_balance_wallet_outlined,
                      color: controller.currentBottomViewIndex.value == 2
                          ? Color(0xff368983)
                          : Colors.grey,
                      size: 30);
                },
              )),
              GestureDetector(
                onTap: () {
                  controller.setBottomViewIndex(3);
                },
                child: Obx(() {
                  return Icon(Icons.person_outlined,
                      color: controller.currentBottomViewIndex.value == 3 ? Color(0xff368983) : Colors.grey,
                      size: 30);
                },),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
