import 'package:flutter/material.dart';
import 'review_model.dart';

class ReviewProvider extends ChangeNotifier {
  final List<Review> _reviews = [
    Review(
      customerName: 'Atul',
      rating: 4.0,
      remark: 'Great service, very professional',
      dateTime: DateTime.parse('2025-04-02 11:15:00'),
    ),
    Review(
      customerName: 'Amit',
      rating: 1.0,
      remark: 'Need improvement',
      dateTime: DateTime.parse('2025-04-01 13:15:00'),
    ),
    // Add more sample reviews here
  ];

  List<Review> get reviews => _reviews;
}
