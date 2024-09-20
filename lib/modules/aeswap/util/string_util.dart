extension StringExtension on String? {
  String? capitalize() {
    if (this == null || this!.isEmpty) {
      return this;
    }
    if (this!.length == 1) {
      return this!.toUpperCase();
    }

    return this![0].toUpperCase() + this!.substring(1);
  }
}
