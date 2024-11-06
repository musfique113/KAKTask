import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:kaktask/application/services/network_services/network_response.dart';

class NetworkExecutor {
  final bool printHeader = false;

  Future<NetworkResponse> _executeRequest(
    Future<http.Response> Function() requestFunction,
  ) async {
    try {
      final response = await requestFunction();

      if (kDebugMode) {
        log('Response Status Code: ${response.statusCode}');
      }
      if (printHeader) {
        log('Response Headers: ${response.headers}');
      }
      if (kDebugMode) {
        log('Response Body: ${response.body}');
      }

      return NetworkResponse(
        response.statusCode,
        jsonDecode(response.body),
        response.headers,
        response.reasonPhrase ?? 'Unknown status',
      );
    } catch (e) {
      if (kDebugMode) {
        log('Network error: $e');
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

    if (kDebugMode) {
      log('GET Request URL: $uri');
    }
    if (printHeader) {
      log('Headers: $headers');
    }

    if (kDebugMode) {
      log('QueryParams: $queryParams');
    }

    return _executeRequest(() => http.get(uri, headers: headers));
  }

  Future<NetworkResponse> postRequest({
    required String url,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
  }) async {
    if (kDebugMode) {
      log('POST Request URL: $url');
    }
    if (printHeader) {
      log('Headers: $headers');
    }
    if (kDebugMode) {
      log('Body: ${jsonEncode(body)}');
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
    if (kDebugMode) {
      log('PUT Request URL: $url');
    }
    if (printHeader) {
      log('Headers: $headers');
    }
    if (kDebugMode) {
      log('Body: ${jsonEncode(body)}');
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
    if (kDebugMode) {
      log('PATCH Request URL: $url');
    }
    if (printHeader) {
      log('Headers: $headers');
    }
    if (kDebugMode) {
      log('Body: ${jsonEncode(body)}');
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
    if (kDebugMode) {
      log('DELETE Request URL: $url');
    }
    if (printHeader) {
      log('Headers: $headers');
    }
    if (kDebugMode) {
      log('Body: ${body != null ? jsonEncode(body) : 'No body'}');
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
