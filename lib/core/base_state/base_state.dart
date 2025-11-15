sealed class BaseState<T> {
  T? data;
  String? error;
  BaseState({this.data, this.error});
}

class LoadingState<T> extends BaseState<T> {}

class SuccessState<T> extends BaseState<T> {
  SuccessState({super.data});
}

class ErrorState<T> extends BaseState<T> {
  ErrorState({super.error});
}
