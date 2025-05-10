import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'profile_account_provider.dart';

class ProfileAccountScreen extends StatefulWidget {
  const ProfileAccountScreen({super.key});

  @override
  State<ProfileAccountScreen> createState() => _ProfileAccountScreenState();
}

class _ProfileAccountScreenState extends State<ProfileAccountScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProfileAccountProvider>().getProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          Consumer<ProfileAccountProvider>(
            builder: (context, provider, _) {
              return IconButton(
                icon: Icon(provider.isEditing ? Icons.close : Icons.edit),
                onPressed: provider.toggleEdit,
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Consumer<ProfileAccountProvider>(
          builder: (context, provider, _) {
            if (provider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (provider.error != null) {
              return Center(child: Text(provider.error!));
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Profile Image
                  GestureDetector(
                    onTap: provider.isEditing ? provider.pickImage : null,
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: provider.imageFile != null
                          ? FileImage(provider.imageFile!)
                          : provider.profileImageUrl != null
                              ? NetworkImage(provider.profileImageUrl!)
                              : null,
                      child: (provider.imageFile == null &&
                              provider.profileImageUrl == null)
                          ? const Icon(Icons.person, size: 60)
                          : null,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Form Fields
                  _buildTextField(
                    icon: Icons.person,
                    controller: provider.nameController,
                    hint: 'Name',
                    enabled: provider.isEditing,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    icon: Icons.phone,
                    controller: provider.phoneController,
                    hint: 'Phone',
                    enabled: false,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    icon: Icons.email,
                    controller: provider.emailController,
                    hint: 'Email',
                    enabled: provider.isEditing,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    icon: Icons.calendar_today,
                    controller: provider.dobController,
                    hint: 'Date of Birth',
                    enabled: provider.isEditing,
                  ),
                  const SizedBox(height: 24),

                  // Joined Date
                  if (provider.joinedDate != null)
                    Text(
                      'Joined on: ${provider.joinedDate!.substring(0, 10)}',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  const SizedBox(height: 24),

                  // Update Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed:
                          provider.isEditing ? provider.updateProfile : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            provider.isEditing ? Colors.blue : Colors.grey,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(2)),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text(
                        'Update Profile',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Rating Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ...List.generate(
                        5,
                        (index) => Icon(
                          index < 4 ? Icons.star : Icons.star_half,
                          color: Colors.amber,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        '4.75',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        ' (60 Reviews)',
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
//                   // Statistics Grid
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: 3,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      children: [
                        _buildStatCard(
                            '16-04-2024', 'Joining Date', Icons.calendar_today),
                        _buildStatCard('156', 'Work Days', Icons.work),
                        _buildStatCard(
                            '257 Jobs', 'Till Date', Icons.assignment),
                        _buildStatCard('233', 'Unique Customer', Icons.people),
                        _buildStatCard(
                            '20 Repeat', 'Unique Customer', Icons.refresh),
                        _buildStatCard('23', 'Excl Jobs', Icons.block),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTextField({
    required IconData icon,
    required TextEditingController controller,
    required String hint,
    bool enabled = true,
  }) {
    return TextField(
      controller: controller,
      enabled: enabled,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }

  Widget _buildStatCard(String value, String label, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 24),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
