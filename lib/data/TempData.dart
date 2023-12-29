import 'Money.dart';

List<Money> getItemList()
{
  Money upwork = Money();
  upwork.name = 'upwork';
  upwork.fee = '\$ 650';
  upwork.time = 'today';
  upwork.image = 'Education.png';
  upwork.buy = false;

  Money starbucks = Money();
  starbucks.name = 'starbucks';
  starbucks.fee = '\$ 15';
  starbucks.time = 'today';
  starbucks.image = 'food.png';
  starbucks.buy = true;

  Money transfer = Money();
  transfer.name = 'transfer for sam';
  transfer.fee = '\$ 100';
  transfer.time = 'jun 39, 2022';
  transfer.image = 'Transfer.png';
  transfer.buy = true;

  return [upwork, starbucks, transfer,upwork, starbucks, transfer];
}