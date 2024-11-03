import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kaktask/data/entities/created_task.dart';

class TaskCardWidget extends StatelessWidget {
  final CreatedTask task;
  final ValueChanged<bool?>? onTaskToggled;
  final VoidCallback? onDelete;

  const TaskCardWidget({
    required this.task,
    this.onTaskToggled,
    this.onDelete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.grey),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 4, bottom: 4, right: 4),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Checkbox(
                    value: task.isCompleted,
                    onChanged: onTaskToggled,
                  ),
                  Expanded(
                    child: Text(
                      task.description,
                      maxLines: 4,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style:
                          Theme.of(context).textTheme.displayMedium!.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                decoration: task.isCompleted
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
              onTap: onDelete,
              child: SvgPicture.asset('assets/icons/delete_icon.svg'),
            ),
          ],
        ),
      ),
    );
  }
}
