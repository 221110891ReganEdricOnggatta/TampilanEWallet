class TransactionHistory {
  final DateTime dateTime;
  final String action;
  final double amount;
  final bool isAddition;

  TransactionHistory({
    required this.dateTime,
    required this.action,
    required this.amount,
    required this.isAddition,
  });
}
