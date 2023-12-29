import 'package:finance_manager/controller/HomeNavigationController.dart';
import 'package:finance_manager/controller/StatisticsItemController.dart';
import 'package:finance_manager/model/BalanceItemData.dart';
import 'package:flutter/material.dart';
import 'package:finance_manager/common/Utility.dart';
import 'package:get/get.dart';
import '../data/BalanceItem.dart';
import '../data/TempData.dart';
import '../widgets/Chart.dart';

class Statistics extends StatefulWidget {
  const Statistics({super.key});

  @override
  State<Statistics> createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  List list = ['Week', 'Month', 'Year'];
  final controller = Get.put(StatisticsItemController());

  @override
  void initState()
  {
    super.initState();
    controller.setChartPosition(0);
    controller.setCurrentChartItemList(getItemList(0));
  }

  List<BalanceItem> getItemList(int position)
  {
    switch(position)
        {
      case 0:
        return Utility.getInstance().week();
      case 1:
        return Utility.getInstance().month();
      case 2:
        return Utility.getInstance().year();
    }
    return Utility.getInstance().week();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: customScrollView(),
      ),
    );
  }

  CustomScrollView customScrollView() {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: _getHead(),
        ),
        SliverToBoxAdapter(
          child: Column(
            children: [
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 120,
                      height: 40,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 2),
                          borderRadius: BorderRadius.circular(8)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Expense',
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          Icon(
                            Icons.arrow_downward_sharp,
                            color: Colors.grey,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 20),
              Obx(() {
                return Chart(itemList: controller.currentChartItemList.value);
              }),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    Text(
                      'Top Spending',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    Icon(
                      Icons.swap_vert,
                      size: 25,
                      color: Colors.grey,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        Obx((){
          return SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return listItemView(index, controller.currentChartItemList.value[index]);
              }, childCount: controller.currentChartItemList.value.length));
        })
      ],
    );
  }


  Widget _getHead() {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Text(
          'Stastics',
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.w700),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ...List.generate(3, (index) {
                return GestureDetector(
                  onTap: () {
                    controller.setCurrentChartItemList(getItemList(index));
                    controller.setChartPosition(index);
                  },
                  child: Obx(() {
                    return Container(
                      width: 80,
                      height: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: controller.currentChartPosition.value == index
                              ? Color.fromARGB(255, 47, 125, 121)
                              : Colors.white),
                      child: Text(
                        list[index],
                        style: TextStyle(
                          color: controller.currentChartPosition.value == index
                              ? Colors.white
                              : Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                    );
                  }),
                );
              })
            ],
          ),
        ),
      ],
    );
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
}
