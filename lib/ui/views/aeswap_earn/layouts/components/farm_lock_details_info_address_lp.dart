import 'package:aewallet/modules/aeswap/domain/models/dex_farm_lock.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/app_styles.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/components/format_address_link_copy_big_icon.dart';
import 'package:aewallet/ui/widgets/components/sheet_detail_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FarmLockDetailsInfoAddressLP extends ConsumerWidget {
  const FarmLockDetailsInfoAddressLP({
    super.key,
    required this.farmLock,
  });

  final DexFarmLock farmLock;

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    return SheetDetailCard(
      children: [
        Expanded(
          child: FormatAddressLinkCopyBigIcon(
            address: farmLock.lpToken!.address.toUpperCase(),
            header:
                AppLocalizations.of(context)!.farmDetailsInfoAddressesLPAddress,
            typeAddress: TypeAddressLinkCopyBigIcon.chain,
            reduceAddress: true,
            fontSize: AppTextStyles.bodyMedium(context).fontSize!,
            iconSize: 26,
          ),
        ),
      ],
    );
  }
}
