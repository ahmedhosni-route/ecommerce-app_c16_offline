part of 'auth_cubit.dart';

class AuthState {
  BaseState? loginState;
  AuthState({this.loginState});

  AuthState copyWith({BaseState? loginState}) {
    return AuthState(loginState: loginState ?? this.loginState);
  }
}
