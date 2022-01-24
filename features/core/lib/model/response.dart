class ApiResponse<T> {
  String? errorMessage;
  T? responseData;

  ApiResponse({this.errorMessage, this.responseData});
}
