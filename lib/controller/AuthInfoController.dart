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
import '../screens/Home.dart';
import '../screens/Login.dart';
import '../widgets/BottomNavigationBar.dart';

class AuthInfoController extends GetxController
{
  static AuthInfoController instance = Get.find();
  FirebaseAuth auth = FirebaseAuth.instance;
  Rxn<UserBalanceDataObject> _userBalanceDateObject = Rxn<UserBalanceDataObject>();
  Rxn<User> _user = Rxn<User>();

  RxBool isLoggedin = false.obs;

  @override
  void onReady()
  {
    super.onReady();
    _syncInitUserData();
  }

  Rxn<UserBalanceDataObject> getData()
  {
    return _userBalanceDateObject;
  }

  void signUpData(String email, String nickName, String userImageUrl, DateTime birthday)
  {
    _userBalanceDateObject = UserBalanceDataObject(
        email: email,
        nickName: nickName,
        userImage: userImageUrl,
        dateTime: birthday,
        itemList: <BalanceItem>[]) as Rxn<UserBalanceDataObject>;
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
    await FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser!.uid)
        .set(_userBalanceDateObject.value!.toMap());
   await settingData(false);
  }

  Future<UserCredential> login(String id, String password) async
  {
    final userData = await auth.signInWithEmailAndPassword(
        email: id,
        password: password);
    if(userData != null)
      {
        Logger.d('login : ${userData.user.toString()}', tag: Common.APP_NAME);
      }

    return userData;
  }

  Future<void> _syncInitUserData() async
  {
    _user.bindStream(auth.idTokenChanges());
    ever(_user, (callback)
    {
      if (auth.currentUser != null)
      {
        Logger.d("current User get : ${auth.currentUser!.uid}", tag: Common.APP_NAME);
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
    _userBalanceDateObject.value = await getUserBalanceData();
    Logger.d("goMain : $goMain , data :  ${_userBalanceDateObject.value.toString()}", tag: Common.APP_NAME);
    if(goMain && _userBalanceDateObject.value.toString() != null)
      {
        Logger.d("go to home", tag: Common.APP_NAME);
        Get.offAllNamed('/main');
      }
  }

  Future<UserBalanceDataObject> getUserBalanceData() async
  {
    /*return await FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser!.uid)
        .snapshots()
        .map((snapshot) => UserBalanceDataObject.fromJson(snapshot.data()!));*/
    var snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser!.uid)
        .get();

    if(snapshot.exists)
      {
        return UserBalanceDataObject.fromJson(snapshot.data()!);
      }
    else
      {
        throw Exception("No data found");
      }

  }

  Stream<UserBalanceDataObject> getUserBalanceDataToStream()
  {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser!.uid)
        .snapshots()
        .map((snapshot) => UserBalanceDataObject.fromJson(snapshot.data()!));
  }


  void logout() async
  {
    await auth.signOut();
  }
}
