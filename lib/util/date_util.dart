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
