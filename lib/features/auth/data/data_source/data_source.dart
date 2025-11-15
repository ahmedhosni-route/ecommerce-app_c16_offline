import 'package:dio/dio.dart';
import 'package:ecommerce_app/features/auth/domain/entity/register_data.dart';

abstract class AuthDataSource{
  Future<Response> login(String email,String password);

  Future<Response> register(RegisterData data);
}