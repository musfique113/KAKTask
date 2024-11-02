class CreatedTask {
  final String sId;
  final String createdAt;
  final String updatedAt;
  final String title;
  final String description;
  final bool isCompleted;

  CreatedTask({
    required this.sId,
    required this.createdAt,
    required this.updatedAt,
    required this.title,
    required this.description,
    required this.isCompleted,
  });
}
