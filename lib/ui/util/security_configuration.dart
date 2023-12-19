import 'package:aewallet/ui/views/intro/layouts/intro_configure_security.dart';
import 'package:aewallet/ui/widgets/components/picker_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// TODO (redDwarf03) => BIG PB Lors de rebase........ à checker avec Dev
mixin SecurityConfigurationMixin {
  Future<bool> launchSecurityConfiguration(
    BuildContext context,
    WidgetRef ref,
    String name,
    String seed,
  ) async {
    final bool securityConfiguration = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return IntroConfigureSecurity(
            name: name,
            seed: seed,
          );
        },
      ),
    );

    return securityConfiguration;
  }

  static Future<List<PickerItem>> getPickerItemAuthMode(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final pickerItemsList = List<PickerItem>.empty(growable: true);
    return pickerItemsList;
  }
}
