import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'signup_provider.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final accountProvider = Provider.of<SignupProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              const Text(
                'Create Account',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Create your account to get started',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 32),

              // Name Input
              _buildInputField(
                icon: Icons.person_outline,
                label: 'Name',
                onChanged: accountProvider.setName,
              ),
              const SizedBox(height: 16),

              // Email Input
              _buildInputField(
                icon: Icons.email_outlined,
                label: 'Email (Optional)',
                onChanged: accountProvider.setEmail,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),

              // Address Input
              _buildInputField(
                icon: Icons.location_on_outlined,
                label: 'Address (Area/City)',
                onChanged: accountProvider.setLocation,
              ),
              const SizedBox(height: 16),

              // Upload Aadhar
              _buildUploadField(
                context: context,
                icon: Icons.upload_outlined,
                label: 'Upload Your Aadhar',
                onTap: () async {
                  final file = await accountProvider.pickFile();
                  if (file != null) {
                    accountProvider.setAadharDocument(file);
                  }
                },
                hasFile: accountProvider.aadharDocument != null,
              ),
              const SizedBox(height: 16),

              // Upload Photo
              _buildUploadField(
                context: context,
                icon: Icons.person_outline,
                label: 'Upload your Photo',
                onTap: () async {
                  final file = await accountProvider.pickFile();
                  if (file != null) {
                    accountProvider.setPhotoDocument(file);
                  }
                },
                hasFile: accountProvider.photoDocument != null,
              ),
              const SizedBox(height: 16),

              // Referral Code
              _buildInputField(
                icon: Icons.code,
                label: 'Referral Code (If any)',
                onChanged: (value) {},
              ),
              const SizedBox(height: 24),

              // Account Type
              const Text(
                'Choose your account Type',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 12),

              // Account Type Radio Buttons
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    RadioListTile<String>(
                      title: const Text('Individual'),
                      value: 'individual',
                      groupValue: accountProvider.roleType,
                      onChanged: (value) =>
                          accountProvider.setRoleType(value ?? 'individual'),
                    ),
                    Divider(height: 1, color: Colors.grey.shade300),
                    RadioListTile<String>(
                      title: const Text('Workshop'),
                      value: 'workshop',
                      groupValue: accountProvider.roleType,
                      onChanged: (value) =>
                          accountProvider.setRoleType(value ?? 'workshop'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Upload KYC Documents
              _buildUploadField(
                context: context,
                icon: Icons.upload_file_outlined,
                label: 'Upload your KYC documents(GST/Police Verification)',
                onTap: () async {
                  final file = await accountProvider.pickFile();
                  if (file != null) {
                    accountProvider.setKycDocuments(file);
                  }
                },
                hasFile: accountProvider.kycDocuments != null,
              ),
              const SizedBox(height: 16),

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
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'I allow to use the documents for Police verification',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Submit Button
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () async {
                    try {
                      final response = await accountProvider.submitAccount();
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(response['message'] ??
                                'Account created successfully!'),
                          ),
                        );
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
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Already registered
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already registered?',
                    style: TextStyle(color: Colors.black54),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'Log In',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required IconData icon,
    required String label,
    required Function(String) onChanged,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.grey.shade600, size: 20),
          hintText: label,
          hintStyle: TextStyle(color: Colors.grey.shade500),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
        onChanged: onChanged,
        keyboardType: keyboardType,
      ),
    );
  }

  Widget _buildUploadField({
    required BuildContext context,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    required bool hasFile,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.grey.shade600, size: 20),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  color: hasFile ? Colors.black : Colors.grey.shade500,
                ),
              ),
            ),
            if (hasFile)
              const Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 20,
              ),
          ],
        ),
      ),
    );
  }
}
