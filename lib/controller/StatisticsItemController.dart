
import 'package:get/get.dart';

import '../data/BalanceItem.dart';
import '../model/BalanceItemData.dart';

class StatisticsItemController extends GetxController
{
  var currentChartPosition = 0.obs;
  var currentChartItemList = <BalanceItem>[].obs;

  void setChartPosition(int position)
  {
    currentChartPosition.value = position;
  }

  void setCurrentChartItemList(List<BalanceItem> list)
  {
    currentChartItemList.assignAll(list);
  }
}