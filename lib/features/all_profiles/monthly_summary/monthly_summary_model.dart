class BankTransfer {
  final String dateRange;
  final String status;
  final double amount;
  final bool isUpcoming;

  BankTransfer({
    required this.dateRange,
    required this.status,
    required this.amount,
    this.isUpcoming = false,
  });
}
