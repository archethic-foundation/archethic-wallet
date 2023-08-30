import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateTimeUtil on DateTime {
  DateTime get startOfDay => DateTime(
        year,
        month,
        day,
      );
}

extension DurationUtil on Duration {
  Duration min(Duration other) => other < this ? other : this;
  Duration max(Duration other) => other > this ? other : this;
}

extension FormatDateTimeDependingDays on DateTime {
  String format(BuildContext context) {
    if (difference(DateTime.now()).inDays < 1) {
      return DateFormat().add_Hm().format(this);
    } else {
      if (difference(DateTime.now()).inDays < 30) {
        return DateFormat.MEd(
          Localizations.localeOf(context).languageCode,
        ).add_Hms().format(
              this,
            );
      } else {
        if (difference(DateTime.now()).inDays < 365) {
          return DateFormat.MMMEd(
            Localizations.localeOf(context).languageCode,
          ).add_Hms().format(
                this,
              );
        } else {
          return DateFormat.yMMMEd(
            Localizations.localeOf(context).languageCode,
          ).add_Hms().format(
                this,
              );
        }
      }
    }
  }
}
