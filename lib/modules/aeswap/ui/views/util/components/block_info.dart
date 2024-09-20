/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:ui';

import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

enum BlockInfoColor { blue, purple, green, black }

class BlockInfo extends ConsumerWidget {
  const BlockInfo({
    required this.info,
    this.width = 300,
    this.height = 170,
    this.blockInfoColor = BlockInfoColor.blue,
    this.backgroundWidget,
    this.bottomWidget,
    super.key,
  });

  final Widget info;
  final double width;
  final double height;
  final BlockInfoColor blockInfoColor;
  final Widget? backgroundWidget;
  final Widget? bottomWidget;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15),
          child: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Stack(
                children: [
                  if (backgroundWidget != null) backgroundWidget!,
                  Container(
                    width: width,
                    height: height,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      gradient: blockInfoColor == BlockInfoColor.blue
                          ? LinearGradient(
                              colors: [
                                aedappfm.AppThemeBase.sheetBackgroundTertiary
                                    .withOpacity(0.3),
                                aedappfm.AppThemeBase.sheetBackgroundTertiary
                                    .withOpacity(0.3),
                              ],
                              stops: const [0, 1],
                            )
                          : blockInfoColor == BlockInfoColor.purple
                              ? LinearGradient(
                                  colors: [
                                    aedappfm.ArchethicThemeBase.raspberry500
                                        .withOpacity(0.3),
                                    aedappfm.ArchethicThemeBase.raspberry500
                                        .withOpacity(0.3),
                                  ],
                                  stops: const [0, 1],
                                )
                              : blockInfoColor == BlockInfoColor.black
                                  ? LinearGradient(
                                      colors: [
                                        aedappfm.ArchethicThemeBase
                                            .paleTransparentBackground
                                            .withOpacity(0.8),
                                        aedappfm.ArchethicThemeBase
                                            .paleTransparentBackground
                                            .withOpacity(0.8),
                                      ],
                                      stops: const [0, 1],
                                    )
                                  : LinearGradient(
                                      colors: [
                                        aedappfm.ArchethicThemeBase
                                            .systemPositive300
                                            .withOpacity(0.3),
                                        aedappfm.ArchethicThemeBase
                                            .systemPositive600
                                            .withOpacity(0.3),
                                      ],
                                      stops: const [0, 1],
                                    ),
                      border: GradientBoxBorder(
                        gradient: blockInfoColor == BlockInfoColor.blue
                            ? LinearGradient(
                                colors: [
                                  aedappfm.AppThemeBase.sheetBorderTertiary
                                      .withOpacity(0.4),
                                  aedappfm.AppThemeBase.sheetBackgroundTertiary
                                      .withOpacity(0.4),
                                ],
                                stops: const [0, 1],
                              )
                            : blockInfoColor == BlockInfoColor.purple
                                ? LinearGradient(
                                    colors: [
                                      aedappfm.ArchethicThemeBase.raspberry500
                                          .withOpacity(0.3),
                                      aedappfm.ArchethicThemeBase.raspberry500
                                          .withOpacity(0.4),
                                    ],
                                    stops: const [0, 1],
                                  )
                                : blockInfoColor == BlockInfoColor.black
                                    ? LinearGradient(
                                        colors: [
                                          aedappfm
                                              .AppThemeBase.sheetBorderTertiary
                                              .withOpacity(0.4),
                                          aedappfm.AppThemeBase
                                              .sheetBackgroundTertiary
                                              .withOpacity(0.4),
                                        ],
                                        stops: const [0, 1],
                                      )
                                    : LinearGradient(
                                        colors: [
                                          aedappfm.ArchethicThemeBase
                                              .systemPositive100
                                              .withOpacity(0.2),
                                          aedappfm.ArchethicThemeBase
                                              .systemPositive300
                                              .withOpacity(0.2),
                                        ],
                                        stops: const [0, 1],
                                      ),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                        top: 8,
                        bottom: 8,
                      ),
                      child: info,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (bottomWidget != null)
          SizedBox(
            width: width,
            child: bottomWidget,
          ),
      ],
    );
  }
}
