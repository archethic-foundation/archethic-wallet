import 'package:aewallet/modules/aeswap/domain/models/dex_farm_lock.dart';
import 'package:aewallet/modules/aeswap/ui/views/farm_lock/layouts/components/farm_lock_details/farm_lock_details_level_single.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FarmLockDetailsBack extends ConsumerStatefulWidget {
  const FarmLockDetailsBack({
    super.key,
    required this.farmLock,
  });

  final DexFarmLock farmLock;

  @override
  FarmDetailsBackState createState() => FarmDetailsBackState();
}

class FarmDetailsBackState extends ConsumerState<FarmLockDetailsBack>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(
    BuildContext context,
  ) {
    super.build(context);

    return aedappfm.ArchethicScrollbar(
      child: Column(
        children: [
          ...widget.farmLock.stats.entries.map((entry) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: FarmLockDetailsLevelSingle(
                farmLock: widget.farmLock,
                level: entry.key,
                farmLockStats: entry.value,
              ),
            );
          }),
        ],
      ),
    );
  }
}
