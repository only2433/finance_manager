import 'package:get/get.dart';

class AddScreenController extends GetxController
{
  late Rx<DateTime> selectedDate;
  RxString selectedNameItem = "".obs;
  RxString selectedFeeItem = "".obs;

  @override
  void onInit()
  {
    super.onInit();
    selectedDate = DateTime.now().obs;
  }

  void initBalanceData()
  {
    selectedDate.value = DateTime.now();
    selectedNameItem.value = "";
    selectedFeeItem.value = "";
  }

  void setSelectItemDate(DateTime date)
  {
    selectedDate.value = date;
  }

  void setSelectItemName(String name)
  {
    selectedNameItem.value = name;
  }

  void setSelectItemFee(String fee)
  {
    selectedFeeItem.value = fee;
  }
}