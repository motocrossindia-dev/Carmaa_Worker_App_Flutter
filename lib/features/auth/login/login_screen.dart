import 'package:carmaa_worker_app/features/auth/login/login_provider.dart';
import 'package:carmaa_worker_app/features/auth/signup/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);

    // Default theme for Pinput
    final defaultPinTheme = PinTheme(
      width: 50,
      height: 50,
      textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(10),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                // Logo placeholder
                Center(
                  child: Image.asset(
                    'assets/logo/LOGO_04.png',
                    width: 150,
                    height: 150,
                  ),
                ),
                const SizedBox(height: 20),

                const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 20),
                // Phone Number Input
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Phone Number',
                    hintStyle: TextStyle(color: Colors.grey.shade400),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 16),
                  ),
                  keyboardType: TextInputType.phone,
                  onChanged: (value) => loginProvider.setPhoneNumber(value),
                ),
                const SizedBox(height: 20),
                // Send OTP Button
                SizedBox(
                  width: 120,
                  child: ElevatedButton(
                    onPressed: () => loginProvider.sendOtp(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text('Send OTP'),
                  ),
                ),
                const SizedBox(height: 24),
                // EnterOTP Text
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'EnterOTP',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(height: 12),
                // OTP Input Fields using Pinput
                Pinput(
                  length: 6,
                  defaultPinTheme: defaultPinTheme,
                  onChanged: (value) => loginProvider.setOtp(value),
                  onCompleted: (value) => loginProvider.setOtp(value),
                  pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                  showCursor: true,
                ),
                const SizedBox(height: 20),
                // Referral Code Checkbox
                Row(
                  children: [
                    Checkbox(
                      value: loginProvider.useReferralCode,
                      onChanged: loginProvider.toggleReferralCode,
                      activeColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const Text('Enter Refral Code (If Any)'),
                  ],
                ),
                const SizedBox(height: 10),
                // Referral Code Input
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Referral Code',
                    hintStyle: TextStyle(color: Colors.grey.shade400),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    contentPadding: const EdgeInsets.all(12),
                  ),
                  onChanged: (value) => loginProvider.setReferralCode(value),
                  enabled: loginProvider.useReferralCode,
                ),
                const SizedBox(height: 40),
                // Sign Up Button
                ElevatedButton(
                  onPressed: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignupScreen(),
                      ),
                    );
                    // bool success = await loginProvider.verifyAndSignUp();
                    // if (success && context.mounted) {
                    //   // Navigate to next screen on success
                    //   ScaffoldMessenger.of(context).showSnackBar(
                    //     const SnackBar(content: Text('Sign up successful!')),
                    //   );
                    // }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: const Text('Sign Up'),
                ),
                const SizedBox(height: 60),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
