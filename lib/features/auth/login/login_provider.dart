import 'dart:developer';

import 'package:carmaa_worker_app/features/auth/signup/signup_screen.dart';
import 'package:carmaa_worker_app/features/dashboard/dashboard_screen.dart';
import 'package:carmaa_worker_app/features/widgets/flutter_toast_messages.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'login_repository.dart';

class LoginProvider extends ChangeNotifier {
  final LoginRepository _repository = LoginRepository();
  String _phoneNumber = '';
  String _otp = '';
  bool _isLoading = false;

  String get phoneNumber => _phoneNumber;
  String get otp => _otp;
  bool get isLoading => _isLoading;

  void setPhoneNumber(String value) {
    _phoneNumber = value;
    notifyListeners();
  }

  void setOtp(String value, BuildContext context) {
    _otp = value;
    if (value.length == 6) {
      // Automatically verify when OTP is complete
      verifyOtp(context);
    }
    notifyListeners();
  }

  Future<void> sendOtp() async {
    _isLoading = true;
    notifyListeners();

    final success = await _repository.sendOtp(_phoneNumber);
    if (success) {
      ToastMessage.showInfoLong(
          "OTP sent successfully. Please enter otp down.");
    } else {
      ToastMessage.showErrorLong("Failed to send OTP. Please try again.");
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> verifyOtp(BuildContext contex) async {
    _isLoading = true;
    notifyListeners();

    final response = await _repository.verifyOtp(_phoneNumber, _otp);

    _isLoading = false;
    notifyListeners();

    if (response == null) {
      ToastMessage.showErrorLong("Failed to verify OTP. Please try again.");
      return;
    }

    if (response['success'] == false) {
      ToastMessage.showErrorLong("Invalid OTP. Please try again.");
      return;
    }

    log("Response: ${response.toString()}");

    if (response != null) {
      // Navigate based on 'created' flag
      if (!response['created']) {
        _navigateToSignup(contex);
      } else {
        _navigateToSignup(contex);
        // _navigateToDashboard(contex);
      }
    }
  }

  void _navigateToSignup(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const SignupScreen()),
    );
  }

  void _navigateToDashboard(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const DashboardScreen()),
    );
  }
}
