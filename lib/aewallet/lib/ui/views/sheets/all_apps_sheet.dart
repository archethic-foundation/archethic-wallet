// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:core/appstate_container.dart';
import 'package:core/model/ae_apps.dart';
import 'package:core/ui/util/lorem_ipsum/lorem_ipsum.dart';
import 'package:core/ui/util/styles.dart';
import 'package:core/ui/widgets/components/icon_widget.dart';

class AllAppsSheet extends StatefulWidget {
  const AllAppsSheet({Key? key}) : super(key: key);

  @override
  _AllAppsSheetState createState() => _AllAppsSheetState();
}

class _AllAppsSheetState extends State<AllAppsSheet> {
  Widget _appList(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.8,
          width: MediaQuery.of(context).size.width * 0.9,
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: buildIconDataWidget(
                      context, Icons.close_outlined, 30, 30),
                ),
              ),
              Expanded(
                child: Stack(
                  children: <Widget>[
                    ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.only(
                          left: 15, right: 15, top: 15.0, bottom: 15),
                      itemCount: AppList.list.length,
                      itemBuilder: (BuildContext context, int index) {
                        return _appInfo(context, AppList.list[index],
                            background: Colors.blue);
                      },
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        height: 20.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: <Color>[
                              StateContainer.of(context)
                                  .curTheme
                                  .backgroundDark!,
                              StateContainer.of(context)
                                  .curTheme
                                  .backgroundDark00!
                            ],
                            begin: const AlignmentDirectional(0.5, -1.0),
                            end: const AlignmentDirectional(0.5, 1.0),
                          ),
                        ),
                      ),
                    ),
                    //List Bottom Gradient End
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 15.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: <Color>[
                              StateContainer.of(context)
                                  .curTheme
                                  .backgroundDark00!,
                              StateContainer.of(context)
                                  .curTheme
                                  .backgroundDark!,
                            ],
                            begin: const AlignmentDirectional(0.5, -1.0),
                            end: const AlignmentDirectional(0.5, 1.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _card(BuildContext context,
      {Color primaryColor = Colors.redAccent, Widget? backWidget}) {
    return Container(
      height: 190,
      width: MediaQuery.of(context).size.width * .34,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          boxShadow: const <BoxShadow>[
            BoxShadow(
                offset: Offset(0, 5), blurRadius: 10, color: Color(0x12000000))
          ]),
      child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          child: backWidget),
    );
  }

  Widget _appInfo(BuildContext context, AppModel model, {Color? background}) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            StateContainer.of(context).currentAEApp = model.aeApp!;
            Navigator.pop(context);
          },
          child: SizedBox(
            height: 170,
            width: MediaQuery.of(context).size.width - 20,
            child: Row(
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 1,
                  child: _card(
                    context,
                    primaryColor: background!,
                    backWidget: SizedBox(
                      height: 170,
                      child: Image.asset(
                        'assets/apps/aeweb.png',
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 15),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            model.name!,
                            style:
                                AppStyles.textStyleSize12W600Primary(context),
                          ),
                        ),
                        const SizedBox(width: 10)
                      ],
                    ),
                    const SizedBox(height: 15),
                    Text(
                      model.description!,
                      style: AppStyles.textStyleSize12W100Primary(context),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: <Widget>[
                        model.tag1!.isNotEmpty
                            ? _chip(model.tag1!, Colors.white, height: 5)
                            : const SizedBox(),
                        const SizedBox(
                          width: 10,
                        ),
                        model.tag2!.isNotEmpty
                            ? _chip(model.tag2!, Colors.white, height: 5)
                            : const SizedBox(),
                      ],
                    )
                  ],
                ))
              ],
            ),
          ),
        ),
        const Divider(
          thickness: 1,
          endIndent: 20,
          indent: 20,
        ),
      ],
    );
  }

  Widget _chip(String text, Color textColor,
      {double height = 0, bool isPrimaryCard = false}) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: height),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        color: textColor.withAlpha(isPrimaryCard ? 200 : 50),
      ),
      child: Text(
        text,
        style: AppStyles.textStyleSize12W100Primary(context),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[_appList(context)],
      ),
    );
  }
}

class AppModel {
  String? name;
  String? description;
  String? tag1;
  String? tag2;
  String? image;
  AEApps? aeApp;

  AppModel(
      {this.name,
      this.description,
      this.image,
      this.tag1,
      this.tag2,
      this.aeApp});
}

class AppList {
  static List<AppModel> list = [
    AppModel(
        name: 'AE Mail',
        description: loremIpsum(words: 60),
        aeApp: AEApps.aemail,
        tag1: '',
        tag2: ''),
    AppModel(
        name: 'AE Web',
        description:
            'AEWeb is the first application on the Archethic blockchain where you can deploy your website on the Archethic blockchain. With morethan 200K+ small and medium sized websites created everyday, its security, operation and maintainance is a huge cost. With AEWeb you can deploy your website on the Archethic blockchain with a fraction of the real cost.',
        aeApp: AEApps.aeweb,
        tag1: 'Hosting',
        tag2: 'Security'),
    AppModel(
        name: 'AE Staking',
        description: loremIpsum(words: 60),
        aeApp: null,
        tag1: 'Soon 2022',
        tag2: ''),
    AppModel(
        name: 'AE Wallet',
        description:
            'Archethic Mobile Wallet is one of the ways you can interact with Archethic blockchain. It supports transactions and fund transfers of UCO Tokens and NFTs on Archethic Testnet. Also you can use your 24 words mneumonic to restore your wallet and use that on ARCHEthic blockchain. Upcoming feature includes NFTs support for wallet.',
        aeApp: AEApps.aewallet,
        tag1: 'Transactions',
        tag2: 'Transfer'),
  ];
}
