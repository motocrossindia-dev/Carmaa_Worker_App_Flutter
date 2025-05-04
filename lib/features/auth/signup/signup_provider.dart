import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'signup_repository.dart';

class SignupProvider extends ChangeNotifier {
  final SignupRepository _repository = SignupRepository();

  String _name = '';
  String _email = '';
  String _phoneNumber = '';
  String _location = '';
  File? _aadharDocument;
  File? _photoDocument;
  File? _kycDocuments;
  bool _allowPoliceVerification = false;
  String _roleType = 'individual'; // Default role type

  // Getters
  String get name => _name;
  String get email => _email;
  String get phoneNumber => _phoneNumber;
  String get location => _location;
  File? get aadharDocument => _aadharDocument;
  File? get photoDocument => _photoDocument;
  File? get kycDocuments => _kycDocuments;
  bool get allowPoliceVerification => _allowPoliceVerification;
  String get roleType => _roleType;

  // Setters
  void setName(String value) {
    _name = value;
    notifyListeners();
  }

  void setEmail(String value) {
    _email = value;
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

  void setRoleType(String value) {
    _roleType = value;
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

  Future<Map<String, dynamic>> submitAccount() async {
    // Validate required fields
    if (_name.isEmpty || _email.isEmpty || _location.isEmpty) {
      throw Exception('Please fill all required fields');
    }

    try {
      final response = await _repository.createWorkerProfile(
        name: _name,
        email: _email,
        location: _location,
        aadhar: 'dummy-aadhar', // Replace with actual aadhar number
        roleType: _roleType,
      );
      return response;
    } catch (e) {
      throw Exception('Failed to create account: $e');
    }
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
