import 'package:carmaa_worker_app/core/network/base_url.dart';

class EndUrl {
  static const String baseUrl = BaseUrl.baseUrl;
  static const String sentOtpUrl = '${baseUrl}worker/worker-auth/send-otp/';
  static const String verifyOtpUrl = '${baseUrl}worker/worker-auth/verify-otp/';
  static const String reginsterWorkerUrl =
      '${baseUrl}worker/worker-profile/create-worker/';
}
