import 'package:carmaa_worker_app/features/auth/login/login_provider.dart';
import 'package:carmaa_worker_app/features/auth/signup/signup_screen.dart';
import 'package:carmaa_worker_app/features/main_layout/main_layout.dart';
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
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.12),
                Column(
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
                        onPressed: () {
                          loginProvider.sendOtp();
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => const MainLayout(),
                          //   ),
                          // );
                        },
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
                      onChanged: (value) =>
                          loginProvider.setOtp(value, context),
                      // onCompleted: (value) {
                      //   loginProvider.setOtp(value, context);
                      // },

                      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                      showCursor: true,
                      enabled: !loginProvider.isLoading,
                    ),
                    const SizedBox(height: 20),
                    if (loginProvider.isLoading)
                      const Center(
                        child: CircularProgressIndicator(),
                      ),

                    const SizedBox(height: 60),
                    const SizedBox(height: 20),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
