import 'package:flutter/material.dart';
import 'package:kaktask/res/widget/add_task_bottom_sheet.dart';
import 'package:kaktask/res/widget/empty_task_widget.dart';
import 'package:kaktask/res/widget/language_switch_button.dart';
import 'package:kaktask/res/widget/task_card_widget.dart';
import 'package:kaktask/res/widget/task_summary_title.dart';
import 'package:kaktask/res/widget/toggle_theme_button.dart';

class AllTaskScreen extends StatefulWidget {
  const AllTaskScreen({super.key});

  @override
  State<AllTaskScreen> createState() => _AllTaskScreenState();
}

class _AllTaskScreenState extends State<AllTaskScreen> {
  bool showListView = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      floatingActionButton: _buildFAB(),
      body: Visibility(
        visible: !showListView,
        replacement: const EmptyTaskWidget(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              const TaskSummaryTitle(),
              const SizedBox(height: 34),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.only(bottom: 88),
                  primary: false,
                  shrinkWrap: true,
                  itemBuilder: (context, index) => const TaskCardWidget(),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 8),
                  itemCount: 24,
                ),
              )
            ],
          ),
        ),
      ),
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
