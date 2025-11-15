import 'package:ecommerce_app/core/services/dio_service.dart';
import 'package:ecommerce_app/features/auth/data/data_source/data_source.dart';
import 'package:ecommerce_app/features/auth/data/models/auth_response.dart';
import 'package:ecommerce_app/features/auth/domain/entity/register_data.dart';
import 'package:ecommerce_app/features/auth/domain/entity/user_entity.dart';
import 'package:ecommerce_app/features/auth/domain/repo/repo.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/api_response/api_response.dart';
import '../../../../core/config/get_it.dart';

@Injectable(as: AuthRepo)
class AuthRepoImp implements AuthRepo {
  final AuthDataSource _dataSource;
  AuthRepoImp(this._dataSource);
  @override
  Future<ApiResponse<UserEntity>> login(String email, String password) async {
    try {
      var response = await _dataSource.login(email, password);
      if (response.statusCode == 200) {
        var data = AuthResponse.fromJson(response.data);
        getIt<DioService>().updateToken(data.token!);
        return Success(data: data.user!.toDomain(data.token ?? ""));
      } else {
        return Error(error: response.data.toString());
      }
    } catch (e) {
      return Error(error: e.toString());
    }
  }

  @override
  Future<ApiResponse<UserEntity>> register(RegisterData data) async {
    try {
      var response = await _dataSource.register(data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = AuthResponse.fromJson(response.data);
        getIt<DioService>().updateToken(data.token!);
        return Success(data: data.user!.toDomain(data.token!));
      } else {
        return Error(error: response.data["message"]);
      }
    } catch (e) {
      return Error(error: e.toString());
    }
  }
}
