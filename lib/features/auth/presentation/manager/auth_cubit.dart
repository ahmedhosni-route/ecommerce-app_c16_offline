import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/core/api_response/api_response.dart';
import 'package:ecommerce_app/core/base_state/base_state.dart';
import 'package:ecommerce_app/features/auth/domain/entity/register_data.dart';
import 'package:ecommerce_app/features/auth/domain/entity/user_entity.dart';
import 'package:ecommerce_app/features/auth/domain/repo/repo.dart';
import 'package:ecommerce_app/features/auth/domain/use_case/login_use_case.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._loginUseCase, this._repo) : super(AuthState());
  final LoginUseCase _loginUseCase;
  final AuthRepo _repo;

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Future<void> login() async {
    emit(
      state.copyWith(
        loginState: LoadingState(),
      ),
    );
    var result =
        await _loginUseCase.call(emailController.text, passwordController.text);

    switch (result) {
      case Success<UserEntity>():
        emit(state.copyWith(loginState: SuccessState(data: result.data)));

      case Error<UserEntity>():
        emit(state.copyWith(loginState: ErrorState(error: result.error)));
    }
  }

  Future<void> register() async {
    if (formKey.currentState!.validate()) {
      emit(state.copyWith(registerState: LoadingState()));
      var data = RegisterData(
          email: emailController.text,
          name: nameController.text,
          password: passwordController.text,
          phone: phoneController.text,
          rePassword: rePasswordController.text);
      var result = await _repo.register(data);

      switch (result) {
        case Success<UserEntity>():
          emit(state.copyWith(registerState: SuccessState(data: result.data!)));

        case Error<UserEntity>():
          emit(state.copyWith(registerState: ErrorState(error: result.error)));
      }
    }
  }
}
