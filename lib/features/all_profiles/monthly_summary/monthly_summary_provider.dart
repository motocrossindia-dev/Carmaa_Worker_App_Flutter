import 'package:flutter/material.dart';
import 'monthly_summary_model.dart';

class MonthlySummaryProvider extends ChangeNotifier {
  final List<BankTransfer> _transfers = [
    BankTransfer(
      dateRange: '22 - 23 Apr',
      status: 'Upcoming',
      amount: 0,
      isUpcoming: true,
    ),
    BankTransfer(
      dateRange: '19 - 21 Apr',
      status: 'Success',
      amount: 3664,
    ),
    BankTransfer(
      dateRange: '17 - 18 Apr',
      status: 'Success',
      amount: 3646,
    ),
    BankTransfer(
      dateRange: '15 - 16 Apr',
      status: 'Success',
      amount: 835,
    ),
    BankTransfer(
      dateRange: '12 - 14 Apr',
      status: 'Success',
      amount: 1063,
    ),
    BankTransfer(
      dateRange: '08 - 11 Apr',
      status: 'Success',
      amount: 875,
    ),
    BankTransfer(
      dateRange: '05 - 07 Apr',
      status: 'Success',
      amount: 3288,
    ),
    BankTransfer(
      dateRange: '03 - 04 Apr',
      status: 'Success',
      amount: 2219,
    ),
    BankTransfer(
      dateRange: '25 Mar - 02 Apr',
      status: 'Success',
      amount: 1249,
    ),
    BankTransfer(
      dateRange: '20 - 24 Mar',
      status: 'Success',
      amount: 1532,
    ),
  ];

  List<BankTransfer> get transfers => _transfers;
}
