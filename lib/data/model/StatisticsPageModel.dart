
import '../BalanceItem.dart';

class StatisticsPageModel
{
  int _chartPosition = 0;
  var _currentChartItemList = <BalanceItem>[];

  StatisticsPageModel()
  {
    _chartPosition = 0;
    _currentChartItemList = <BalanceItem>[];
  }

  void setChartPosition(int position)
  {
    _chartPosition = position;
  }

  void setCurrentChatItemList(List<BalanceItem> list)
  {
    _currentChartItemList = list;
  }

  int get getChartPosition => _chartPosition;
  List<BalanceItem> get getChartItemList => _currentChartItemList;
}