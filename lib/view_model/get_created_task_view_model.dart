import 'package:flutter/material.dart';
import 'package:kaktask/application/services/network_services/entities/failure.dart';
import 'package:kaktask/data/entities/created_task.dart';
import 'package:kaktask/repositories/task_management_repository.dart';

class GetCreatedTaskViewModel with ChangeNotifier {
  GetCreatedTaskViewModel(this._repository);

  final TaskManagementRepository _repository;

  bool _isLoading = true;

  bool get loading => _isLoading;

  List<CreatedTask> _createdTasks = [];

  List<CreatedTask> get createdTasks => _createdTasks;

  Failure? _failure;

  Failure? get error => _failure;

  Future<bool> getCreatedTask({int? limit}) async {
    _isLoading = true;
    notifyListeners();

    final response = await _repository.getCreatedTask(limit: limit);
    return response.fold(
      (error) {
        _failure = error;
        _createdTasks = [];
        _isLoading = false;
        notifyListeners();
        return false;
      },
      (tasks) {
        _createdTasks = tasks;
        _failure = null;
        _isLoading = false;
        notifyListeners();
        return true;
      },
    );
  }
}
