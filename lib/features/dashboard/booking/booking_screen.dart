import 'package:flutter/material.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.green[100],
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Row(
                            children: [
                              Icon(Icons.circle, color: Colors.green, size: 12),
                              SizedBox(width: 4),
                              Text('Booking'),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Row(
                      children: [
                        Text(
                          'RS 4025',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.notifications_outlined),
                      ],
                    ),
                  ],
                ),
              ),
              // Green Status Bar
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                color: Colors.green,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Aaj ka job Count/Business',
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      '2/4125',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              // Banner Area
              Container(
                height: 150,
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text('Banner'),
                ),
              ),
              // Tab Bar
              const TabBar(
                tabs: [
                  Tab(text: 'Today'),
                  Tab(text: 'Tomorrow'),
                  Tab(text: 'All'),
                ],
                labelColor: Colors.blue,
                unselectedLabelColor: Colors.grey,
              ),
              // Tab Bar View
              Expanded(
                child: TabBarView(
                  children: [
                    _buildBookingList(),
                    _buildBookingList(),
                    _buildBookingList(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBookingList() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildBookingCard(
          orderId: 'vxrayu265',
          status: 'START JOB',
          date: 'Thur 18-Apr',
          time: '1:30 PM',
        ),
        const SizedBox(height: 16),
        _buildBookingCard(
          orderId: 'vxrayu265',
          status: 'JOB DONE',
          date: 'Thur 18-Apr',
          time: '11:00 AM',
        ),
      ],
    );
  }

  Widget _buildBookingCard({
    required String orderId,
    required String status,
    required String date,
    required String time,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12), // reduced padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Order ID: $orderId',
                  style: const TextStyle(fontSize: 13), // reduced font size
                ),
                const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.check_circle, size: 14), // reduced icon size
                    Text(' Seen', style: TextStyle(fontSize: 13)),
                  ],
                ),
              ],
            ),
            Text(
              status,
              style: TextStyle(
                color: status == 'START JOB' ? Colors.green : Colors.blue,
                fontWeight: FontWeight.bold,
                fontSize: 13, // reduced font size
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Chip(
                      label: Text(date, style: const TextStyle(fontSize: 12)),
                      padding: const EdgeInsets.all(4), // reduced chip padding
                      labelPadding: const EdgeInsets.symmetric(horizontal: 4),
                    ),
                    const SizedBox(width: 4), // reduced spacing
                    Chip(
                      label: Text(time, style: const TextStyle(fontSize: 12)),
                      padding: const EdgeInsets.all(4),
                      labelPadding: const EdgeInsets.symmetric(horizontal: 4),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 0), // reduced padding
                  ),
                  child: const Text(
                    'Raise Concern',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.file_copy, size: 16),
                    label: const Text('Consent Form',
                        style: TextStyle(fontSize: 12)),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 0),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.star, size: 16),
                    label: const Text('Rate Customer',
                        style: TextStyle(fontSize: 12)),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 0),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
