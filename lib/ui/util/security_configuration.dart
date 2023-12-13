import 'package:aewallet/model/authentication_method.dart';
import 'package:aewallet/ui/views/intro/layouts/intro_configure_security.dart';
import 'package:aewallet/ui/widgets/components/picker_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

typedef AuthMethodPickerItem = PickerItem<AuthMethod>;
mixin SecurityConfigurationMixin {
  Future<void> launchSecurityConfiguration(
    BuildContext context,
    WidgetRef ref,
    String seed,
    String name,
    String fromPage,
    Map<String, dynamic>? extra,
  ) async {
    context.go(
      IntroConfigureSecurity.routerPage,
      extra: {
        'seed': seed,
        'name': name,
        'fromPage': fromPage,
        'extra': extra,
      },
    );
  }
}
