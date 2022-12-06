extension DateTimeUtil on DateTime {
  DateTime get startOfDay => DateTime(
        year,
        month,
        day,
        0,
        0,
        0,
      );
}

extension DurationUtil on Duration {
  Duration min(Duration other) => other < this ? other : this;
  Duration max(Duration other) => other > this ? other : this;
}
