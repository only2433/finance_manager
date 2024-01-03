import 'package:finance_manager/data/model/TransactionModel.dart';
import 'package:get/get.dart';
import 'package:flutter_easylogger/flutter_logger.dart';

import '../common/Common.dart';

class AddScreenController extends GetxController
{
  late TransactionModel mTransactionModel;
  Rx<DateTime> selectedDate = DateTime.now().obs;
  RxString selectedNameItem = "".obs;
  RxString selectedFeeItem = "".obs;

  @override
  void onInit()
  {
    super.onInit();
    Logger.d("onInit", tag: Common.APP_NAME);
    mTransactionModel = TransactionModel();
  }


  void setSelectItemDate(DateTime date)
  {
    mTransactionModel.setTransactionDate(date);
    selectedDate(mTransactionModel.transactionDate);
  }

  void setSelectItemName(String name)
  {
    mTransactionModel.setTransactionName(name);
    selectedNameItem(mTransactionModel.transactionItemName);
  }

  void setSelectItemFee(String fee)
  {
    mTransactionModel.setTransactionFeeAmount(fee);
    selectedFeeItem(mTransactionModel.transactionFeeAmount);
  }
}