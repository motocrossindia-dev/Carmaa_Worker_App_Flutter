import 'package:carmaa_worker_app/features/all_profiles/leaves/leaves_model.dart';
import 'package:flutter/material.dart';

class LeavesProvider extends ChangeNotifier {
  DateTime _selectedMonth = DateTime.now();
  List<LeaveDay> _monthDays = [];
  int weekendBreakDays = 2;
  int weekdayBreakDays = 5;

  DateTime get selectedMonth => _selectedMonth;
  List<LeaveDay> get monthDays => _monthDays;
  int get availableDays => _monthDays.where((day) => day.isWorking).length;

  // Dummy data generator
  void generateMonthData([DateTime? date]) {
    _selectedMonth = date ?? _selectedMonth;
    _monthDays = [];

    // Get the first day of the month
    final firstDay = DateTime(_selectedMonth.year, _selectedMonth.month, 1);
    // Get the last day of the month
    final lastDay = DateTime(_selectedMonth.year, _selectedMonth.month + 1, 0);

    for (var i = 1; i <= lastDay.day; i++) {
      final currentDate =
          DateTime(_selectedMonth.year, _selectedMonth.month, i);
      final isWeekend = currentDate.weekday == 6 || currentDate.weekday == 7;

      // Generate random status for demo
      final isLeave = i % 7 == 0;
      final isWorking = !isWeekend && !isLeave;

      _monthDays.add(LeaveDay(
        date: currentDate,
        isWorking: isWorking,
        isLeave: isLeave,
        isWeekend: isWeekend,
      ));
    }
    notifyListeners();
  }

  void nextMonth() {
    _selectedMonth = DateTime(
      _selectedMonth.year,
      _selectedMonth.month + 1,
    );
    generateMonthData();
  }

  void previousMonth() {
    _selectedMonth = DateTime(
      _selectedMonth.year,
      _selectedMonth.month - 1,
    );
    generateMonthData();
  }

  void initializeMonth() {
    generateMonthData(DateTime.now());
  }
}
