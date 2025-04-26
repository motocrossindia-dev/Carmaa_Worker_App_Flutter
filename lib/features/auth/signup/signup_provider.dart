import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

// Account Creation Provider
class SignupProvider extends ChangeNotifier {
  String _name = '';
  String _phoneNumber = '';
  String _location = '';
  File? _aadharDocument;
  File? _photoDocument;
  File? _kycDocuments;
  bool _allowPoliceVerification = false;

  // Getters
  String get name => _name;
  String get phoneNumber => _phoneNumber;
  String get location => _location;
  File? get aadharDocument => _aadharDocument;
  File? get photoDocument => _photoDocument;
  File? get kycDocuments => _kycDocuments;
  bool get allowPoliceVerification => _allowPoliceVerification;

  // Setters
  void setName(String value) {
    _name = value;
    notifyListeners();
  }

  void setPhoneNumber(String value) {
    _phoneNumber = value;
    notifyListeners();
  }

  void setLocation(String value) {
    _location = value;
    notifyListeners();
  }

  void setAadharDocument(File? file) {
    _aadharDocument = file;
    notifyListeners();
  }

  void setPhotoDocument(File? file) {
    _photoDocument = file;
    notifyListeners();
  }

  void setKycDocuments(File? file) {
    _kycDocuments = file;
    notifyListeners();
  }

  void togglePoliceVerification(bool? value) {
    _allowPoliceVerification = value ?? false;
    notifyListeners();
  }

  Future<bool> submitAccount() async {
    // Validate required fields
    if (_name.isEmpty || _phoneNumber.isEmpty || _location.isEmpty) {
      return false;
    }

    // Here you would implement actual API call to create account
    print('Creating account with:');
    print('Name: $_name');
    print('Phone: $_phoneNumber');
    print('Location: $_location');
    print('Police verification allowed: $_allowPoliceVerification');

    // Simulating API call
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }

  Future<File?> pickFile() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }
}
