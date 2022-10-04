/// SPDX-License-Identifier: AGPL-3.0-or-later
// Project imports:
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
// Package imports:
import 'package:flutter_svg/flutter_svg.dart';

class NetworkDialog {
  static Future<NetworksSetting?> getDialog(
    BuildContext context,
    NetworksSetting curNetworksSetting,
  ) async {
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
          '${StateContainer.of(context).curTheme.assetsFolder!}${StateContainer.of(context).curTheme.logoAlone!}.png',
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
        return AlertDialog(
          title: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              AppLocalization.of(context)!.networksHeader,
              style: AppStyles.textStyleSize24W700EquinoxPrimary(context),
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            side: BorderSide(
              color: StateContainer.of(context).curTheme.text45!,
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
                                  '${StateContainer.of(context).curTheme.assetsFolder!}${StateContainer.of(context).curTheme.logoAlone!}.svg',
                                  height: 30,
                                ),
                                Text(
                                  StateContainer.of(context)
                                      .curNetwork
                                      .getDisplayName(context),
                                  style: AppStyles.textStyleSize10W100Primary(
                                    context,
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  AppLocalization.of(context)!
                                      .enterEndpointHeader,
                                  style: AppStyles.textStyleSize16W400Primary(
                                    context,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(16),
                            ),
                            side: BorderSide(
                              color:
                                  StateContainer.of(context).curTheme.text45!,
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
                                    labelText: AppLocalization.of(context)!
                                        .enterEndpoint,
                                    keyboardType: TextInputType.text,
                                    style: AppStyles.textStyleSize14W600Primary(
                                      context,
                                    ),
                                    inputFormatters: <TextInputFormatter>[
                                      LengthLimitingTextInputFormatter(28),
                                    ],
                                  ),
                                  Text(
                                    'http://xxx.xxx.xxx.xxx:xxxx',
                                    style: AppStyles.textStyleSize12W400Primary(
                                      context,
                                    ),
                                  ),
                                  if (endpointError != null)
                                    Container(
                                      margin: const EdgeInsets.only(
                                        top: 5,
                                        bottom: 5,
                                      ),
                                      child: Text(
                                        endpointError!,
                                        style: AppStyles
                                            .textStyleSize14W600Primary(
                                          context,
                                        ),
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
                                    AppButtonType.primary,
                                    AppLocalization.of(context)!.ok,
                                    Dimens.buttonTopDimens,
                                    onPressed: () async {
                                      endpointError = '';
                                      if (endpointController.text.isEmpty) {
                                        setState(() {
                                          endpointError =
                                              AppLocalization.of(context)!
                                                  .enterEndpointBlank;
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
                                            endpointError =
                                                AppLocalization.of(context)!
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
