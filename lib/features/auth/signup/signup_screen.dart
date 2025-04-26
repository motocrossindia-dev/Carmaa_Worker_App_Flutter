import 'package:carmaa_worker_app/features/auth/signup/signup_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final accountProvider = Provider.of<SignupProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 60),
                // Create Account Title
                const Center(
                  child: Text(
                    'Create Account',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                // Subtitle
                const Center(
                  child: Text(
                    'Create your account to get started',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Name Input
                _buildInputField(
                  icon: Icons.person_outline,
                  hintText: 'Name',
                  onChanged: accountProvider.setName,
                ),
                const SizedBox(height: 12),

                // Phone Number Input
                _buildInputField(
                  icon: Icons.phone_outlined,
                  hintText: 'Phone Number',
                  onChanged: accountProvider.setPhoneNumber,
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 12),

                // Location Input
                _buildInputField(
                  icon: Icons.business_outlined,
                  hintText: 'Location',
                  onChanged: accountProvider.setLocation,
                ),
                const SizedBox(height: 12),

                // Upload Aadhar
                _buildUploadField(
                  context: context,
                  icon: Icons.upload_outlined,
                  text: 'Upload Your Aadhar',
                  onTap: () async {
                    final file = await accountProvider.pickFile();
                    if (file != null) {
                      accountProvider.setAadharDocument(file);
                    }
                  },
                  hasFile: accountProvider.aadharDocument != null,
                ),
                const SizedBox(height: 12),

                // Upload Photo
                _buildUploadField(
                  context: context,
                  icon: Icons.person_pin_outlined,
                  text: 'Upload your Photo',
                  onTap: () async {
                    final file = await accountProvider.pickFile();
                    if (file != null) {
                      accountProvider.setPhotoDocument(file);
                    }
                  },
                  hasFile: accountProvider.photoDocument != null,
                ),
                const SizedBox(height: 12),

                // Upload KYC Documents
                _buildUploadField(
                  context: context,
                  icon: Icons.file_upload_outlined,
                  text: 'Upload your KYC documents',
                  onTap: () async {
                    final file = await accountProvider.pickFile();
                    if (file != null) {
                      accountProvider.setKycDocuments(file);
                    }
                  },
                  hasFile: accountProvider.kycDocuments != null,
                ),
                const SizedBox(height: 20),

                // Police Verification Checkbox
                Row(
                  children: [
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: Checkbox(
                        value: accountProvider.allowPoliceVerification,
                        onChanged: accountProvider.togglePoliceVerification,
                        activeColor: Colors.blue,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: Text(
                        'I allow to use the documents for Police verification',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),

                // Submit Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      bool success = await accountProvider.submitAccount();
                      if (success && context.mounted) {
                        // Navigate to next screen or show success message
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Account created successfully!')),
                        );
                        // Navigate to next screen if needed
                      } else if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Please fill all required fields')),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    child: const Text('Submit'),
                  ),
                ),
                const SizedBox(height: 16),

                // Already registered text and Login link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already registered?',
                      style: TextStyle(fontSize: 14),
                    ),
                    TextButton(
                      onPressed: () {
                        // Navigate to login screen
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Log In',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),

                // Made with Visily
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required IconData icon,
    required String hintText,
    required Function(String) onChanged,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Row(
          children: [
            Icon(
              icon,
              size: 20,
              color: Colors.grey.shade700,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: TextStyle(color: Colors.grey.shade400),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onChanged: onChanged,
                keyboardType: keyboardType,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUploadField({
    required BuildContext context,
    required IconData icon,
    required String text,
    required VoidCallback onTap,
    required bool hasFile,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
          child: Row(
            children: [
              Icon(
                icon,
                size: 20,
                color: Colors.grey.shade700,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  text,
                  style: TextStyle(
                    color: hasFile ? Colors.black : Colors.grey.shade400,
                  ),
                ),
              ),
              if (hasFile)
                const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 18,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
