
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../model/BalanceItemData.dart';

class HomeNavigationController extends GetxController
{
  var currentBottomViewIndex = 0.obs;

  @override
  void onInit()
  {
    super.onInit();
  }

  void setBottomViewIndex(int index)
  {
    currentBottomViewIndex.value = index;
  }
}