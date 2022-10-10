/// SPDX-License-Identifier: AGPL-3.0-or-later
// Project imports:
import 'package:aewallet/application/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IconWidget extends ConsumerWidget {
  const IconWidget({
    required this.icon,
    required this.width,
    required this.height,
    this.color,
    super.key,
  });

  final String icon;
  final double width;
  final double height;
  final Color? color;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.read(ThemeProviders.theme);
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: theme.iconDrawerBackground!,
          ),
        ],
      ),
      alignment: AlignmentDirectional.center,
      child: SizedBox(
        child: icon.endsWith('svg')
            ? SvgPicture.asset(
                icon,
                color: color ?? theme.iconDrawer,
                height: height,
                width: width,
              )
            : Image.asset(
                icon,
                color: color ?? theme.iconDrawer,
              ),
      ),
    );
  }
}

class IconDataWidget extends StatelessWidget {
  const IconDataWidget({
    required this.icon,
    required this.width,
    required this.height,
    this.enabled = true,
    super.key,
  });

  final IconData icon;
  final double width;
  final double height;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return enabled
        ? _IconDataWidgetEnabled(
            width: width,
            height: height,
            icon: icon,
          )
        : _IconDataWidgetDisabled(
            width: width,
            height: height,
            icon: icon,
          );
  }
}

class _IconDataWidgetEnabled extends ConsumerWidget {
  const _IconDataWidgetEnabled({
    required this.icon,
    required this.width,
    required this.height,
  });

  final IconData icon;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.read(ThemeProviders.theme);

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: theme.iconDataWidgetIconBackground!,
          ),
        ],
      ),
      alignment: AlignmentDirectional.center,
      child: ShaderMask(
        child: SizedBox(
          child: Icon(
            icon,
            color: Colors.white,
            size: width,
          ),
        ),
        shaderCallback: (Rect bounds) {
          final rect = Rect.fromLTRB(0, 0, width, width);
          return theme.gradient!.createShader(rect);
        },
      ),
    );
  }
}

class _IconDataWidgetDisabled extends ConsumerWidget {
  const _IconDataWidgetDisabled({
    required this.icon,
    required this.width,
    required this.height,
  });

  final IconData icon;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.read(ThemeProviders.theme);
    return Container(
      width: width,
      height: height,
      alignment: AlignmentDirectional.center,
      child: SizedBox(
        child: Icon(
          icon,
          color: theme.text!.withOpacity(0.3),
          size: width,
        ),
      ),
    );
  }
}
