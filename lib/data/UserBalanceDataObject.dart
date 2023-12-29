import 'package:get/get.dart';

import 'BalanceItem.dart';

class UserBalanceDataObject
{
  String email;
  String nickName;
  String userImage;
  DateTime dateTime;
  List<BalanceItem> itemList = [];

  UserBalanceDataObject({
    required this.email,
    required this.nickName,
    required this.userImage,
    required this.dateTime,
    required this.itemList
  });

  Map<String, dynamic> toMap()
  {
    return {
      'userEmail': email,
      'userNickName': nickName,
      'userImage': userImage,
      'birthDay' : dateTime,
      'itemList': itemList.map((balanceItem) => balanceItem.toMap()).toList()
    };
  }

  factory UserBalanceDataObject.fromJson(Map<String, dynamic> data)
  {
    DateTime myBirthday = DateTime.parse(data['birthDay'].toDate().toString());
    print("itemList :  ${data['itemList']}");
    if (data['itemList'] == null)
    {
      return UserBalanceDataObject(
          email: data['userEmail'],
          nickName: data['userNickName'],
          userImage: data['userImage'],
          dateTime: myBirthday,
          itemList: []);
    }
    else
    {
      var list = data['itemList'].map((e) => BalanceItem.fromMap(e)).toList();

      return UserBalanceDataObject(
          email: data['userEmail'],
          nickName: data['userNickName'],
          userImage: data['userImage'],
          dateTime: myBirthday,
          itemList: List<BalanceItem>.from(list));
    }

  }

  @override
  String toString()
  {
    return "Email : " + email + "NickName : " + nickName + ", ImageUrl : " + userImage +", birthday : " + dateTime.toString();
  }
}
