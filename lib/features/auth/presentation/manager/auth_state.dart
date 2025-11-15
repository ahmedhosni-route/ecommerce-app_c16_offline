part of 'auth_cubit.dart';

class AuthState {
  BaseState? loginState;
  BaseState? registerState;
  AuthState({
    this.loginState,
    this.registerState,
  });

  AuthState copyWith({
    BaseState? loginState,
    BaseState? registerState,
  }) {
    return AuthState(
      loginState: loginState ?? this.loginState,
      registerState: registerState ?? this.registerState,
    );
  }
}
