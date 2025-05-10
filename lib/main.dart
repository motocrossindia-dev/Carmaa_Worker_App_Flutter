import 'package:carmaa_worker_app/features/all_profiles/leaves/leaves_provider.dart';
import 'package:carmaa_worker_app/features/all_profiles/monthly_summary/monthly_summary_provider.dart';
import 'package:carmaa_worker_app/features/all_profiles/privacy_policy/privacy_policy_provider.dart';
import 'package:carmaa_worker_app/features/all_profiles/profile_account/profile_account_provider.dart';
import 'package:carmaa_worker_app/features/all_profiles/rate_us/reate_us_provider.dart';
import 'package:carmaa_worker_app/features/all_profiles/referral/referral_provider.dart';
import 'package:carmaa_worker_app/features/all_profiles/reviews/review_provider.dart';
import 'package:carmaa_worker_app/features/all_profiles/wallet/wallet_provider.dart';
import 'package:carmaa_worker_app/features/auth/login/login_provider.dart';
import 'package:carmaa_worker_app/features/auth/signup/signup_provider.dart';
import 'package:carmaa_worker_app/features/complete_account_individual/completed_account_individual_provider.dart';
import 'package:carmaa_worker_app/features/complete_account_workshop/complete_account_workshop_provider.dart';
import 'package:carmaa_worker_app/features/splahs/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const CarmaaApp());
}

class CarmaaApp extends StatelessWidget {
  const CarmaaApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoginProvider()),
        ChangeNotifierProvider(create: (context) => SignupProvider()),
        ChangeNotifierProvider(
            create: (contexgt) => CompleteAccountIndividualProvider()),
        ChangeNotifierProvider(
            create: (context) => CompleteAccountWorkshopProvider()),
        ChangeNotifierProvider(create: (context) => ProfileAccountProvider()),
        ChangeNotifierProvider(create: (context) => WalletProvider()),
        ChangeNotifierProvider(create: (context) => LeavesProvider()),
        ChangeNotifierProvider(create: (context) => ReferralProvider()),
        ChangeNotifierProvider(create: (context) => ReviewProvider()),
        ChangeNotifierProvider(create: (context) => MonthlySummaryProvider()),
        ChangeNotifierProvider(create: (context) => PrivacyPolicyProvider()),
        ChangeNotifierProvider(create: (context) => RateUsProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Carmaa Worker',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
