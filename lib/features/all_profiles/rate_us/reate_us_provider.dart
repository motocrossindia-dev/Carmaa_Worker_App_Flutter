import 'package:flutter/material.dart';

class RateUsProvider extends ChangeNotifier {
  int _rating = 0;
  String _feedback = '';
  bool _isSubmitting = false;
  String? _error;

  int get rating => _rating;
  String get feedback => _feedback;
  bool get isSubmitting => _isSubmitting;
  String? get error => _error;

  void setRating(int value) {
    _rating = value;
    notifyListeners();
  }

  void setFeedback(String value) {
    _feedback = value;
    notifyListeners();
  }

  Future<void> submitRating() async {
    if (_rating == 0) {
      _error = 'Please select a rating';
      notifyListeners();
      return;
    }

    try {
      _isSubmitting = true;
      _error = null;
      notifyListeners();

      // TODO: Implement API call here
      await Future.delayed(const Duration(seconds: 2)); // Simulate API call

      _isSubmitting = false;
      notifyListeners();

      // Reset after successful submission
      _rating = 0;
      _feedback = '';
    } catch (e) {
      _isSubmitting = false;
      _error = 'Failed to submit rating. Please try again.';
      notifyListeners();
    }
  }
}
