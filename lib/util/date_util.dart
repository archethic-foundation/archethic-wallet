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
  String formatShort(BuildContext context) {
    final differenceAbs = difference(DateTime.now()).inDays.abs();

    if (differenceAbs < 1) {
      return DateFormat().add_Hm().format(this);
    }
    if (differenceAbs < 7) {
      return DateFormat.EEEE(
        Localizations.localeOf(context).languageCode,
      ).format(
        this,
      );
    }
    if (differenceAbs < 31) {
      return DateFormat.Md(
        Localizations.localeOf(context).languageCode,
      ).format(
        this,
      );
    }
    // > 1 month
    return DateFormat.yMd(
      Localizations.localeOf(context).languageCode,
    ).format(
      this,
    );
  }

  String formatLong(BuildContext context) {
    final differenceAbs = difference(DateTime.now()).inDays.abs();

    if (differenceAbs < 1) {
      return DateFormat().add_Hm().format(this);
    }
    if (differenceAbs < 30) {
      return DateFormat.MEd(
        Localizations.localeOf(context).languageCode,
      ).add_Hms().format(
            this,
          );
    }
    if (differenceAbs < 365) {
      return DateFormat.MMMEd(
        Localizations.localeOf(context).languageCode,
      ).add_Hms().format(
            this,
          );
    }
    return DateFormat.yMMMEd(
      Localizations.localeOf(context).languageCode,
    ).add_Hms().format(
          this,
        );
  }
}
