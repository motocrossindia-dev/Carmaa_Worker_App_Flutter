import 'package:flutter/material.dart';

class CompleteAccountWorkshopProvider extends ChangeNotifier {
  final TextEditingController cityController = TextEditingController();
  final TextEditingController workshopController = TextEditingController();
  bool workshopNotListed = false;

  void setWorkshopNotListed(bool value) {
    workshopNotListed = value;
    notifyListeners();
  }

  void submitForApproval(BuildContext context) {
    if (cityController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your city')),
      );
      return;
    }

    if (workshopController.text.trim().isEmpty && !workshopNotListed) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
                'Please enter your workshop or select Workshop Not Listed')),
      );
      return;
    }

    // TODO: Implement your API call or navigation logic here
    print('City: ${cityController.text}');
    print('Workshop: ${workshopController.text}');
    print('Workshop Not Listed: $workshopNotListed');
  }

  @override
  void dispose() {
    cityController.dispose();
    workshopController.dispose();
    super.dispose();
  }
}
