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

## Adding native actions for Android

From https://patrol.leancode.co/native/setup

Create an instrumentation test file in your application's `android\app\src\main\java\net\archethic\archethic_wallet\MainActivityArchethicWallet.java`

```java
package net.archethic.archethic_wallet

import org.junit.Rule;
import org.junit.runner.RunWith;
import pl.leancode.patrol.PatrolTestRule;
import pl.leancode.patrol.PatrolTestRunner;

@RunWith(PatrolTestRunner.class)
public class MainActivityTest {
    @Rule
    public PatrolTestRule<MainActivity> rule = new PatrolTestRule<>(MainActivity.class);
}
```

Next, update your app-level build.gradle:
`android/app/build.gradle`

```json
android {
  // ...
  defaultConfig {
    //...
    testInstrumentationRunner "androidx.test.runner.AndroidJUnitRunner"
  }
}

dependencies {
    testImplementation "junit:junit:4.13.2"
}
```

## For iOS

From https://patrol.leancode.co/native/setup.
For the iOS part, you can follow https://patrol.leancode.co/native/setup#integrate-with-native-side

## Testing

You can now use native commands in your tests :

```dart
void main() {
  patrolTest(
    'counter state is the same after going to Home and switching apps',
    nativeAutomation: true,
    nativeAutomatorConfig: NativeAutomatorConfig(
      packageName: 'pl.leancode.patrol.example',
      bundleId: 'pl.leancode.patrol.Example',
    ),
    ($) async {
      await $.pumpWidget(ExampleApp());

      await $(FloatingActionButton).tap();
      expect($(#counterText).text, '1');

      await $.native.pressHome();
      await $.native.openApp();

      expect($(#counterText).text, '1');

      await $(FloatingActionButton).tap();
      expect($(#counterText).text, '2');
    },
  );
}
```

## TODOs / Improvements

- [ ] Script UCO retrieval from Faucet
- [ ] Watch Patrol improvements (Account popup selection does not work for an unknown reason)
- [ ] Implement a full scenario (`all_test_skip.dart`).
