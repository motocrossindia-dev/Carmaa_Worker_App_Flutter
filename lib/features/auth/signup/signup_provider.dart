import 'package:carmaa_worker_app/features/complete_account_individual/complete_account_individual_screen.dart';
import 'package:carmaa_worker_app/features/complete_account_workshop/complete_account_workshop_provider.dart';
import 'package:carmaa_worker_app/features/complete_account_workshop/complete_account_workshop_screen.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'signup_repository.dart';

class SignupProvider extends ChangeNotifier {
  final SignupRepository _repository = SignupRepository();
  bool _isLoading = false;
  bool get isLoading => _isLoading;

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

  Future<void> submitAccount(BuildContext context) async {
    // Validate required fields
    if (_name.isEmpty || _email.isEmpty || _location.isEmpty) {
      throw Exception('Please fill all required fields');
    }

    try {
      _isLoading = true;
      notifyListeners();
      final response = await _repository.createWorkerProfile(
        name: _name,
        email: _email,
        location: _location,
        aadhar: _aadharDocument,
        profilePhoto: _photoDocument,
        kycDocuments: _kycDocuments,
        roleType: _roleType,
      );

      if (_roleType == 'individual') {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content:
                  Text(response['message'] ?? 'Account created successfully!'),
            ),
          );
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CompleteAccountIndividualScreen(),
            ),
          );
        }
      } else if (_roleType == 'workshop') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text(response['message'] ?? 'Account created successfully!'),
          ),
        );

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const CompleteAccountWorkshopScreen(),
          ),
        );
      } else {
        throw Exception('Invalid role type selected');
      }

      // return response;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );

      throw Exception('Failed to create account: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
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
