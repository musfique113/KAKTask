import 'package:flutter/material.dart';
import 'package:kaktask/application/services/network_services/entities/failure.dart';
import 'package:kaktask/repositories/task_management_repository.dart';

class CreateNewTaskViewModel with ChangeNotifier {
  CreateNewTaskViewModel(this._repository);

  final TaskManagementRepository _repository;

  bool _isLoading = false;

  bool get loading => _isLoading;

  Failure? _failure;

  Failure? get error => _failure;

  Future<bool> createNewTask({
    required String title,
    required String description,
  }) async {
    _isLoading = true;
    notifyListeners();
    final response = await _repository.createNewTask(
      title: title,
      description: description,
    );
    return response.fold(
      (error) {
        _failure = error;
        _isLoading = false;
        notifyListeners();
        return false;
      },
      (addTask) {
        _failure = null;
        _isLoading = false;
        notifyListeners();
        return true;
      },
    );
  }

}
