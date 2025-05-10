import 'package:carmaa_worker_app/features/dashboard/booking/booking_screen.dart';
import 'package:carmaa_worker_app/features/dashboard/daily_doorstep/daily_doorstep_screen.dart';
import 'package:carmaa_worker_app/features/dashboard/marketplace/marketplace_screen.dart';
import 'package:carmaa_worker_app/features/dashboard/profile/profile_screen.dart';
import 'package:carmaa_worker_app/features/dashboard/stats/stats_screen.dart';
import 'package:flutter/material.dart';
// import '../daily_doorstep/daily_doorstep_screen.dart';
// import '../stats/stats_screen.dart';
// import '../marketplace/marketplace_screen.dart';
// import '../profile/profile_screen.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const BookingScreen(),
    const DailyDoorstepScreen(),
    const StatsScreen(),
    const MarketplaceScreen(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Booking',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.door_front_door),
            label: 'Daily Doorstep',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Stats',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Marketplace',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
