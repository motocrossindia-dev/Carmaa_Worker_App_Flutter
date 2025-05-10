import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'completed_account_individual_provider.dart';

class CompleteAccountIndividualScreen extends StatelessWidget {
  const CompleteAccountIndividualScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final accountProvider =
        Provider.of<CompleteAccountIndividualProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              const Text(
                'Complete Account',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),

              const Text(
                'Choose your account Type',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),

              // Account Type Radio Buttons
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    RadioListTile<String>(
                      title: const Text('Adhoc'),
                      value: 'adhoc',
                      groupValue: accountProvider.accountType,
                      onChanged: (value) =>
                          accountProvider.setAccountType(value ?? 'adhoc'),
                      activeColor: Colors.blue,
                    ),
                    Divider(height: 1, color: Colors.grey.shade300),
                    RadioListTile<String>(
                      title: const Text('Society/Apartment Cleaner'),
                      value: 'society',
                      groupValue: accountProvider.accountType,
                      onChanged: (value) =>
                          accountProvider.setAccountType(value ?? 'society'),
                      activeColor: Colors.blue,
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // Submit Button
              Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () async {
                      try {
                        await accountProvider.submitAccountType();
                        if (context.mounted) {
                          // Navigate to next screen
                        }
                      } catch (e) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(e.toString())),
                          );
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Submit',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
