import 'dart:developer';

import 'package:finance_manager/data/UserBalanceDataObject.dart';
import 'package:finance_manager/model/BalanceItemData.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easylogger/flutter_logger.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../common/Common.dart';
import '../data/BalanceItem.dart';
import '../repository/FirebaseRepository.dart';
import '../screens/Home.dart';
import '../screens/Login.dart';
import '../widgets/BottomNavigationBar.dart';

class AuthInfoController extends GetxController
{
  late FirebaseRepository mFirebaseRepository;
  Rxn<UserBalanceDataObject> _userBalanceDateObject = Rxn<UserBalanceDataObject>();
  Rxn<User> _user = Rxn<User>();

  RxBool isLoggedin = false.obs;

  @override
  void onReady()
  {
    super.onReady();
    mFirebaseRepository = FirebaseRepository();
    _syncInitUserData();
  }

  Rxn<UserBalanceDataObject> getData()
  {
    return _userBalanceDateObject;
  }

  void removeBalanceItem(int index)
  {
    _userBalanceDateObject.value?.itemList.removeAt(index);
  }

  void addBalanceItem(BalanceItem item)
  {
    _userBalanceDateObject.value?.itemList.add(item);
  }

  Future<void> uploadUserBalanceData() async
  {
    await mFirebaseRepository.uploadUserBalanceData(_userBalanceDateObject.value!);
    await settingData(false);
  }

  Future<UserCredential> login(String id, String password) async
  {
    final userData = await mFirebaseRepository.login(id, password);
    if(userData != null)
      {
        Logger.d('login : ${userData.user.toString()}', tag: Common.APP_NAME);
      }
    return userData;
  }

  Future<void> _syncInitUserData() async
  {
    _user.bindStream(mFirebaseRepository.getFirebaseAuth().idTokenChanges());
    ever(_user, (callback)
    {
      Logger.d("User get : ${_user.value}", tag: Common.APP_NAME);
      if (_user.value != null)
      {
        Logger.d("current User get : ${_user.value!.uid}", tag: Common.APP_NAME);
        settingData(true);
        Logger.d("data : " + _userBalanceDateObject.value.toString(), tag: Common.APP_NAME);
      }
      else
      {
        Logger.d("go to login ", tag: Common.APP_NAME);
        Get.offAllNamed('/login');
      }
    });
  }

  Future<void> settingData(bool goMain) async
  {
    _userBalanceDateObject.value = await mFirebaseRepository.getUserBalanceData();
    Logger.d("goMain : $goMain , data :  ${_userBalanceDateObject.value.toString()}", tag: Common.APP_NAME);
    if(goMain && _userBalanceDateObject.value.toString() != null)
      {
        Logger.d("go to home", tag: Common.APP_NAME);
        Get.offAllNamed('/main');
      }
  }


  void logout() async
  {
    await mFirebaseRepository.logout();
  }
}
