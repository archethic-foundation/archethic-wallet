import 'package:collection/collection.dart';

extension ListExt<T> on List<T> {
  bool endsWith(
    List<T> other, [
    Equality<T> equality = const DefaultEquality(),
  ]) {
    if (length < other.length) return false;

    for (var i = 0; i < other.length; i++) {
      if (!equality.equals(
        this[length - i - 1],
        other[other.length - i - 1],
      )) {
        return false;
      }
    }
    return true;
  }
}
