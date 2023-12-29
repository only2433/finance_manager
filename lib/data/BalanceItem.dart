

import '../common/Common.dart';

class BalanceItem
{
  String name = "";
  String explain = "";
  String amount = "";
  String IN = Common.INCOME;
  DateTime dateTime;

  BalanceItem({required this.name, required this.explain, required this.amount, required this.IN, required this.dateTime});

  Map<String, dynamic> toMap()
  {
    return {
      'name': name,
      'explain': explain,
      'amount': amount,
      'IN': IN,
      'dateTime': dateTime
    };
  }

  factory BalanceItem.fromMap(Map<String, dynamic> data)
  {
    DateTime myDateTime = DateTime.parse(data['dateTime'].toDate().toString());
    print("time : $myDateTime");
    return BalanceItem(
        name: data['name'],
        explain: data['explain'],
        amount: data['amount'],
        IN: data['IN'],
        dateTime: myDateTime);
  }
}