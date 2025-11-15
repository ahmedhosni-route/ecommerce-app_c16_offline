import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

@singleton
class DioService {
  DioService() {
    init();
  }
  late Dio dio;

  void init() {
    dio = Dio(BaseOptions(
      baseUrl: "https://ecommerce.routemisr.com/api/v1",
      validateStatus: (status) => true,
    ));
    getToken();
    dio.interceptors.add(PrettyDioLogger(enabled: kDebugMode));
  }

  void updateToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("token", token);
    dio.options.headers.addAll({"token": token});
  }

  void getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    dio.options.headers.addAll({"token": token});
  }
}
