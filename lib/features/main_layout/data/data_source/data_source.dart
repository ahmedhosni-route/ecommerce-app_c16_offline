import 'package:dio/dio.dart';

abstract class MainDataSource{
  Future<Response> getCategory();
  Future<Response> getFav();
}