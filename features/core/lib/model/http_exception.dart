class ApiException implements Exception {
  final String message;
  bool? networkError;

  ApiException(this.message,{this.networkError});

  @override
  String toString() {
    return message;
    // return super.toString(); // Instance of HttpException
  }
}
