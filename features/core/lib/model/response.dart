class ApiResponse<T> {
  String? errorMessage;
  T? responseData;
  bool? networkError;

  ApiResponse({this.errorMessage, this.responseData, this.networkError});
}
