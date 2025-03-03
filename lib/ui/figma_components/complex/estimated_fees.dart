/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aewallet/ui/figma_components/custom_styles.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EstimatedFees extends ConsumerWidget {
  const EstimatedFees(
    this.feeEstimation, {
    super.key,
  });

  final AsyncValue<double>? feeEstimation;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    if (feeEstimation == null) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IntrinsicWidth(
            child: IntrinsicHeight(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                padding: const EdgeInsets.symmetric(
                  horizontal: 17,
                  vertical: 8.5,
                ),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: Icon(
                            aedappfm.Iconsax.receipt_disscount,
                            size: Theme.of(context)
                                .textTheme
                                .bodyMediumlWithOpacity
                                .fontSize,
                            color: Theme.of(context)
                                .textTheme
                                .bodyMediumlWithOpacity
                                .color,
                          ),
                        ),
                        Text(
                          '${localizations.estimatedFees} ',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMediumlWithOpacity,
                        ),
                        if (feeEstimation!.isLoading)
                          Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(
                                  top: 2,
                                  left: 5,
                                  right: 5,
                                ),
                                child: SizedBox(
                                  height: 10,
                                  width: 10,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 0.5,
                                  ),
                                ),
                              ),
                              Text(
                                ' UCO',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMediumlWithOpacity,
                              ),
                            ],
                          )
                        else
                          Text(
                            '${(feeEstimation?.valueOrNull ?? 0).formatNumber(precision: 2)} UCO',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMediumlWithOpacity,
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
