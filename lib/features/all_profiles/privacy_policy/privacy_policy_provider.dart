import 'package:flutter/material.dart';

class PrivacyPolicyProvider extends ChangeNotifier {
  final List<PrivacySection> sections = [
    PrivacySection(
      title: 'Information We Collect',
      content:
          'We collect information that you provide directly to us, including:'
          '\n\n• Personal Information (name, email address, phone number)'
          '\n• Location Data'
          '\n• Device Information'
          '\n• Usage Information',
    ),
    PrivacySection(
      title: 'How We Use Your Information',
      content: 'We use the information we collect to:'
          '\n\n• Provide and maintain our services'
          '\n• Process your payments'
          '\n• Send you notifications about work'
          '\n• Improve our services'
          '\n• Comply with legal obligations',
    ),
    PrivacySection(
      title: 'Data Security',
      content:
          'We implement appropriate security measures to protect your personal information.'
          '\n\nWe use industry-standard encryption and security protocols to ensure your data remains safe.',
    ),
    PrivacySection(
      title: 'Your Rights',
      content: 'You have the right to:'
          '\n\n• Access your personal data'
          '\n• Request correction of your data'
          '\n• Request deletion of your data'
          '\n• Withdraw consent',
    ),
  ];
}

class PrivacySection {
  final String title;
  final String content;

  PrivacySection({
    required this.title,
    required this.content,
  });
}
