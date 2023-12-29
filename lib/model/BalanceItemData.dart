import 'package:hive/hive.dart';
part 'BalanceItemData.g.dart';
@HiveType(typeId: 1)
class BalanceItemData extends HiveObject
{
  @HiveField(0)
  String name;

  @HiveField(1)
  String explain;

  @HiveField(2)
  String amount;

  @HiveField(3)
  String IN;

  @HiveField(4)
  DateTime dateTime;

  BalanceItemData(this.IN, this.amount, this.dateTime, this.explain, this.name);

  String toString()
  {
    return 'name : $name, amount : $amount, IN : $IN, dateTime : $dateTime';
  }
}