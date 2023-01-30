# Patrol documentation for the Archethic Wallet

Documentation is avaliable at :

- Their Gitlab repository https://github.com/leancodepl/patrol
- The Patrol_CLI repository https://github.com/leancodepl/patrol/tree/master/packages/patrol_cli
- The patrol official documentation https://patrol.leancode.co/
- The patrol library documentation https://pub.dev/documentation/patrol/latest/patrol/patrol-library.html
- https://pub.dev/packages/patrol

## Run the tests

All the tests are located in `integration_test`

To list the compatible connected devices and emulators

> patrol devices

To run all the tests :

Connect your device or launch your compatible Emulator

> patrol drive

To run a single specification :

> patrol drive --spec integration_test/<spec_file>_test.dart

To run Patrol on a spectfic device :

> patrol drive -D <device_name>

To update Patrol :

> patrol update

## Ignoring tests

By default, Patrol runs all the files ending with `_test.dart` and containing a `patrolTest` lock. You can ignore files by removing the test or adding a `_skip` just before the extension `<example>_test_skip.dart`

## TODOs / Improvements

- [ ] Script UCO retrieval from Faucet
- [ ] Watch Patrol improvements (Account popup selection does not work for an unknown reason)
- [ ] Implement a full scenario (`all_test_skip.dart`).
