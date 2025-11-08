sealed class ApiResponse<T> {

}

class Success<T> extends ApiResponse<T> {
  T? data;
  Success({required this.data});
}

class Error<T> extends ApiResponse<T> {
  String error;

  Error({required this.error});
}
