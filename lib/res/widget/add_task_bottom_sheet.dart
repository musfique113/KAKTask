import 'package:flutter/material.dart';
import 'package:kaktask/application/app_router.dart';
import 'package:kaktask/view_model/created_new_task_view_model.dart';
import 'package:kaktask/view_model/get_created_task_view_model.dart';
import 'package:provider/provider.dart';

class AddTaskBottomSheet extends StatefulWidget {
  const AddTaskBottomSheet({
    super.key,
  });

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  final TextEditingController _titleTE = TextEditingController();
  final TextEditingController _descTE = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // final viewModel = Provider.of<CreateNewTaskViewModel>(context);
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
            'Title',
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
            'Description',
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
          Consumer<CreateNewTaskViewModel>(
            builder: (context, state, child) {
              if (state.loading) {
                return const Center(child: CircularProgressIndicator());
              }
              return ElevatedButton(
                onPressed: () {
                  state
                      .createNewTask(
                          title: _titleTE.text, description: _descTE.text)
                      .then((value) {
                    if (value) {
                      Provider.of<GetCreatedTaskViewModel>(context,
                              listen: false)
                          .getCreatedTask(limit: 20)
                          .then((value) {
                        if (value) {
                          AppRouter.pop(context);
                        }
                      });
                    } else {
                      showStatusMessageIfFailed('Cannot add');
                    }
                  });
                },
                child: const Text('ADD TASK'),
              );
            },
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  void showStatusMessageIfFailed(String status) {
    final snackBar = SnackBar(
      content: Text(
        status,
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.redAccent,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
