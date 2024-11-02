import 'package:flutter/material.dart';
import 'package:kaktask/view_model/get_created_task_view_model.dart';
import 'package:provider/provider.dart';

class CreatedTaskPage extends StatefulWidget {
  const CreatedTaskPage({super.key});

  @override
  State<CreatedTaskPage> createState() => _CreatedTaskPageState();
}

class _CreatedTaskPageState extends State<CreatedTaskPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<GetCreatedTaskViewModel>(context, listen: false)
          .getCreatedTask(limit: 10);
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<GetCreatedTaskViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Created Tasks')),
      body: viewModel.loading
          ? const Center(child: CircularProgressIndicator())
          : viewModel.error != null
              ? Center(child: Text(viewModel.error!.message))
              : ListView.builder(
                  itemCount: viewModel.createdTasks.length,
                  itemBuilder: (context, index) {
                    final task = viewModel.createdTasks[index];
                    return ListTile(
                      title: Text(task.title),
                      subtitle: Text(task.description),
                    );
                  },
                ),
    );
  }
}
