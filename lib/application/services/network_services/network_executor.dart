import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kaktask/application/services/network_services/network_response.dart';

class NetworkExecutor {
  Future<NetworkResponse> _executeRequest(
    Future<http.Response> Function() requestFunction,
  ) async {
    try {
      final response = await requestFunction();
      return NetworkResponse(
        response.statusCode,
        response.body,
        response.headers,
        response.reasonPhrase ?? 'Unknown status',
      );
    } catch (e) {
      return NetworkResponse(
        -1,
        null,
        null,
        'Network error: $e',
      );
    }
  }

  Future<NetworkResponse> getRequest({
    required String url,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParams,
  }) async {
    final uri = Uri.parse(url).replace(queryParameters: queryParams);
    return _executeRequest(() => http.get(uri, headers: headers));
  }

  Future<NetworkResponse> postRequest({
    required String url,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
  }) async {
    return _executeRequest(
      () => http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(body),
      ),
    );
  }

  Future<NetworkResponse> putRequest({
    required String url,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
  }) async {
    return _executeRequest(
      () => http.put(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(body),
      ),
    );
  }

  Future<NetworkResponse> patchRequest({
    required String url,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
  }) async {
    return _executeRequest(
      () => http.patch(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(body),
      ),
    );
  }

  Future<NetworkResponse> deleteRequest({
    required String url,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
  }) async {
    return _executeRequest(
      () => http.delete(
        Uri.parse(url),
        headers: headers,
        body: body != null ? jsonEncode(body) : null,
      ),
    );
  }
}
