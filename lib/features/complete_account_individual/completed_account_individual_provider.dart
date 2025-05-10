import 'package:flutter/material.dart';

class CompleteAccountIndividualProvider extends ChangeNotifier {
  String _accountType = 'adhoc'; // Default selection

  // Getter
  String get accountType => _accountType;

  // Setter
  void setAccountType(String type) {
    _accountType = type;
    notifyListeners();
  }

  // Submit function
  Future<void> submitAccountType() async {
    try {
      // TODO: Add API integration here
      // await repository.updateAccountType(_accountType);
    } catch (e) {
      throw Exception('Failed to update account type: $e');
    }
  }
}
