class NetworkResponse {
  final int statusCode;
  final String statusMessage;
  final dynamic body;
  final dynamic header;

  NetworkResponse(
      this.statusCode,
      this.body,
      this.header,
      this.statusMessage,
      );
}