/// SPDX-License-Identifier: AGPL-3.0-or-later
// Project imports:
import 'package:aewallet/application/theme.dart';
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/available_networks.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/widgets/components/app_text_field.dart';
import 'package:aewallet/ui/widgets/components/buttons.dart';
import 'package:aewallet/ui/widgets/components/picker_item.dart';
import 'package:aewallet/util/preferences.dart';
import 'package:aewallet/util/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Package imports:
import 'package:flutter_svg/flutter_svg.dart';

class NetworkDialog {
  static Future<NetworksSetting?> getDialog(
    BuildContext context,
    WidgetRef ref,
    NetworksSetting curNetworksSetting,
  ) async {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final endpointFocusNode = FocusNode();
    final endpointController = TextEditingController();
    String? endpointError;

    final preferences = await Preferences.getInstance();
    final pickerItemsList = List<PickerItem>.empty(growable: true);
    for (final value in AvailableNetworks.values) {
      pickerItemsList.add(
        PickerItem(
          NetworksSetting(value).getDisplayName(context),
          await NetworksSetting(value).getLink(),
          '${theme.assetsFolder!}${theme.logoAlone!}.png',
          null,
          value,
          true,
        ),
      );
    }

    return showDialog<NetworksSetting>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        final localizations = AppLocalization.of(context)!;
        final theme = ref.watch(ThemeProviders.selectedTheme);
        return AlertDialog(
          title: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              localizations.networksHeader,
              style: theme.textStyleSize24W700EquinoxPrimary,
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            side: BorderSide(
              color: theme.text45!,
            ),
          ),
          content: PickerWidget(
            pickerItems: pickerItemsList,
            selectedIndex: curNetworksSetting.getIndex(),
            onSelected: (value) async {
              preferences.setNetwork(
                NetworksSetting(value.value as AvailableNetworks),
              );

              final selectedNetworkSettings =
                  NetworksSetting(value.value as AvailableNetworks);
              StateContainer.of(context).curNetwork = selectedNetworkSettings;

              if (value.value as AvailableNetworks ==
                  AvailableNetworks.archethicDevNet) {
                endpointController.text = preferences.getNetworkDevEndpoint();
                await showDialog<AvailableNetworks>(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext context) {
                    return StatefulBuilder(
                      builder: (context, setState) {
                        return AlertDialog(
                          title: Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Column(
                              children: [
                                SvgPicture.asset(
                                  '${theme.assetsFolder!}${theme.logoAlone!}.svg',
                                  height: 30,
                                ),
                                Text(
                                  StateContainer.of(context)
                                      .curNetwork
                                      .getDisplayName(context),
                                  style: theme.textStyleSize10W100Primary,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  localizations.enterEndpointHeader,
                                  style: theme.textStyleSize16W400Primary,
                                ),
                              ],
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(16),
                            ),
                            side: BorderSide(
                              color: theme.text45!,
                            ),
                          ),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  AppTextField(
                                    leftMargin: 0,
                                    rightMargin: 0,
                                    focusNode: endpointFocusNode,
                                    controller: endpointController,
                                    labelText: localizations.enterEndpoint,
                                    keyboardType: TextInputType.text,
                                    style: theme.textStyleSize14W600Primary,
                                    inputFormatters: <TextInputFormatter>[
                                      LengthLimitingTextInputFormatter(28),
                                    ],
                                  ),
                                  Text(
                                    'http://xxx.xxx.xxx.xxx:xxxx',
                                    style: theme.textStyleSize12W400Primary,
                                  ),
                                  if (endpointError != null)
                                    Container(
                                      margin: const EdgeInsets.only(
                                        top: 5,
                                        bottom: 5,
                                      ),
                                      child: Text(
                                        endpointError!,
                                        style: theme.textStyleSize14W600Primary,
                                      ),
                                    )
                                  else
                                    const SizedBox(),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  AppButton.buildAppButtonTiny(
                                    const Key('addEndpoint'),
                                    context,
                                    ref,
                                    AppButtonType.primary,
                                    localizations.ok,
                                    Dimens.buttonTopDimens,
                                    onPressed: () async {
                                      endpointError = '';
                                      if (endpointController.text.isEmpty) {
                                        setState(() {
                                          endpointError =
                                              localizations.enterEndpointBlank;
                                          FocusScope.of(context).requestFocus(
                                            endpointFocusNode,
                                          );
                                        });
                                      } else {
                                        if (Uri.parse(
                                              endpointController.text,
                                            ).isAbsolute ==
                                            false) {
                                          setState(() {
                                            endpointError = localizations
                                                .enterEndpointNotValid;
                                            FocusScope.of(context).requestFocus(
                                              endpointFocusNode,
                                            );
                                          });
                                        } else {
                                          preferences.setNetworkDevEndpoint(
                                            endpointController.text,
                                          );
                                          Navigator.pop(context);
                                        }
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                );
              }
              await setupServiceLocator();

              Navigator.pop(context, selectedNetworkSettings);
            },
          ),
        );
      },
    );
  }
}
