


import 'package:dio/dio.dart';

class CustomDio {
  static Dio _http;

  CustomDio() {
    if (_http == null)
      _http = Dio();
  }

  get client => _http;

  dispose() {
    _http.close();
  }
}