import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'monthly_summary_provider.dart';

class MonthlySummaryScreen extends StatelessWidget {
  const MonthlySummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('All Bank transfers'),
      ),
      body: Consumer<MonthlySummaryProvider>(
        builder: (context, provider, _) {
          return ListView.separated(
            itemCount: provider.transfers.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              final transfer = provider.transfers[index];
              return ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          transfer.dateRange,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          transfer.status,
                          style: TextStyle(
                            color: transfer.isUpcoming
                                ? Colors.grey
                                : Colors.green,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          '₹${transfer.amount.toStringAsFixed(0)}',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: transfer.isUpcoming
                                ? Colors.grey
                                : Colors.black,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(
                          Icons.chevron_right,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
