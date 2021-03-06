name: Flutter Integration Tests
on: [push, pull_request]
jobs:
  integration_tests:
    runs-on: ubuntu-20.04
    steps:
      - uses: actions/checkout@v2
      - uses: subosito/flutter-action@v1
      - run: flutter pub get
      - run: chromedriver --port=4444 &
      - run: flutter drive --driver=test_driver/integration_test.dart --target=integration_test/app_test.dart -d web-server
