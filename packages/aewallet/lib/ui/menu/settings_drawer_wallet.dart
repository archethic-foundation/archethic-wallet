// Dart imports:
// ignore_for_file: always_specify_types

// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:aeuniverse/appstate_container.dart';
import 'package:aeuniverse/ui/util/settings_list_item.dart';
import 'package:aeuniverse/ui/util/styles.dart';
import 'package:aeuniverse/ui/util/ui_util.dart';
import 'package:aeuniverse/ui/widgets/components/sheet_util.dart';
import 'package:aewallet/ui/views/contacts/contact_list.dart';
import 'package:aewallet/ui/views/nft/add_nft.dart';
import 'package:aewallet/ui/views/settings/wallet_faq_widget.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:core/localization.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SettingsSheetWallet extends StatefulWidget {
  const SettingsSheetWallet({Key? key}) : super(key: key);

  @override
  _SettingsSheetWalletState createState() => _SettingsSheetWalletState();
}

class _SettingsSheetWalletState extends State<SettingsSheetWallet>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  AnimationController? _contactsController;
  Animation<Offset>? _contactsOffsetFloat;
  AnimationController? _nftController;
  Animation<Offset>? _nftOffsetFloat;
  AnimationController? _walletFAQController;
  Animation<Offset>? _walletFAQOffsetFloat;
  AnimationController? _aboutController;
  Animation<Offset>? _aboutOffsetFloat;

  String versionString = '';

  bool? _aboutOpen;
  bool? _contactsOpen;
  bool? _walletFAQOpen;
  bool? _nftOpen;

  bool notNull(Object? o) => o != null;

  @override
  void initState() {
    super.initState();
    _contactsOpen = false;
    _aboutOpen = false;
    _walletFAQOpen = false;
    _nftOpen = false;

    _contactsController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 220),
    );
    _aboutController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 220),
    );
    _walletFAQController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 220),
    );
    _nftController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 220),
    );
    _contactsOffsetFloat =
        Tween<Offset>(begin: const Offset(1.1, 0), end: const Offset(0, 0))
            .animate(_contactsController!);
    _aboutOffsetFloat =
        Tween<Offset>(begin: const Offset(1.1, 0), end: const Offset(0, 0))
            .animate(_aboutController!);
    _walletFAQOffsetFloat =
        Tween<Offset>(begin: const Offset(1.1, 0), end: const Offset(0, 0))
            .animate(_walletFAQController!);
    _nftOffsetFloat =
        Tween<Offset>(begin: const Offset(1.1, 0), end: const Offset(0, 0))
            .animate(_nftController!);
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      setState(() {
        versionString =
            AppLocalization.of(context)!.version + ' ${packageInfo.version}';
      });
    });
  }

  @override
  void dispose() {
    _contactsController!.dispose();
    _aboutController!.dispose();
    _walletFAQController!.dispose();
    _nftController!.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused:
        super.didChangeAppLifecycleState(state);
        break;
      case AppLifecycleState.resumed:
        super.didChangeAppLifecycleState(state);
        break;
      default:
        super.didChangeAppLifecycleState(state);
        break;
    }
  }

  Future<bool> _onBackButtonPressed() async {
    if (_contactsOpen!) {
      setState(() {
        _contactsOpen = false;
      });
      _contactsController!.reverse();
      return false;
    } else if (_aboutOpen!) {
      setState(() {
        _aboutOpen = false;
      });
      _aboutController!.reverse();
      return false;
    } else if (_walletFAQOpen!) {
      setState(() {
        _walletFAQOpen = false;
      });
      _walletFAQController!.reverse();
      return false;
    } else if (_nftOpen!) {
      setState(() {
        _nftOpen = false;
      });
      _nftController!.reverse();
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackButtonPressed,
      child: ClipRect(
        child: Stack(
          children: <Widget>[
            Container(
              color: StateContainer.of(context).curTheme.backgroundDark,
              constraints: const BoxConstraints.expand(),
            ),
            buildMainSettings(context),
            SlideTransition(
                position: _contactsOffsetFloat!,
                child: ContactsList(_contactsController!, _contactsOpen!)),
            SlideTransition(
                position: _aboutOffsetFloat!, child: buildAboutMenu(context)),
            SlideTransition(
                position: _walletFAQOffsetFloat!,
                child: WalletFAQ(_walletFAQController!, _walletFAQOpen!)),
            SlideTransition(
                position: _nftOffsetFloat!, child: buildNFTMenu(context)),
          ],
        ),
      ),
    );
  }

  Widget buildMainSettings(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: StateContainer.of(context).curTheme.backgroundDark,
          border: Border(
            right: BorderSide(
                color: StateContainer.of(context).curTheme.primary30!,
                width: 1),
          )),
      child: SafeArea(
        minimum: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + 30,
        ),
        child: Column(
          children: <Widget>[
            // Settings items
            Expanded(
                child: Stack(
              children: <Widget>[
                ListView(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsetsDirectional.only(
                          top: 10.0, bottom: 10.0),
                      child: Text(AppLocalization.of(context)!.manage,
                          style: AppStyles.textStyleSize20W700Primary(context)),
                    ),
                    if (StateContainer.of(context).wallet != null &&
                        StateContainer.of(context).wallet!.accountBalance.uco !=
                            null &&
                        StateContainer.of(context).wallet!.accountBalance.uco! >
                            0)
                      Divider(
                        height: 2,
                        color: StateContainer.of(context).curTheme.primary15,
                      )
                    else
                      const SizedBox(),
                    if (StateContainer.of(context).wallet != null &&
                        StateContainer.of(context).wallet!.accountBalance.uco !=
                            null &&
                        StateContainer.of(context).wallet!.accountBalance.uco! >
                            0)
                      AppSettings.buildSettingsListItemSingleLineWithInfos(
                          context,
                          AppLocalization.of(context)!.nftHeader,
                          AppLocalization.of(context)!.nftHeaderDesc,
                          icon: 'packages/aewallet/assets/icons/nft.png',
                          iconColor: StateContainer.of(context)
                              .curTheme
                              .iconDrawerColor!, onPressed: () {
                        setState(() {
                          _nftOpen = true;
                        });
                        _nftController!.forward();
                      })
                    else
                      const SizedBox(),
                    Divider(
                      height: 2,
                      color: StateContainer.of(context).curTheme.primary15,
                    ),
                    AppSettings.buildSettingsListItemSingleLineWithInfos(
                        context,
                        AppLocalization.of(context)!.addressBookHeader,
                        AppLocalization.of(context)!.addressBookDesc,
                        icon: 'packages/aewallet/assets/icons/address-book.png',
                        iconColor: StateContainer.of(context)
                            .curTheme
                            .iconDrawerColor!, onPressed: () {
                      setState(() {
                        _contactsOpen = true;
                      });
                      _contactsController!.forward();
                    }),
                    Divider(
                      height: 2,
                      color: StateContainer.of(context).curTheme.primary15,
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsetsDirectional.only(
                          top: 20.0, bottom: 10.0),
                      child: Text(AppLocalization.of(context)!.informations,
                          style: AppStyles.textStyleSize20W700Primary(context)),
                    ),
                    Divider(
                      height: 2,
                      color: StateContainer.of(context).curTheme.primary15,
                    ),
                    AppSettings.buildSettingsListItemSingleLineWithInfos(
                        context,
                        AppLocalization.of(context)!.walletFAQHeader,
                        AppLocalization.of(context)!.walletFAQDesc,
                        icon: 'packages/aewallet/assets/icons/faq.png',
                        iconColor: StateContainer.of(context)
                            .curTheme
                            .iconDrawerColor!, onPressed: () {
                      setState(() {
                        _walletFAQOpen = true;
                      });
                      _walletFAQController!.forward();
                    }),
                    Divider(
                      height: 2,
                      color: StateContainer.of(context).curTheme.primary15,
                    ),
                    AppSettings.buildSettingsListItemSingleLine(
                        context,
                        AppLocalization.of(context)!.aboutHeader,
                        AppStyles.textStyleSize16W600Primary(context),
                        'packages/aewallet/assets/icons/help.png',
                        StateContainer.of(context).curTheme.iconDrawerColor!,
                        onPressed: () {
                      setState(() {
                        _aboutOpen = true;
                      });
                      _aboutController!.forward();
                    }),
                    Divider(
                        height: 2,
                        color: StateContainer.of(context).curTheme.primary15),
                    const SizedBox(height: 30),
                  ].where(notNull).toList(),
                ),
                //List Top Gradient End
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: 20.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[
                          StateContainer.of(context).curTheme.backgroundDark!,
                          StateContainer.of(context).curTheme.backgroundDark00!
                        ],
                        begin: const AlignmentDirectional(0.5, -1.0),
                        end: const AlignmentDirectional(0.5, 1.0),
                      ),
                    ),
                  ),
                ), //List Top Gradient End
                //List Bottom Gradient
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 30.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[
                          StateContainer.of(context).curTheme.backgroundDark00!,
                          StateContainer.of(context).curTheme.backgroundDark!
                        ],
                        begin: const AlignmentDirectional(0.5, -1),
                        end: const AlignmentDirectional(0.5, 0.5),
                      ),
                    ),
                  ),
                ), //List Bottom Gradient End
              ],
            )),
          ],
        ),
      ),
    );
  }

  Widget buildAboutMenu(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(
              color: StateContainer.of(context).curTheme.primary30!, width: 1),
        ),
        color: StateContainer.of(context).curTheme.backgroundDark,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: StateContainer.of(context).curTheme.overlay30!,
              offset: const Offset(-5, 0),
              blurRadius: 20),
        ],
      ),
      child: SafeArea(
        minimum: const EdgeInsets.only(
          top: 60,
        ),
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(bottom: 10.0, top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    height: 40,
                    width: 40,
                    margin: const EdgeInsets.only(right: 10, left: 10),
                    child: BackButton(
                      key: const Key('back'),
                      color: StateContainer.of(context).curTheme.primary,
                      onPressed: () {
                        setState(() {
                          _aboutOpen = false;
                        });
                        _aboutController!.reverse();
                      },
                    ),
                  ),
                  Expanded(
                    child: AutoSizeText(
                      AppLocalization.of(context)!.aboutHeader,
                      style: AppStyles.textStyleSize20W700Primary(context),
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                child: Stack(
              children: <Widget>[
                ListView(
                  padding: const EdgeInsets.only(top: 15.0),
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, bottom: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(versionString,
                              style: AppStyles.textStyleSize14W100Primary(
                                  context)),
                        ],
                      ),
                    ),
                    Divider(
                        height: 2,
                        color: StateContainer.of(context).curTheme.primary15),
                    AppSettings.buildSettingsListItemSingleLine(
                        context,
                        AppLocalization.of(context)!
                            .aboutGeneralTermsAndConditions,
                        AppStyles.textStyleSize16W600Primary(context),
                        'packages/aewallet/assets/icons/terms-and-conditions.png',
                        StateContainer.of(context).curTheme.iconDrawerColor!,
                        onPressed: () async {
                      UIUtil.showWebview(
                          context,
                          'https://archethic.net',
                          AppLocalization.of(context)!
                              .aboutGeneralTermsAndConditions);
                    }),
                    Divider(
                        height: 2,
                        color: StateContainer.of(context).curTheme.primary15),
                    AppSettings.buildSettingsListItemSingleLine(
                        context,
                        AppLocalization.of(context)!.aboutWalletServiceTerms,
                        AppStyles.textStyleSize16W600Primary(context),
                        'packages/aewallet/assets/icons/walletServiceTerms.png',
                        StateContainer.of(context).curTheme.iconDrawerColor!,
                        onPressed: () async {
                      UIUtil.showWebview(context, 'https://archethic.net',
                          AppLocalization.of(context)!.aboutWalletServiceTerms);
                    }),
                    Divider(
                        height: 2,
                        color: StateContainer.of(context).curTheme.primary15),
                    AppSettings.buildSettingsListItemSingleLine(
                        context,
                        AppLocalization.of(context)!.aboutPrivacyPolicy,
                        AppStyles.textStyleSize16W600Primary(context),
                        'packages/aewallet/assets/icons/privacyPolicy.png',
                        StateContainer.of(context).curTheme.iconDrawerColor!,
                        onPressed: () async {
                      UIUtil.showWebview(context, 'https://archethic.net',
                          AppLocalization.of(context)!.aboutPrivacyPolicy);
                    }),
                  ].where(notNull).toList(),
                ),
                //List Top Gradient End
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: 20.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[
                          StateContainer.of(context).curTheme.backgroundDark!,
                          StateContainer.of(context).curTheme.backgroundDark00!
                        ],
                        begin: const AlignmentDirectional(0.5, -1.0),
                        end: const AlignmentDirectional(0.5, 1.0),
                      ),
                    ),
                  ),
                ), //List Top Gradient End
              ],
            )),
          ],
        ),
      ),
    );
  }

  Widget buildNFTMenu(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(
              color: StateContainer.of(context).curTheme.primary30!, width: 1),
        ),
        color: StateContainer.of(context).curTheme.backgroundDark,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: StateContainer.of(context).curTheme.overlay30!,
              offset: const Offset(-5, 0),
              blurRadius: 20),
        ],
      ),
      child: SafeArea(
        minimum: const EdgeInsets.only(
          top: 60,
        ),
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(bottom: 10.0, top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    height: 40,
                    width: 40,
                    margin: const EdgeInsets.only(right: 10, left: 10),
                    child: BackButton(
                      key: const Key('back'),
                      color: StateContainer.of(context).curTheme.primary,
                      onPressed: () {
                        setState(() {
                          _nftOpen = false;
                        });
                        _nftController!.reverse();
                      },
                    ),
                  ),
                  Expanded(
                    child: AutoSizeText(
                      AppLocalization.of(context)!.nftHeader,
                      style: AppStyles.textStyleSize20W700Primary(context),
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                child: Stack(
              children: <Widget>[
                ListView(
                  padding: const EdgeInsets.only(top: 15.0),
                  children: <Widget>[
                    Divider(
                        height: 2,
                        color: StateContainer.of(context).curTheme.primary15),
                    AppSettings.buildSettingsListItemSingleLine(
                        context,
                        AppLocalization.of(context)!.addNFTHeader,
                        AppStyles.textStyleSize16W600Primary(context),
                        'packages/aewallet/assets/icons/addNft.png',
                        StateContainer.of(context).curTheme.iconDrawerColor!,
                        onPressed: () {
                      Sheets.showAppHeightNineSheet(
                          context: context, widget: const AddNFTSheet());
                    }),
                    Divider(
                        height: 2,
                        color: StateContainer.of(context).curTheme.primary15),
                    AppSettings.buildSettingsListItemSingleLine(
                        context,
                        AppLocalization.of(context)!.transferNFT,
                        AppStyles.textStyleSize16W600Primary(context),
                        'packages/aewallet/assets/icons/transferNft.png',
                        StateContainer.of(context).curTheme.iconDrawerColor!,
                        onPressed: () {
                      /*Sheets.showAppHeightNineSheet(
                          context: context,
                          widget: TransferNftSheet(
                            contactsRef: StateContainer.of(context).contactsRef,
                            title: AppLocalization.of(context).transferNFT,
                          ));*/
                    }),
                    Divider(
                        height: 2,
                        color: StateContainer.of(context).curTheme.primary15),
                  ].where(notNull).toList(),
                ),
                //List Top Gradient End
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: 20.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[
                          StateContainer.of(context).curTheme.backgroundDark!,
                          StateContainer.of(context).curTheme.backgroundDark00!
                        ],
                        begin: const AlignmentDirectional(0.5, -1.0),
                        end: const AlignmentDirectional(0.5, 1.0),
                      ),
                    ),
                  ),
                ), //List Top Gradient End
              ],
            )),
          ],
        ),
      ),
    );
  }
}
