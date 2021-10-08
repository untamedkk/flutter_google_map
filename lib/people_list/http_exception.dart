class HttpException implements Exception {
  final int statusCode;
  final String message;

  HttpException(this.statusCode, this.message);
}
