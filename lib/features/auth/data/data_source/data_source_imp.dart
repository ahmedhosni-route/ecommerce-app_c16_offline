import 'package:dio/src/response.dart';
import 'package:ecommerce_app/core/services/dio_service.dart';
import 'package:ecommerce_app/features/auth/data/data_source/data_source.dart';
import 'package:ecommerce_app/features/auth/domain/entity/register_data.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthDataSource)
class AuthDataSourceImp implements AuthDataSource {
  final DioService _dioService;
  AuthDataSourceImp(this._dioService);
  @override
  Future<Response> login(String email, String password) {
    return _dioService.dio
        .post("/auth/signin", data: {"email": email, "password": password});
  }

  @override
  Future<Response> register(RegisterData data) {
    return _dioService.dio.post("/auth/signup", data: data.toJson());
  }
}
