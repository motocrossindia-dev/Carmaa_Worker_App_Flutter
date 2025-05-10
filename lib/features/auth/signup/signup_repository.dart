import 'dart:developer';

import 'package:carmaa_worker_app/core/network/end_url.dart';
import 'package:dio/dio.dart';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

class SignupRepository {
  final Dio _dio = Dio();

  Future<Map<String, dynamic>> createWorkerProfile({
    required String name,
    required String email,
    required String location,
    required File? aadhar,
    required File? profilePhoto,
    required File? kycDocuments,
    required String roleType,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');
    try {
      // Create form data
      final formData = FormData.fromMap({
        'name': name,
        'email': email,
        'location': location,
        'role_type': roleType,
        if (aadhar != null)
          'aadhar': await MultipartFile.fromFile(
            aadhar.path,
            filename: aadhar.path.split('/').last,
          ),
        if (profilePhoto != null)
          'profile_photo': await MultipartFile.fromFile(
            profilePhoto.path,
            filename: profilePhoto.path.split('/').last,
          ),
        if (kycDocuments != null)
          'kyc_documents': await MultipartFile.fromFile(
            kycDocuments.path,
            filename: kycDocuments.path.split('/').last,
          ),
      });

      final response = await _dio.patch(
        EndUrl.reginsterWorkerUrl,
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token', // Add token in Bearer format
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          message: 'Failed to create worker profile',
        );
      }
    } on DioException catch (e) {
      log('Error: ${e.message}');
      if (e.response != null) {
        log('Response data: ${e.response?.data}');
        log('Response status code: ${e.response?.statusCode}');
      } else {
        log('Request failed: ${e.requestOptions.path}');
      }
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
