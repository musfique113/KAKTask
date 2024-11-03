import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:kaktask/application/app_configuration/base_url.dart';
import 'package:kaktask/application/services/network_services/entities/failure.dart';
import 'package:kaktask/application/services/network_services/entities/success.dart';
import 'package:kaktask/application/services/network_services/network_executor.dart';
import 'package:kaktask/application/services/network_services/network_response.dart';
import 'package:kaktask/data/entities/created_task.dart';
import 'package:kaktask/data/models/created_task_model.dart';

class TaskManagementRepository {
  final NetworkExecutor _networkExecutor;

  TaskManagementRepository(this._networkExecutor);

  final String _getCreatedTaskUrl = '$baseUrl/todos';

  Future<Either<Failure, List<CreatedTask>>> getCreatedTask(
      {int? limit}) async {
    Map<String, dynamic> queryParams = {
      'page': 1,
      'limit': limit ?? 15,
    };

    final NetworkResponse response = await _networkExecutor.getRequest(
      url: _getCreatedTaskUrl,
      queryParams: queryParams,
    );

    if (kDebugMode) {
      print('Response code: ${response.statusCode}');
      print('Data: ${response.body}');
    }
    if (response.statusCode == 200) {
      final List<dynamic> items = jsonDecode(response.body)['items'];
      final List<CreatedTask> tasks = items.map((item) {
        if (item is Map<String, dynamic>) {
          final model = CreatedTaskModel.fromJson(item);
          return model.toEntity();
        } else {
          throw Exception('Item is not a Map: $item');
        }
      }).toList();
      return Right(tasks);
    } else {
      return Left(Failure('Unexpected response format'));
    }
  }

  Future<Either<Failure, Success>> createNewTask({
    required String title,
    required String description,
  }) async {
    Map<String, dynamic> data = {
      "title": title,
      "description": description,
      "is_completed": true
    };

    final NetworkResponse response = await _networkExecutor.postRequest(
      url: _getCreatedTaskUrl,
      body: data,
      headers: {'Content-Type': 'application/json'},
    );

    if (kDebugMode) {
      print('Response code: ${response.statusCode}');
      print('Data: ${response.body}');
    }
    if (response.statusCode == 201) {
      return Right(Success(response.statusMessage));
    } else {
      final errorData = jsonDecode(response.body);
      return Left(
        Failure(errorData['message'] ?? 'Unexpected response format'),
      );
    }
  }
}
