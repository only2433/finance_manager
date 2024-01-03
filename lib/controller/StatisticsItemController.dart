
import 'package:finance_manager/data/model/StatisticsPageModel.dart';
import 'package:flutter_easylogger/flutter_logger.dart';
import 'package:get/get.dart';

import '../common/Common.dart';
import '../data/BalanceItem.dart';
import '../model/BalanceItemData.dart';

class StatisticsItemController extends GetxController
{
  late StatisticsPageModel mStatisticsPageModel;
  var currentChartPosition = 0.obs;
  var currentChartItemList = <BalanceItem>[].obs;

  @override
  void onInit()
  {
    super.onInit();
    Logger.d("onInit", tag: Common.APP_NAME);
    mStatisticsPageModel = StatisticsPageModel();

  }
  void setChartPosition(int position)
  {
    mStatisticsPageModel.setChartPosition(position);
    currentChartPosition(mStatisticsPageModel.getChartPosition);
  }

  void setCurrentChartItemList(List<BalanceItem> list)
  {
    mStatisticsPageModel.setCurrentChatItemList(list);
    currentChartItemList(mStatisticsPageModel.getChartItemList);
  }
}