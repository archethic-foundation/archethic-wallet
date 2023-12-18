/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aewallet/application/device_abilities.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/model/data/appdb.dart';
import 'package:aewallet/model/data/contact.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/themes/archethic_theme_base.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/util/contact_formatters.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/formatters.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/views/main/components/sheet_appbar.dart';
import 'package:aewallet/ui/views/nft_creation/bloc/provider.dart';
import 'package:aewallet/ui/views/nft_creation/bloc/state.dart';
import 'package:aewallet/ui/views/nft_creation/layouts/get_addresses.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/app_text_field.dart';
import 'package:aewallet/ui/widgets/components/paste_icon.dart';
import 'package:aewallet/ui/widgets/components/scrollbar.dart';
import 'package:aewallet/ui/widgets/dialogs/contacts_dialog.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:aewallet/util/user_data_util.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';

part 'add_address.freezed.dart';
part 'add_address.g.dart';
part 'components/add_public_key_textfield_pk.dart';

@freezed
class AddAddressParams with _$AddAddressParams {
  const factory AddAddressParams({
    required String propertyName,
    required String propertyValue,
    required bool readOnly,
  }) = _AddAddressParams;
  const AddAddressParams._();

  factory AddAddressParams.fromJson(Map<String, dynamic> json) =>
      _$AddAddressParamsFromJson(json);
}

class AddAddress extends ConsumerStatefulWidget {
  const AddAddress({
    super.key,
    required this.propertyName,
    required this.propertyValue,
    required this.readOnly,
  });

  final String propertyName;
  final String propertyValue;
  final bool readOnly;

  static const String routerPage = 'add_address';

  @override
  ConsumerState<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends ConsumerState<AddAddress> {
  late ScrollController scrollController;

  @override
  void initState() {
    scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    final preferences = ref.watch(SettingsProviders.settings);
    final nftCreation = ref.watch(
      NftCreationFormProvider.nftCreationForm,
    );
    return Scaffold(
      drawerEdgeDragWidth: 0,
      extendBodyBehindAppBar: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: widget.readOnly == false
          ? Row(
              children: <Widget>[
                AppButtonTiny(
                  AppButtonTinyType.primary,
                  localizations.propertyAccessAddAccess,
                  Dimens.buttonBottomDimens,
                  key: const Key('addAddress'),
                  onPressed: () async {
                    sl.get<HapticUtil>().feedback(
                          FeedbackType.light,
                          preferences.activeVibrations,
                        );

                    ref
                        .read(
                          NftCreationFormProvider.nftCreationForm.notifier,
                        )
                        .addAddress(
                          widget.propertyName,
                          nftCreation.propertyAccessRecipient,
                          context,
                        );
                  },
                  disabled: !nftCreation.canAddAccess,
                ),
              ],
            )
          : const SizedBox.shrink(),
      backgroundColor: ArchethicTheme.background,
      appBar: SheetAppBar(
        title: widget.readOnly
            ? localizations.getPublicKeyHeader
            : localizations.addPublicKeyHeader,
        widgetLeft: BackButton(
          key: const Key('back'),
          color: ArchethicTheme.text,
          onPressed: () {
            context.pop();
          },
        ),
      ),
      body: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              ArchethicTheme.backgroundSmall,
            ),
            fit: BoxFit.fitHeight,
            opacity: 0.7,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 120, bottom: 100),
          child: Column(
            children: <Widget>[
              Expanded(
                child: ArchethicScrollbar(
                  child: Column(
                    children: <Widget>[
                      Text(
                        widget.propertyName,
                      ),
                      if (widget.propertyValue.isNotEmpty)
                        Text(
                          widget.propertyValue,
                        ),
                      if (widget.readOnly == false)
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Text(
                            localizations.propertyAccessDescription,
                            style:
                                ArchethicThemeStyles.textStyleSize12W100Primary,
                            textAlign: TextAlign.justify,
                          ),
                        )
                      else
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Text(
                            localizations.propertyAccessDescriptionReadOnly,
                            style:
                                ArchethicThemeStyles.textStyleSize12W100Primary,
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      if (widget.readOnly == false)
                        const AddPublicKeyTextFieldPk(),
                      if (widget.readOnly == false)
                        const SizedBox(
                          height: 20,
                        ),
                      GetAddresses(
                        propertyName: widget.propertyName,
                        propertyValue: widget.propertyValue,
                        readOnly: widget.readOnly,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
