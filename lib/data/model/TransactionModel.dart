
class TransactionModel {
  DateTime? _transactionDate;
  String? _transactionName;
  String? _transactionFeeAmount;

  TransactionModel() {
    _transactionDate = DateTime.now();
    _transactionName = "";
    _transactionFeeAmount = "";
  }

  void setTransactionDate(DateTime time) {
    _transactionDate = time;
  }

  void setTransactionName(String name) {
    _transactionName = name;
  }

  void setTransactionFeeAmount(String amount)
  {
    _transactionFeeAmount = amount;
  }

  DateTime? get transactionDate => _transactionDate;
  String? get transactionItemName => _transactionName;
  String? get transactionFeeAmount => _transactionFeeAmount;

}