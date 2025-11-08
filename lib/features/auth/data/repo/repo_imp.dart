import 'package:ecommerce_app/features/auth/data/data_source/data_source.dart';
import 'package:ecommerce_app/features/auth/data/models/auth_response.dart';
import 'package:ecommerce_app/features/auth/domain/entity/user_entity.dart';
import 'package:ecommerce_app/features/auth/domain/repo/repo.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/api_response/api_response.dart';

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
        return Success(data: data.user!.toDomain(data.token ?? ""));
      } else {
        return Error(error: response.data.toString());
      }
    } catch (e) {
      return Error(error: e.toString());
    }
  }
}
