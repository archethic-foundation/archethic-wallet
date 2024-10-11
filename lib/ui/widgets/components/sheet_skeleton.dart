/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/widgets/components/scrollbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class SheetSkeleton extends ConsumerWidget {
  const SheetSkeleton({
    this.floatingActionButton,
    required this.appBar,
    required this.sheetContent,
    this.floatingActionButtonLocation =
        FloatingActionButtonLocation.centerFloat,
    this.thumbVisibility = true,
    this.menu = false,
    this.resizeToAvoidBottomInset = false,
    this.backgroundImage,
    this.bottomNavigationBar,
    super.key,
  });

  final Widget? floatingActionButton;
  final PreferredSizeWidget appBar;
  final Widget sheetContent;
  final bool thumbVisibility;
  final bool resizeToAvoidBottomInset;
  final bool menu;
  final String? backgroundImage;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Widget? bottomNavigationBar;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      drawerEdgeDragWidth: 0,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      bottomNavigationBar: bottomNavigationBar,
      extendBody: true,
      floatingActionButtonLocation: floatingActionButtonLocation,
      floatingActionButton: floatingActionButton,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: appBar,
      body: CupertinoScaffold(
        body: menu == false
            ? DecoratedBox(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      backgroundImage == null
                          ? ArchethicTheme.backgroundSmall
                          : backgroundImage!,
                    ),
                    fit: kIsWeb ? BoxFit.cover : BoxFit.fitHeight,
                    alignment: Alignment.centerRight,
                    opacity: 0.7,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    top:
                        MediaQuery.of(context).viewPadding.top + kToolbarHeight,
                  ),
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: ArchethicScrollbar(
                          thumbVisibility: thumbVisibility,
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: 20,
                              left: 15,
                              right: 15,
                              bottom:
                                  resizeToAvoidBottomInset ? 0 : bottom + 80,
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
      ),
    );
  }
}
