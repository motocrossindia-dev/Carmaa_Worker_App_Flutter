class LeaveDay {
  final DateTime date;
  final bool isWorking;
  final bool isLeave;
  final bool isWeekend;

  LeaveDay({
    required this.date,
    this.isWorking = true,
    this.isLeave = false,
    this.isWeekend = false,
  });
}
