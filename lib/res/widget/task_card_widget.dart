import 'package:flutter/material.dart';
import 'package:kaktask/data/entities/created_task.dart';
import 'package:kaktask/res/widget/add_task_bottom_sheet.dart';
import 'package:kaktask/view_model/delete_task_view_model.dart';
import 'package:kaktask/view_model/get_created_task_view_model.dart';
import 'package:kaktask/view_model/update_task_view_model.dart';
import 'package:provider/provider.dart';

class TaskCardWidget extends StatefulWidget {
  final CreatedTask task;

  const TaskCardWidget({
    required this.task,
    super.key,
  });

  @override
  State<TaskCardWidget> createState() => _TaskCardWidgetState();
}

class _TaskCardWidgetState extends State<TaskCardWidget> {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<UpdateTaskViewModel>(context, listen: false);
    final deleteModel =
        Provider.of<DeleteTaskViewModel>(context, listen: false);
    return InkWell(
      onTap: _showBottomSheet,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: Colors.grey),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 4, bottom: 4, right: 8),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Checkbox(
                      value: widget.task.isCompleted,
                      onChanged: (bool? value) async {
                        if (value != null) {
                          await viewModel
                              .updateTask(
                            id: widget.task.sId,
                            title: widget.task.title,
                            description: widget.task.description,
                            isCompleted: value,
                          )
                              .then((value) {
                            if (value) {
                              _getUpdatedData();
                            }
                          });
                        }
                      },
                    ),
                    Expanded(
                      child: Text(
                        widget.task.description,
                        maxLines: 4,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style:
                            Theme.of(context).textTheme.displayMedium!.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  decoration: widget.task.isCompleted
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none,
                                  decorationThickness: 2,
                                ),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  deleteModel.deleteTask(id: widget.task.sId).then((value) {
                    if (value) {
                      _getUpdatedData();
                    }
                  });
                },
                child: Image.asset(
                  'assets/icons/delete_icon.png',
                  height: 34,
                  width: 34,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showBottomSheet() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (BuildContext context) {
        return AddTaskBottomSheet(
          isEditingMode: true,
          task: widget.task,
        );
      },
    );
  }

  void _getUpdatedData() {
    Provider.of<GetCreatedTaskViewModel>(context, listen: false)
        .getCreatedTask(limit: 20);
  }
}
