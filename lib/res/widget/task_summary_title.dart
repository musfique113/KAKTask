import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TaskSummaryTitle extends StatelessWidget {
  const TaskSummaryTitle({
    required this.total,
    required this.completed,
    super.key,
  });

  final int total;
  final int completed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context).todayTask,
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(
              height: 8,
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '($completed/$total) ',
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                  TextSpan(
                    text: AppLocalizations.of(context).emptyTask,
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            'CLEAR ALL',
            style: Theme.of(context).textTheme.displayLarge!.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  decoration: TextDecoration.underline,
                  decorationThickness: 1.5,
                ),
          ),
        ),
      ],
    );
  }
}
