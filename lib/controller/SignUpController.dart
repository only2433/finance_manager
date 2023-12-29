
import 'package:get/get.dart';
import 'dart:io';

import 'base/BaseController.dart';

class SignUpController extends GetxController
{
  Rx<DateTime> birthdayDate = DateTime.now().obs;
  var isSelected = false.obs;
  Rx<File?> mUserPickerImage = Rx<File?>(null);


  @override
  void onInit() {
    super.onInit();
    init();
  }

  void init() {
    birthdayDate.value = DateTime.now();
    isSelected.value = false;
    mUserPickerImage.value = null;
  }

  void setImageFile(String imagePath)
  {
    mUserPickerImage.value = File(imagePath);
  }

  void setUserDate(DateTime date)
  {
    birthdayDate.value = date;
    isSelected.value = true;
  }

  DateTime getBirthDay()
  {
    return birthdayDate.value;
  }


}