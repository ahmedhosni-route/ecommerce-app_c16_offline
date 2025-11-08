import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

@singleton
class DioService {
  DioService() {
    init();
  }
  late Dio dio;

  void init() {
    dio = Dio(BaseOptions(
      baseUrl: "https://ecommerce.routemisr.com/api/v1",
    ));
    dio.interceptors.add(PrettyDioLogger(enabled: kDebugMode));
  }
}
