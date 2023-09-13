extension StringExt on String {
  String breakText(int chars) {
    if (length <= chars) return this;
    return '${substring(0, chars)}\n${substring(chars).breakText(chars)}';
  }
}
