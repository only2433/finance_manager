
import 'package:finance_manager/data/model/SignUpModel.dart';
import 'package:get/get.dart';
import 'dart:io';

import 'base/BaseController.dart';

class SignUpController extends GetxController
{
  late SignUpModel mSignUpModel;
  var isBirthdaySelected = false.obs;
  Rx<DateTime> birthdayDate = DateTime.now().obs;
  Rx<File?> userPickerImage = Rx<File?>(null);


  @override
  void onInit() {
    super.onInit();
    mSignUpModel = SignUpModel();
  }

  void setImageFile(String imagePath)
  {
    mSignUpModel.setUserPickerImage(imagePath);
    userPickerImage(mSignUpModel.getUserPickerImage);
  }

  void setBirthDay(DateTime date)
  {
    mSignUpModel.setBirthday(date);
    mSignUpModel.setBirthdaySelected(true);
    birthdayDate(mSignUpModel.getBirthdayDate);
    isBirthdaySelected(mSignUpModel.isBirthdaySelected);
  }

  DateTime getBirthDay()
  {
    return birthdayDate.value;
  }
}