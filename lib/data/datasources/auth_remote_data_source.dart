import 'package:dio/dio.dart';
import 'package:keyur_practicle/core/api_client.dart';
import '../models/login_response.dart';

class AuthRemoteDataSource {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://app.happystories.io/api/V1/',
      headers: {'Accept-Language': 'en'},
    ),
  );

  AuthRemoteDataSource(ApiClient apiClient);

  Future<LoginResponse> login({
    required String email,
    required String password,
  }) async {
    try {
      final formData = FormData.fromMap({
        'email': email.trim(),
        'password': password.trim(),
        'device_id': '12345',
        'device_type': 'android',
        'device_token': 'dhsbchsbhsadsaded',
      });

      final response = await _dio.post('login', data: formData);

      if (response.statusCode == 200) {
        print("Response is =======> ${response.data}");
        return LoginResponse.fromJson(response.data);
      } else {
        throw Exception('Login failed: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      final msg = e.response?.data?['message'] ?? e.message ?? 'Unknown error';
      throw Exception('Login error: $msg');
    }
  }
}
