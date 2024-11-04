import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

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
    final locale = Localizations.localeOf(context).toString();
    final formattedCompleted = locale == 'bn'
        ? NumberFormat.decimalPattern('bn').format(completed)
        : completed.toString();
    final formattedTotal = locale == 'bn'
        ? NumberFormat.decimalPattern('bn').format(total)
        : total.toString();

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
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
                text: AppLocalizations.of(context)
                    .completedTaskCount(formattedCompleted, formattedTotal),
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
              ),
              TextSpan(
                text: AppLocalizations.of(context).completedTask,
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
