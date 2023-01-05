class OperationQueue {
  static Future<Map<String, T>> run<T>(
    Iterable<Future<Map<String, T>> Function()> functions, {
    int nbRequest = 15,
    int durationInMillisecondsBetweenCall = 1000,
  }) async {
    final map = <String, T>{};

    var antiSpam = 0;
    final futures = <Future<Map<String, T>>>[];
    for (final function in functions) {
      // Delay the API call if we have made more than [nbRequest] requests
      if (antiSpam > 0 && antiSpam % nbRequest == 0) {
        await Future.delayed(
          Duration(milliseconds: durationInMillisecondsBetweenCall),
        );
      }

      // Make the API call and update the antiSpam counter
      futures.add(
        function(),
      );
      antiSpam++;
    }

    final results = await Future.wait(futures);
    for (final result in results) {
      map.addAll(result);
    }

    return map;
  }
}
