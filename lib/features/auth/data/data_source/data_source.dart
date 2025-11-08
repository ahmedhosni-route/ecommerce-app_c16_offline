import 'package:dio/dio.dart';

abstract class AuthDataSource{
  Future<Response> login(String email,String password);
}