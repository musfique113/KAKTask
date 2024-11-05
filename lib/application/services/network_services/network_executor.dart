import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:kaktask/application/services/network_services/network_response.dart';

class NetworkExecutor {
  Future<NetworkResponse> _executeRequest(
    Future<http.Response> Function() requestFunction,
  ) async {
    try {
      final response = await requestFunction();

      // Log the response details
      if (kDebugMode) {
        print('Response Status Code: ${response.statusCode}');
      }
      if (kDebugMode) {
        print('Response Headers: ${response.headers}');
      }
      if (kDebugMode) {
        print('Response Body: ${response.body}');
      }

      return NetworkResponse(
        response.statusCode,
        jsonDecode(response.body),
        response.headers,
        response.reasonPhrase ?? 'Unknown status',
      );
    } catch (e) {
      if (kDebugMode) {
        print('Network error: $e');
      }
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
    final uri = Uri.parse(url).replace(
      queryParameters: queryParams?.map(
        (key, value) => MapEntry(
          key,
          value.toString(),
        ),
      ),
    );

    // Log the request details
    if (kDebugMode) {
      print('GET Request URL: $uri');
    }
    if (kDebugMode) {
      print('Headers: $headers');
    }

    if (kDebugMode) {
      print('QueryParams: $queryParams');
    }

    return _executeRequest(() => http.get(uri, headers: headers));
  }

  Future<NetworkResponse> postRequest({
    required String url,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
  }) async {
    // Log the request details
    if (kDebugMode) {
      print('POST Request URL: $url');
    }
    if (kDebugMode) {
      print('Headers: $headers');
    }
    if (kDebugMode) {
      print('Body: ${jsonEncode(body)}');
    }

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
    // Log the request details
    if (kDebugMode) {
      print('PUT Request URL: $url');
    }
    if (kDebugMode) {
      print('Headers: $headers');
    }
    if (kDebugMode) {
      print('Body: ${jsonEncode(body)}');
    }

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
    // Log the request details
    if (kDebugMode) {
      print('PATCH Request URL: $url');
    }
    if (kDebugMode) {
      print('Headers: $headers');
    }
    if (kDebugMode) {
      print('Body: ${jsonEncode(body)}');
    }

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
    // Log the request details
    if (kDebugMode) {
      print('DELETE Request URL: $url');
    }
    if (kDebugMode) {
      print('Headers: $headers');
    }
    if (kDebugMode) {
      print('Body: ${body != null ? jsonEncode(body) : 'No body'}');
    }

    return _executeRequest(
      () => http.delete(
        Uri.parse(url),
        headers: headers,
        body: body != null ? jsonEncode(body) : null,
      ),
    );
  }
}
