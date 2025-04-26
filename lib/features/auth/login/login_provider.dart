import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  String _phoneNumber = '';
  String _otp = '';
  String _referralCode = '';
  bool _useReferralCode = false;

  String get phoneNumber => _phoneNumber;
  String get otp => _otp;
  String get referralCode => _referralCode;
  bool get useReferralCode => _useReferralCode;

  void setPhoneNumber(String value) {
    _phoneNumber = value;
    notifyListeners();
  }

  void setOtp(String value) {
    _otp = value;
    notifyListeners();
  }

  void setReferralCode(String value) {
    _referralCode = value;
    notifyListeners();
  }

  void toggleReferralCode(bool? value) {
    _useReferralCode = value ?? false;
    notifyListeners();
  }

  Future<void> sendOtp() async {
    // Here you would implement actual OTP sending logic
    print('Sending OTP to: $_phoneNumber');
    // Simulating API call
    await Future.delayed(const Duration(seconds: 1));
  }

  Future<bool> verifyAndSignUp() async {
    // Here you would implement actual verification and signup logic
    print('Verifying OTP: $_otp for phone: $_phoneNumber');
    if (_useReferralCode) {
      print('Using referral code: $_referralCode');
    }
    // Simulating API call
    await Future.delayed(const Duration(seconds: 1));
    return true; // Return success/failure
  }
}
