import 'dart:developer';

import 'package:carmaa_worker_app/core/network/end_url.dart';
import 'package:carmaa_worker_app/features/widgets/flutter_toast_messages.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginRepository {
  final Dio _dio = Dio();

  Future<bool> sendOtp(String phone) async {
    try {
      final response = await _dio.post(
        EndUrl.sentOtpUrl,
        data: {'phone': phone},
        options: Options(
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );

      switch (response.statusCode) {
        case 200:
          return response.data['success'] ?? false;
        case 201:
          return response.data['success'] ?? false;
        case 400:
          ToastMessage.showErrorShort('Invalid phone number format');
          return false;
        case 404:
          ToastMessage.showErrorShort('Service not found');
          return false;
        case 429:
          ToastMessage.showErrorShort(
              'Too many attempts. Please try again later');
          return false;
        default:
          ToastMessage.showErrorShort('Unknown error occurred');
          return false;
      }
    } on DioException catch (e) {
      switch (e.response?.statusCode) {
        case 400:
          ToastMessage.showErrorShort('Invalid request');
          return false;
        case 401:
          ToastMessage.showErrorShort('Unauthorized access');
          return false;
        case 403:
          ToastMessage.showErrorShort('Access forbidden');
          return false;
        case 429:
          ToastMessage.showErrorShort('Too many requests');
          return false;
        default:
          ToastMessage.showErrorShort('Connection error');
          return false;
      }
    }
  }

  Future<Map<String, dynamic>?> verifyOtp(String phone, String otp) async {
    log('Phone: $phone, OTP: $otp');
    try {
      final response = await _dio.post(
        EndUrl.verifyOtpUrl,
        data: {
          'phone': phone,
          'otp': otp,
        },
        options: Options(
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );

      switch (response.statusCode) {
        case 200:
          if (response.data['success']) {
            try {
              final prefs = await SharedPreferences.getInstance();

              // Store tokens
              await prefs.setString(
                  'access_token', response.data['data']['access']);
              await prefs.setString(
                  'refresh_token', response.data['data']['refresh']);

              log("access_token: ${response.data['data']['access']}");
              // Store worker info
              final worker = response.data['data']['worker'];
              await prefs.setString('worker_id', worker['worker_id']);
              await prefs.setString('phone', worker['phone']);
              await prefs.setString('name', worker['name']);

              ToastMessage.showSuccessShort('OTP verified successfully');
              return response.data['data'];
            } catch (e) {
              ToastMessage.showErrorShort('Error storing user data');
              return null;
            }
          }
          return null;
        case 400:
          ToastMessage.showErrorShort('Invalid OTP');
          return null;
        case 401:
          ToastMessage.showErrorShort('Invalid credentials');
          return null;
        case 404:
          ToastMessage.showErrorShort('User not found');
          return null;
        case 422:
          ToastMessage.showErrorShort('Invalid input data');
          return null;
        default:
          ToastMessage.showErrorShort('Verification failed');
          return null;
      }
    } on DioException catch (e) {
      switch (e.response?.statusCode) {
        case 400:
          ToastMessage.showErrorShort('Invalid OTP format');
          return null;
        case 401:
          ToastMessage.showErrorShort('Unauthorized');
          return null;
        case 403:
          ToastMessage.showErrorShort('Access denied');
          return null;
        case 429:
          ToastMessage.showErrorShort('Too many verification attempts');
          return null;
        default:
          ToastMessage.showErrorShort('Network error');
          return null;
      }
    }
  }
}
