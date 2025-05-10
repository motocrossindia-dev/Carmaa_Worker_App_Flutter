import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'profile_account_repository.dart';

class ProfileAccountProvider extends ChangeNotifier {
  final ProfileAccountRepository _repository = ProfileAccountRepository();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController dobController = TextEditingController();

  File? imageFile;
  String? profileImageUrl;
  String? joinedDate;
  bool isEditing = false;
  bool isLoading = false;
  String? error;

  final ImagePicker _picker = ImagePicker();

  void toggleEdit() {
    isEditing = !isEditing;
    notifyListeners();
  }

  Future<void> getProfile() async {
    try {
      isLoading = true;
      error = null;
      notifyListeners();

      final response = await _repository.getProfile();
      final data = response['data'];

      nameController.text = data['name'] ?? '';
      phoneController.text = data['phone'] ?? '';
      emailController.text = data['email'] ?? '';
      dobController.text = data['date_of_birth'] ?? '';
      profileImageUrl = data['profile_photo'];
      joinedDate = data['joined_date'];

      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      error = e.toString();
      notifyListeners();
    }
  }

  Future<void> pickImage() async {
    if (!isEditing) return;

    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        imageFile = File(image.path);
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
    }
  }

  Future<void> updateProfile() async {
    if (!isEditing) return;

    try {
      isLoading = true;
      notifyListeners();

      final success = await _repository.updateProfile(
        name: nameController.text,
        email: emailController.text,
        dateOfBirth: dobController.text,
        profilePhoto: imageFile,
      );

      if (success) {
        isEditing = false;
        await getProfile(); // Refresh profile data
      }
    } catch (e) {
      error = e.toString();
      isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    dobController.dispose();
    super.dispose();
  }
}
