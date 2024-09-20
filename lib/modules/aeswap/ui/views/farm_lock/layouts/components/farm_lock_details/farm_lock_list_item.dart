import 'package:aewallet/modules/aeswap/domain/models/dex_farm_lock.dart';
import 'package:aewallet/modules/aeswap/ui/views/farm_lock/layouts/components/farm_lock_details/farm_lock_details_back.dart';
import 'package:aewallet/modules/aeswap/ui/views/farm_lock/layouts/components/farm_lock_details/farm_lock_details_front.dart';
import 'package:aewallet/modules/aeswap/ui/views/util/components/dex_archethic_uco.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FarmLockListItem extends ConsumerStatefulWidget {
  const FarmLockListItem({
    super.key,
    required this.farmLock,
    this.widthCard,
    this.heightCard,
    this.isInPopup = false,
  });

  final DexFarmLock farmLock;
  final double? widthCard;
  final double? heightCard;
  final bool? isInPopup;

  @override
  ConsumerState<FarmLockListItem> createState() => FarmLockListItemState();
}

class FarmLockListItemState extends ConsumerState<FarmLockListItem> {
  final flipCardController = FlipCardController();

  double? userBalance;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: aedappfm.SingleCard(
            globalPadding: 0,
            cardContent: Column(
              children: [
                SizedBox(
                  width: widget.widthCard,
                  height: widget.heightCard,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: FlipCard(
                      controller: flipCardController,
                      flipOnTouch: false,
                      fill: Fill.fillBack,
                      front: FarmLockDetailsFront(
                        farmLock: widget.farmLock,
                        userBalance: userBalance,
                        isInPopup: widget.isInPopup,
                      ),
                      back: FarmLockDetailsBack(
                        farmLock: widget.farmLock,
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: DexArchethicOracleUco(),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: -3,
          right: 20,
          child: Row(
            children: [
              SizedBox(
                height: 40,
                child: Card(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: aedappfm.ArchethicThemeBase.brightPurpleHoverBorder
                          .withOpacity(1),
                      width: 0.5,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 0,
                  color: aedappfm.ArchethicThemeBase.brightPurpleHoverBackground
                      .withOpacity(1),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 7,
                      bottom: 5,
                      left: 10,
                      right: 10,
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.farmCardTitle,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              InkWell(
                onTap: () async {
                  await flipCardController.toggleCard();
                  setState(() {});
                },
                child: SizedBox(
                  height: 40,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: aedappfm
                            .ArchethicThemeBase.brightPurpleHoverBorder
                            .withOpacity(1),
                        width: 0.5,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 0,
                    color: aedappfm
                        .ArchethicThemeBase.brightPurpleHoverBackground
                        .withOpacity(1),
                    child: const Padding(
                      padding: EdgeInsets.only(
                        top: 5,
                        bottom: 5,
                        left: 10,
                        right: 10,
                      ),
                      child: Icon(
                        aedappfm.Iconsax.convertshape,
                        size: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
