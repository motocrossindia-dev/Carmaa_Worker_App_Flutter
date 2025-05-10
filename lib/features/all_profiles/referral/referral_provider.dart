import 'package:carmaa_worker_app/features/all_profiles/referral/referral_model.dart';
import 'package:flutter/material.dart';

class ReferralProvider extends ChangeNotifier {
  final List<Referral> _referralHistory = [
    Referral(
      name: 'Abdul Cb 20',
      status: 'expired',
      message: 'Referral expired, please refer again',
      isSuccess: false,
      date: DateTime.now().subtract(const Duration(days: 30)),
    ),
    Referral(
      name: 'Arslan',
      status: 'failed',
      message: 'No worries, Arslan can try again after 6 months',
      isSuccess: false,
      date: DateTime.now().subtract(const Duration(days: 20)),
    ),
    Referral(
      name: 'Sameer Ansari',
      status: 'joined',
      message: 'Congrats, You have earned ₹2500',
      isSuccess: true,
      date: DateTime.now().subtract(const Duration(days: 10)),
    ),
    Referral(
      name: 'Monish',
      status: 'joined',
      message: 'Congrats, You have earned ₹2500',
      isSuccess: true,
      date: DateTime.now().subtract(const Duration(days: 5)),
    ),
  ];

  List<Referral> get referralHistory => _referralHistory;

  void inviteFriend() {
    // Implement share functionality
    debugPrint('Invite friend clicked');
  }
}
