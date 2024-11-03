import 'package:flutter/material.dart';
import 'package:kaktask/res/widget/add_task_bottom_sheet.dart';
import 'package:kaktask/res/widget/empty_task_widget.dart';
import 'package:kaktask/res/widget/language_switch_button.dart';
import 'package:kaktask/res/widget/task_card_widget.dart';
import 'package:kaktask/res/widget/task_summary_title.dart';
import 'package:kaktask/res/widget/toggle_theme_button.dart';
import 'package:kaktask/view_model/get_created_task_view_model.dart';
import 'package:provider/provider.dart';

class AllTaskScreen extends StatefulWidget {
  const AllTaskScreen({super.key});

  @override
  State<AllTaskScreen> createState() => _AllTaskScreenState();
}

class _AllTaskScreenState extends State<AllTaskScreen> {
  bool showListView = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        Provider.of<GetCreatedTaskViewModel>(context, listen: false)
            .getCreatedTask(limit: 20);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      floatingActionButton: _buildFAB(),
      body: Consumer<GetCreatedTaskViewModel>(builder: (context, state, child) {
        if (state.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Visibility(
          visible: state.createdTasks.isNotEmpty,
          replacement: const EmptyTaskWidget(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                TaskSummaryTitle(
                  completed: state.completedTaskCount,
                  total: state.createdTasks.length,
                ),
                const SizedBox(height: 34),
                Expanded(
                  child: ListView.separated(
                    primary: false,
                    shrinkWrap: true,
                    reverse: true,
                    itemBuilder: (context, index) => TaskCardWidget(
                      task: state.createdTasks[index],
                    ),
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 8),
                    itemCount: state.createdTasks.length,
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }

  FloatingActionButton _buildFAB() {
    return FloatingActionButton(
      onPressed: _showBottomSheet,
      child: const Icon(Icons.add),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      actions: const [
        ThemeToggleWidget(),
        LanguageSwitchButton(),
      ],
    );
  }

  void _showBottomSheet() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (BuildContext context) {
        return const AddTaskBottomSheet();
      },
    );
  }
}
