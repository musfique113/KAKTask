import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kaktask/application/app_router.dart';
import 'package:kaktask/data/entities/created_task.dart';
import 'package:kaktask/utils/show_snackbar_message.dart';
import 'package:kaktask/view_model/created_new_task_view_model.dart';
import 'package:kaktask/view_model/get_created_task_view_model.dart';
import 'package:kaktask/view_model/update_task_view_model.dart';
import 'package:provider/provider.dart';

class AddTaskBottomSheet extends StatefulWidget {
  const AddTaskBottomSheet({
    this.isEditingMode = false,
    this.task,
    super.key,
  });

  final bool? isEditingMode;
  final CreatedTask? task;

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  final TextEditingController _titleTE = TextEditingController();
  final TextEditingController _descTE = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.isEditingMode == true && widget.task != null) {
      _titleTE.text = widget.task!.title;
      _descTE.text = widget.task!.description;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 24,
        right: 24,
        top: 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context).title,
            style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _titleTE,
          ),
          const SizedBox(height: 12),
          Text(
            AppLocalizations.of(context).description,
            style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _descTE,
            maxLines: 8,
          ),
          const SizedBox(height: 21),
          widget.isEditingMode == true && widget.task != null
              ? Consumer<UpdateTaskViewModel>(
                  builder: (context, updateState, child) {
                  if (updateState.loading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ElevatedButton(
                    onPressed: () {
                      updateState
                          .updateTask(
                              id: widget.task!.sId,
                              title: _titleTE.text,
                              description: _descTE.text,
                              isCompleted: false)
                          .then(
                        (value) {
                          if (value) {
                            _getUpdatedData();
                            showSnackBarMessage(context, 'Task Updated');
                            AppRouter.pop(context);
                          } else {
                            showSnackBarMessage(
                              context,
                              updateState.error!.message,
                              isError: true,
                            );
                          }
                        },
                      );
                    },
                    child: Text(AppLocalizations.of(context).updateTask),
                  );
                })
              : Consumer<CreateNewTaskViewModel>(
                  builder: (context, createTask, child) {
                  if (createTask.loading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ElevatedButton(
                    onPressed: () {
                      createTask
                          .createNewTask(
                        title: _titleTE.text,
                        description: _descTE.text,
                      )
                          .then(
                        (value) {
                          if (value) {
                            _getUpdatedData();
                            showSnackBarMessage(context, 'New task added');
                            AppRouter.pop(context);
                          } else {
                            showSnackBarMessage(
                              context,
                              createTask.error!.message,
                              isError: true,
                            );
                          }
                        },
                      );
                    },
                    child: Text(AppLocalizations.of(context).addTask),
                  );
                }),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  void _getUpdatedData() {
    Provider.of<GetCreatedTaskViewModel>(context, listen: false)
        .getCreatedTask(limit: 20);
  }
}
