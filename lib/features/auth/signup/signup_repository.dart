import 'package:carmaa_worker_app/core/network/end_url.dart';
import 'package:dio/dio.dart';

class SignupRepository {
  final Dio _dio = Dio();

  Future<Map<String, dynamic>> createWorkerProfile({
    required String name,
    required String email,
    required String location,
    required String aadhar,
    required String roleType,
  }) async {
    try {
      final response = await _dio.post(
        EndUrl.reginsterWorkerUrl,
        data: {
          'name': name,
          'email': email,
          'location': location,
          'aadhar': aadhar,
          'role_type': roleType,
        },
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
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
