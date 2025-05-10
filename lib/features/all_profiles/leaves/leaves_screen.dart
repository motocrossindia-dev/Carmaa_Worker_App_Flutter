import 'package:carmaa_worker_app/features/all_profiles/leaves/leaves_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'leaves_provider.dart';

class LeavesScreen extends StatefulWidget {
  const LeavesScreen({super.key});

  @override
  State<LeavesScreen> createState() => _LeavesScreenState();
}

class _LeavesScreenState extends State<LeavesScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<LeavesProvider>().initializeMonth();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text('Today'),
          ),
        ],
      ),
      body: Consumer<LeavesProvider>(
        builder: (context, provider, child) {
          return Column(
            children: [
              // Calendar Header
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.chevron_left),
                      onPressed: provider.previousMonth,
                    ),
                    Text(
                      DateFormat('MMMM yyyy').format(provider.selectedMonth),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.chevron_right),
                      onPressed: provider.nextMonth,
                    ),
                  ],
                ),
              ),

              // Week Headers
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: ['S', 'M', 'T', 'W', 'T', 'F', 'S']
                    .map(
                      (day) => SizedBox(
                        width: 40,
                        child: Text(
                          day,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                    .toList(),
              ),

              // Calendar Grid
              GridView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.all(8),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                  childAspectRatio: 1,
                ),
                itemCount: provider.monthDays.length,
                itemBuilder: (context, index) {
                  final day = provider.monthDays[index];
                  return _buildDayCell(day);
                },
              ),

              const Divider(),

              // Available Days Info
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'You are available for ${provider.availableDays} days this month',
                  style: const TextStyle(fontSize: 16),
                ),
              ),

              // Break Days Info
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Break Days Available',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              '2',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text('Weekend break days'),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              '5',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text('Weekday break days'),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // Bottom Buttons
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text('Apply for break'),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {},
                        child: const Text('View history'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildDayCell(LeaveDay day) {
    Color backgroundColor = Colors.transparent;
    Widget? indicator;

    if (day.isLeave) {
      indicator = const Icon(Icons.close, color: Colors.red, size: 16);
    } else if (day.isWorking) {
      indicator = const Icon(Icons.check, color: Colors.green, size: 16);
    } else if (day.isWeekend) {
      indicator = const Icon(Icons.remove, color: Colors.grey, size: 16);
    }

    return Container(
      margin: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            day.date.day.toString(),
            style: TextStyle(
              color: day.isWeekend ? Colors.grey : Colors.black,
            ),
          ),
          if (indicator != null) indicator,
        ],
      ),
    );
  }
}
