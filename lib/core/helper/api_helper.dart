import 'package:dio/dio.dart';
import 'package:requests_inspector/requests_inspector.dart';

class ApiHelper {
  final Dio dio;

  ApiHelper({
    required String baseUrl,
    Duration? connectTimeout,
    Duration? receiveTimeout,
  }) : dio = Dio(
          BaseOptions(
            connectTimeout: connectTimeout ?? const Duration(seconds: 60),
            receiveTimeout: receiveTimeout ?? const Duration(seconds: 60),
            baseUrl: baseUrl,
            contentType: "application/json",
            responseType: ResponseType.json,
          ),
        )..interceptors.add(RequestsInspectorInterceptor());
}
