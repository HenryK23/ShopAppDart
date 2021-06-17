class HttpException implements Exception {
  var message;

  HttpException(this.message);

  @override
  String toString() {
    return message;
  }
}
