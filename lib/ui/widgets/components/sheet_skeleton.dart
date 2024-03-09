/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/widgets/components/scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SheetSkeleton extends ConsumerWidget {
  const SheetSkeleton({
    required this.floatingActionButton,
    required this.appBar,
    required this.sheetContent,
    this.thumbVisibility = true,
    this.menu = false,
    super.key,
  });

  final Widget floatingActionButton;
  final PreferredSizeWidget appBar;
  final Widget sheetContent;
  final bool? thumbVisibility;
  final bool? menu;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      drawerEdgeDragWidth: 0,
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: floatingActionButton,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: appBar,
      body: menu! == false
          ? DecoratedBox(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    ArchethicTheme.backgroundSmall,
                  ),
                  fit: MediaQuery.of(context).size.width >= 440
                      ? BoxFit.fitWidth
                      : BoxFit.fitHeight,
                  alignment: Alignment.centerRight,
                  opacity: 0.5,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).viewPadding.top + kToolbarHeight,
                ),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: ArchethicScrollbar(
                        thumbVisibility: thumbVisibility!,
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: 20,
                            left: 15,
                            right: 15,
                            bottom: bottom + 80,
                          ),
                          child: sheetContent,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : sheetContent,
    );
  }
}
