import 'package:ecommerce_app/features/auth/domain/repo/repo.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/api_response/api_response.dart';
import '../entity/user_entity.dart';

@injectable
class LoginUseCase {
  final AuthRepo _repo;
  LoginUseCase(this._repo);

  Future<ApiResponse<UserEntity>> call(String email, String password) =>
      _repo.login(email, password);
}
