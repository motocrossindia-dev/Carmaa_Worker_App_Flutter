import 'dart:developer';

import 'package:carmaa_worker_app/features/all_profiles/leaves/leaves_screen.dart';
import 'package:carmaa_worker_app/features/all_profiles/monthly_summary/monthly_summary_screen.dart';
import 'package:carmaa_worker_app/features/all_profiles/privacy_policy/privacy_policy_screen.dart';
import 'package:carmaa_worker_app/features/all_profiles/profile_account/profile_account_screen.dart';
import 'package:carmaa_worker_app/features/all_profiles/rate_us/rateus_screen.dart';
import 'package:carmaa_worker_app/features/all_profiles/referral/referral_screen.dart';
import 'package:carmaa_worker_app/features/all_profiles/reviews/review_screen.dart';
import 'package:carmaa_worker_app/features/all_profiles/wallet/wallet_screen.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                            Icon(Icons.person, color: Colors.green, size: 12),
                            SizedBox(width: 4),
                            Text('Profile'),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Row(
                    children: [
                      Icon(Icons.copy),
                      SizedBox(width: 8),
                      Icon(Icons.notifications_outlined),
                    ],
                  ),
                ],
              ),
            ),
            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 8),
                ),
              ),
            ),
            // Menu Items
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _buildMenuItem(
                    Icons.person,
                    'Profile',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProfileAccountScreen(),
                        ),
                      );
                    },
                  ),
                  _buildMenuItem(Icons.location_on, 'Saved Address'),
                  _buildMenuItem(Icons.account_balance, 'Manage Bank Account'),
                  _buildMenuItem(Icons.money, 'Deduction/Fine'),
                  _buildMenuItem(
                    Icons.wallet,
                    'Saving Wallet',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const WalletScreen(),
                        ),
                      );
                    },
                  ),
                  _buildMenuItem(
                    Icons.calendar_today,
                    'Leaves',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LeavesScreen(),
                        ),
                      );
                    },
                  ),
                  _buildMenuItem(Icons.star, 'Rating Report'),
                  _buildMenuItem(Icons.book, 'Passbook'),
                  _buildMenuItem(Icons.work, 'Working Days'),
                  _buildMenuItem(Icons.language, 'Change Language'),
                  _buildMenuItem(
                    Icons.privacy_tip,
                    'Privacy Policy',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PrivacyPolicyScreen(),
                        ),
                      );
                    },
                  ),
                  _buildMenuItem(Icons.confirmation_number, 'Tickets'),
                  _buildMenuItem(
                    Icons.rate_review,
                    'Reviews',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ReviewScreen(),
                        ),
                      );
                    },
                  ),
                  _buildMenuItem(Icons.play_circle, 'Training Videos'),
                  _buildMenuItem(
                    Icons.card_giftcard,
                    'Referral',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ReferralScreen(),
                        ),
                      );
                    },
                  ),
                  _buildMenuItem(
                    Icons.star_rate,
                    'Rate Us',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RateUsScreen(),
                        ),
                      );
                    },
                  ),
                  _buildMenuItem(
                    Icons.summarize,
                    'Monthly Summary',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MonthlySummaryScreen(),
                        ),
                      );
                    },
                  ),
                  _buildMenuItem(Icons.logout, 'Logout'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, {VoidCallback? onTap}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.grey[600]),
        title: Text(title),
        trailing: const Icon(Icons.chevron_right),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        onTap: onTap,
      ),
    );
  }
}
