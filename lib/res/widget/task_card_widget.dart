import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TaskCardWidget extends StatelessWidget {
  const TaskCardWidget({
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
                  Checkbox(value: false, onChanged: (v) {}),
                  Expanded(
                    child: Text(
                      'This is a task to do for today ',
                      maxLines: 4,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style:
                          Theme.of(context).textTheme.displayMedium!.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                    ),
                  ),
                ],
              ),
            ),
            SvgPicture.asset('assets/icons/delete_icon.svg')
          ],
        ),
      ),
    );
  }
}
