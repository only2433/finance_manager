import 'package:flutter/material.dart';
import 'package:flutter_easylogger/flutter_logger.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../common/Common.dart';
import '../common/Utility.dart';
import '../data/BalanceItem.dart';
import '../model/BalanceItemData.dart';
import 'package:finance_manager/data/SalesData.dart';

class Chart extends StatefulWidget
{
  final List<BalanceItem> itemList;
  const Chart({Key? key, required this.itemList}) : super(key: key);

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart>
{
  List<SalesData> showDataList = [];
  int totalAmount = 0;
  @override
  void initState()
  {
    super.initState();
    Logger.d('initState', tag: Common.APP_NAME);
  }


  @override
  void activate()
  {
    super.activate();
    Logger.d('activate', tag: Common.APP_NAME);
  }

  @override
  Widget build(BuildContext context)
  {
    settingData();
    return Container(
      width: double.infinity,
      height: 300,
      child: SfCartesianChart(
          primaryXAxis: CategoryAxis(),
          series: <SplineSeries<SalesData, String>>[
            SplineSeries(
              color: const Color.fromARGB(255, 47, 125, 121),
              width: 3,
              dataSource: showDataList,
              xValueMapper: (data, index) {
                return data.dateTime;
              },
              yValueMapper: (data, index) {
                return data.fee;
              },
            )
          ]),
    );
  }

  void settingData()
  {
    Logger.d('settingData listSize : ${widget.itemList.length}', tag: Common.APP_NAME);
    showDataList.clear();
    totalAmount = 0;

    for (int i = 0; i < widget.itemList.length; i++)
    {
      String date = '${widget.itemList[i].dateTime.month}-${widget.itemList[i].dateTime.day}';

      if (widget.itemList[i].IN == 'Income')
      {
        totalAmount += int.parse(widget.itemList[i].amount);
        print('income : ${widget.itemList[i].amount} , total : $totalAmount');
      }
      else
      {
        totalAmount -= int.parse(widget.itemList[i].amount);
        print('expand : ${widget.itemList[i].amount} , total : $totalAmount');
      }
      showDataList
          .add(SalesData(dateTime: date, fee: totalAmount));
    }
  }
}

