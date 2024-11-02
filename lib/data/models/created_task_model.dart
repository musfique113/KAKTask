import 'package:kaktask/data/entities/created_task.dart';

class CreatedTaskModel {
  String? sId;
  String? createdAt;
  String? updatedAt;
  String? title;
  String? description;
  bool? isCompleted;

  CreatedTaskModel(
      {this.sId,
      this.createdAt,
      this.updatedAt,
      this.title,
      this.description,
      this.isCompleted});

  CreatedTaskModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    title = json['title'];
    description = json['description'];
    isCompleted = json['is_completed'];
  }

  CreatedTask toEntity() => CreatedTask(
        sId: sId ?? '',
        createdAt: createdAt ?? '',
        updatedAt: updatedAt ?? '',
        title: title ?? '',
        description: description ?? '',
        isCompleted: isCompleted ?? false,
      );
}
