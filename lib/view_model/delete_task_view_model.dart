import 'package:flutter/material.dart';
import 'package:kaktask/application/services/network_services/entities/failure.dart';
import 'package:kaktask/repositories/task_management_repository.dart';

class DeleteTaskViewModel with ChangeNotifier {
  DeleteTaskViewModel(this._repository);

  final TaskManagementRepository _repository;

  bool _isLoading = false;

  bool get loading => _isLoading;

  Failure? _failure;

  Failure? get error => _failure;

  Future<bool> deleteTask({
    required String id,
  }) async {
    _isLoading = true;
    notifyListeners();
    final response = await _repository.deleteTask(
      id: id,
    );
    return response.fold(
      (error) {
        _failure = error;
        _isLoading = false;
        notifyListeners();
        return false;
      },
      (deleteTask) {
        _failure = null;
        _isLoading = false;
        notifyListeners();
        return true;
      },
    );
  }
}
