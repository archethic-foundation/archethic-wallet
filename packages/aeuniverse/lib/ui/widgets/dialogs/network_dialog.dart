/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aeuniverse/appstate_container.dart';
import 'package:aeuniverse/model/available_networks.dart';
import 'package:aeuniverse/ui/util/styles.dart';
import 'package:aeuniverse/ui/widgets/components/app_text_field.dart';
import 'package:aeuniverse/ui/widgets/components/buttons.dart';
import 'package:aeuniverse/ui/widgets/components/picker_item.dart';
import 'package:aeuniverse/util/preferences.dart';
import 'package:aeuniverse/util/service_locator.dart';
import 'package:core/localization.dart';
import 'package:core_ui/ui/util/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NetworkDialog {
  static Future<NetworksSetting?> getDialog(
      BuildContext context, NetworksSetting curNetworksSetting) async {
    FocusNode endpointFocusNode = FocusNode();
    TextEditingController endpointController = TextEditingController();
    String? endpointError;

    final Preferences preferences = await Preferences.getInstance();
    final List<PickerItem> pickerItemsList =
        List<PickerItem>.empty(growable: true);
    for (var value in AvailableNetworks.values) {
      pickerItemsList.add(PickerItem(
          NetworksSetting(value).getDisplayName(context),
          await NetworksSetting(value).getLink(),
          '${StateContainer.of(context).curTheme.assetsFolder!}${StateContainer.of(context).curTheme.logoAlone!}.png',
          null,
          value,
          true));
    }

    return await showDialog<NetworksSetting>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Text(
                AppLocalization.of(context)!.networksHeader,
                style: AppStyles.textStyleSize24W700EquinoxPrimary(context),
              ),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                side: BorderSide(
                    color: StateContainer.of(context).curTheme.text45!)),
            content: PickerWidget(
              pickerItems: pickerItemsList,
              selectedIndex: curNetworksSetting.getIndex(),
              onSelected: (value) async {
                preferences.setNetwork(
                    NetworksSetting(value.value as AvailableNetworks));

                curNetworksSetting =
                    NetworksSetting(value.value as AvailableNetworks);
                StateContainer.of(context).curNetwork = curNetworksSetting;

                if (value.value as AvailableNetworks ==
                    AvailableNetworks.ArchethicDevNet) {
                  endpointController.text = preferences.getNetworkDevEndpoint();
                  await showDialog<AvailableNetworks>(
                      barrierDismissible: false,
                      context: context,
                      builder: (BuildContext context) {
                        return StatefulBuilder(
                          builder: (context, setState) {
                            return AlertDialog(
                              title: Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: Column(children: [
                                  SvgPicture.asset(
                                    '${StateContainer.of(context).curTheme.assetsFolder!}${StateContainer.of(context).curTheme.logoAlone!}.svg',
                                    height: 30,
                                  ),
                                  Text(
                                      StateContainer.of(context)
                                          .curNetwork
                                          .getDisplayName(context),
                                      style:
                                          AppStyles.textStyleSize10W100Primary(
                                              context)),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    AppLocalization.of(context)!
                                        .enterEndpointHeader,
                                    style: AppStyles.textStyleSize16W400Primary(
                                        context),
                                  ),
                                ]),
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(16.0)),
                                  side: BorderSide(
                                      color: StateContainer.of(context)
                                          .curTheme
                                          .text45!)),
                              content: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      AppTextField(
                                        leftMargin: 0,
                                        rightMargin: 0,
                                        focusNode: endpointFocusNode,
                                        controller: endpointController,
                                        labelText: AppLocalization.of(context)!
                                            .enterEndpoint,
                                        keyboardType: TextInputType.text,
                                        style: AppStyles
                                            .textStyleSize14W600Primary(
                                                context),
                                        inputFormatters: <TextInputFormatter>[
                                          LengthLimitingTextInputFormatter(28),
                                        ],
                                      ),
                                      Text(
                                        'http://xxx.xxx.xxx.xxx:xxxx',
                                        style: AppStyles
                                            .textStyleSize12W400Primary(
                                                context),
                                      ),
                                      endpointError != null
                                          ? Container(
                                              margin: const EdgeInsets.only(
                                                  top: 5, bottom: 5),
                                              child: Text(endpointError!,
                                                  style: AppStyles
                                                      .textStyleSize14W600Primary(
                                                          context)),
                                            )
                                          : const SizedBox(),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      AppButton.buildAppButton(
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
                                              FocusScope.of(context)
                                                  .requestFocus(
                                                      endpointFocusNode);
                                            });
                                          } else {
                                            if (Uri.parse(
                                                        endpointController.text)
                                                    .isAbsolute ==
                                                false) {
                                              setState(() {
                                                endpointError =
                                                    AppLocalization.of(context)!
                                                        .enterEndpointNotValid;
                                                FocusScope.of(context)
                                                    .requestFocus(
                                                        endpointFocusNode);
                                              });
                                            } else {
                                              preferences.setNetworkDevEndpoint(
                                                  endpointController.text);
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
                      });
                }
                await setupServiceLocator();

                Navigator.pop(context, curNetworksSetting);
              },
            ),
          );
        });
  }
}
