import 'dart:developer';

import 'package:carmaa_worker_app/core/network/end_url.dart';
import 'package:dio/dio.dart';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

class ProfileAccountRepository {
  final Dio _dio = Dio(BaseOptions(
    headers: {
      'Authorization': 'Bearer YOUR_TOKEN', // Add your token here
    },
  ));

  Future<Map<String, dynamic>> getProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('access_token');
    try {
      final response = await _dio.get(EndUrl.getProfileUrl,
          options: Options(
            headers: {
              'Authorization': 'Bearer $token', // Add your token here
              'Content-Type': 'application/json',
            },
          ));
      return response.data;
    } on DioException catch (e) {
      log("error: ${e.response?.data}");
      throw Exception(e.response?.data['message'] ?? 'Failed to load profile');
    }
  }

  Future<bool> updateProfile({
    required String name,
    required String email,
    String? dateOfBirth,
    File? profilePhoto,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('access_token');
    try {
      FormData formData = FormData.fromMap({
        'name': name,
        'email': email,
        if (dateOfBirth != null) 'date_of_birth': dateOfBirth,
        if (profilePhoto != null)
          'profile_photo': await MultipartFile.fromFile(profilePhoto.path),
      });

      await _dio.patch(
        EndUrl.updateProfileUrl,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token', // Add your token here
            'Content-Type': 'application/json',
          },
        ),
        data: formData,
      );

      return true;
    } on DioException catch (e) {
      log("error: ${e.response?.data}");
      throw Exception(
          e.response?.data['message'] ?? 'Failed to update profile');
    }
  }
}
