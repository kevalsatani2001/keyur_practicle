import 'package:dio/dio.dart';

class ApiClient {
  final Dio dio;
  ApiClient(this.dio) {
    dio.options.baseUrl = 'https://app.happystories.io/api/V1';
    dio.options.headers['Accept-Language'] = 'en';
    dio.options.connectTimeout = const Duration(seconds: 15);
  }

  Future<Response> postForm(String path, Map<String, dynamic> formMap) async {
    final formData = FormData.fromMap(formMap);
    return dio.post(path, data: formData);
  }
}
