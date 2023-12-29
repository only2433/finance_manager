import 'package:finance_manager/data/TempData.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easylogger/flutter_logger.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:google_fonts/google_fonts.dart';

import '../common/Common.dart';
import '../common/Utility.dart';
import '../controller/HomeNavigationController.dart';
import '../data/BalanceItem.dart';
import '../model/BalanceItemData.dart';
import 'Login.dart';
import 'package:finance_manager/controller/AuthInfoController.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late BalanceItem history;
  final dataController = Get.find<AuthInfoController>();
  final _authentication = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();

    Logger.d("--------- initState : ${Utility.getInstance().getWelcomeTitle()}", tag: Common.APP_NAME);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
          child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(
                height: 340,
                child: _head(context)),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Transactions History',
                      style: TextStyle(fontSize: 19, color: Colors.black)),
                  Text('See All',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 19,
                          color: Colors.grey)),
                ],
              ),
            ),
          ),
          if (dataController.getData().value!.itemList.length >= 0)
            Obx(() {
              return SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                history = dataController.getData().value!.itemList[index];
                return listView(index, history);
              }, childCount: dataController.getData().value?.itemList.length));
            })
        ],
      )),
    );
  }

  Widget _head(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 240,
          decoration: BoxDecoration(
              color: Color(0xff368983),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20))),
          child: Stack(
            children: [
              Positioned(
                  top: 35,
                  left: 360,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(7),
                    child: GestureDetector(
                      onTap: () {
                        showLogoutDialog(context);
                      },
                      child: Container(
                        width: 30,
                        height: 30,
                        color: Color.fromRGBO(250, 250, 250, 0.1),
                        child: Icon(
                          Icons.logout,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )),
              Padding(
                padding: EdgeInsets.only(top: 30, left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Utility.getInstance().getWelcomeTitle(),
                      style: GoogleFonts.lobster(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: Color.fromARGB(255, 224, 223, 223)),
                    ),
                    Text(
                      dataController.getData().value == null
                          ? "User"
                          : dataController.getData().value!.nickName,
                      style: GoogleFonts.signikaNegative(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Positioned(
          top: 140,
          left: 37,
          child: Container(
            width: 320,
            height: 170,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Color.fromRGBO(47, 125, 121, 0.3),
                      offset: Offset(0, 6),
                      blurRadius: 12,
                      spreadRadius: 6)
                ],
                color: Color.fromARGB(255, 47, 125, 121),
                borderRadius: BorderRadius.circular(15)),
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Balance',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Colors.white),
                      ),
                      Icon(
                        Icons.more_horiz,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 7,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Row(
                    children: [
                      Obx(() {
                        return Text(
                          '\$ ${Utility.getInstance().total()}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              color: Colors.white),
                        );
                      })
                    ],
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 13,
                            backgroundColor: Color.fromARGB(255, 85, 145, 141),
                            child: Icon(
                              Icons.arrow_downward,
                              color: Colors.white,
                              size: 19,
                            ),
                          ),
                          SizedBox(
                            width: 7,
                          ),
                          Text(
                            'Income',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Color.fromARGB(255, 216, 216, 216)),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 13,
                            backgroundColor: Color.fromARGB(255, 85, 145, 141),
                            child: Icon(
                              Icons.arrow_upward,
                              color: Colors.white,
                              size: 19,
                            ),
                          ),
                          SizedBox(
                            width: 7,
                          ),
                          Text(
                            'Expenses',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Color.fromARGB(255, 216, 216, 216)),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(() {
                        return Text(
                          '\$ ${Utility.getInstance().incomes()}',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 17,
                              color: Colors.white),
                        );
                      }),
                      Obx(() {
                        return Text(
                          '\$ ${Utility.getInstance().expands()}',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 17,
                              color: Colors.white),
                        );
                      })
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget listView(int index, BalanceItem data)
  {
    return Dismissible(
        onDismissed: (direction) async
        {
          dataController.removeBalanceItem(index);
          await dataController.uploadUserBalanceData();
        },
        key: UniqueKey(),
        child: listItemView(index, data));
  }

  ListTile listItemView(int index, BalanceItem item) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Image.asset('images/${item.name}.png', height: 40),
      ),
      title: Text(
        item.name,
        style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        '${Utility.getInstance().day[item.dateTime.weekday - 1]}  ${item.dateTime.year}-${item.dateTime.day}-${item.dateTime.month}',
        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
      ),
      trailing: Text(
        item.IN == 'Income' ? '\$${item.amount}' : '- \$${item.amount}',
        style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 19,
            color: item.IN == 'Income' ? Colors.green : Colors.red),
      ),
    );
  }

  void showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [Text("로그아웃 하시겠습니까?")],
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text(
                  '취소',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w300),
                )),
            TextButton(
                onPressed: () async {
                  try {
                    dataController.logout();
                  } catch (e) {
                    Utility.getInstance().showErrorMessage(e.toString());
                  }
                },
                child: Text(
                  '확인',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w300),
                ))
          ],
        );
      },
    );
  }
}
