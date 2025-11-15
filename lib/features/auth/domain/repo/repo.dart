import 'package:ecommerce_app/core/api_response/api_response.dart';
import 'package:ecommerce_app/features/auth/domain/entity/register_data.dart';
import 'package:ecommerce_app/features/auth/domain/entity/user_entity.dart';

abstract class AuthRepo {
  Future<ApiResponse<UserEntity>> login(String email,String password);
  Future<ApiResponse<UserEntity>> register(RegisterData data);
}