import 'package:flutter/material.dart';
import 'package:kaktask/application/app_router.dart';

class AddTaskBottomSheet extends StatelessWidget {
  const AddTaskBottomSheet({
    super.key,
  });

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
        children: [
          TextFormField(),
          const SizedBox(height: 21),
          ElevatedButton(
            onPressed: () {
              AppRouter.pop(context);
            },
            child: const Text('ADD TASK'),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
