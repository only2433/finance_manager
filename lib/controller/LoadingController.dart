import 'package:get/get.dart';

import 'base/BaseController.dart';

class LoadingController extends GetxController
{
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    init();
  }

  void init()
  {
    disableLoading();
  }

  void enableLoading()
  {
    isLoading.value = true;
  }

  void disableLoading()
  {
    isLoading.value = false;
  }


}