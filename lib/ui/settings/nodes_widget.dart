// @dart=2.9

// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:archethic_lib_dart/model/response/nodes_response.dart';
import 'package:archethic_lib_dart/model/response/transactions_response.dart';
import 'package:archethic_lib_dart/services/address_service.dart';
import 'package:archethic_lib_dart/services/api_service.dart';

// Project imports:
import 'package:archethic_mobile_wallet/app_icons.dart';
import 'package:archethic_mobile_wallet/appstate_container.dart';
import 'package:archethic_mobile_wallet/localization.dart';
import 'package:archethic_mobile_wallet/model/address.dart';
import 'package:archethic_mobile_wallet/service_locator.dart';
import 'package:archethic_mobile_wallet/styles.dart';
import 'package:archethic_mobile_wallet/util/sharedprefsutil.dart';

class NodesList extends StatefulWidget {
  NodesList(this.nodesController, this.nodesOpen);

  final AnimationController nodesController;
  bool nodesOpen;

  @override
  _NodesListState createState() => _NodesListState();
}

class _NodesListState extends State<NodesList> {
  NodesResponse _nodes;

  @override
  void initState() {
    super.initState();
    // Initial nodes list
    initNodesList();
  }

  Future<void> initNodesList() async {
    final String endpoint = await sl.get<SharedPrefsUtil>().getEndpoint();
    _nodes = await sl.get<ApiService>().getNodeList(endpoint);
    String genesisAddress = sl
        .get<AddressService>()
        .deriveAddress(_nodes.data.nodes[0].rewardAddress, 0);
    TransactionsResponse transactionsResponse =
        await sl.get<ApiService>().getTransactions(genesisAddress, 1, endpoint);
    print(transactionsResponse.data.transactionChain[0].address);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: StateContainer.of(context).curTheme.backgroundDark,
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: StateContainer.of(context).curTheme.overlay30,
                offset: const Offset(-5, 0),
                blurRadius: 20),
          ],
        ),
        child: SafeArea(
          minimum: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height * 0.035,
            top: 60,
          ),
          child: Column(
            children: <Widget>[
              // Back button and Nodes Text
              Container(
                margin: const EdgeInsets.only(bottom: 10.0, top: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        //Back button
                        Container(
                          height: 40,
                          width: 40,
                          margin: const EdgeInsets.only(right: 10, left: 10),
                          child: TextButton(
                              onPressed: () {
                                setState(() {
                                  widget.nodesOpen = false;
                                });
                                widget.nodesController.reverse();
                              },
                              child: Icon(AppIcons.back,
                                  color:
                                      StateContainer.of(context).curTheme.text,
                                  size: 24)),
                        ),
                        //Nodes Header Text
                        Text(
                          AppLocalization.of(context).nodesHeader,
                          style: AppStyles.textStyleSettingsHeader(context),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              _nodes == null || _nodes.data == null || _nodes.data.nodes == null
                  ? SizedBox()
                  : Container(
                      margin: const EdgeInsetsDirectional.only(start: 20.0),
                      alignment: Alignment.bottomLeft,
                      child: Text(
                          'Nb of nodes : ' +
                              _nodes.data.nodes.length.toString(),
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: AppFontSizes.smallest,
                            color: StateContainer.of(context).curTheme.primary,
                          )),
                    ),
              // Nodes list + top and bottom gradients
              Expanded(
                child: Stack(
                  children: <Widget>[
                    _nodes == null ||
                            _nodes.data == null ||
                            _nodes.data.nodes == null
                        ? SizedBox()
                        :
                        // Nodes list
                        ListView.builder(
                            physics: const AlwaysScrollableScrollPhysics(),
                            padding:
                                const EdgeInsets.only(top: 15.0, bottom: 15),
                            itemCount: _nodes.data.nodes.length,
                            itemBuilder: (BuildContext context, int index) {
                              return buildSingleNode(
                                  context, _nodes.data.nodes[index]);
                            },
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
                              StateContainer.of(context)
                                  .curTheme
                                  .backgroundDark,
                              StateContainer.of(context)
                                  .curTheme
                                  .backgroundDark00
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
                                  .backgroundDark00,
                              StateContainer.of(context)
                                  .curTheme
                                  .backgroundDark,
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
        ));
  }

  Widget buildSingleNode(BuildContext context, Node node) {
    return TextButton(
      onPressed: () {
        // NodeDetailsSheet(contact, documentsDirectory)
        //     .mainBottomSheet(context);
      },
      child: Column(children: <Widget>[
        // Main Container
        Container(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          margin: const EdgeInsetsDirectional.only(start: 12.0, end: 12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // Node info
              Expanded(
                child: Container(
                  height: 220,
                  margin: const EdgeInsetsDirectional.only(start: 2.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('First public key : ',
                          style: AppStyles.textStyleDialogButtonText(context)),
                      Text(Address(node.firstPublicKey).getShortString2(),
                          style:
                              AppStyles.textStyleTransactionAddress(context)),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Last public key : ',
                        style: AppStyles.textStyleDialogButtonText(context),
                      ),
                      Text(
                        Address(node.lastPublicKey).getShortString2(),
                        style: AppStyles.textStyleTransactionAddress(context),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text('IP : ',
                              style:
                                  AppStyles.textStyleDialogButtonText(context)),
                          Text(node.ip + ":" + node.port.toString(),
                              style: AppStyles.textStyleTransactionAddress(
                                  context)),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text('Geo patch : ',
                              style:
                                  AppStyles.textStyleDialogButtonText(context)),
                          Text(node.geoPatch,
                              style: AppStyles.textStyleTransactionAddress(
                                  context)),
                          Text(" - Network patch : ",
                              style:
                                  AppStyles.textStyleDialogButtonText(context)),
                          Text(node.networkPatch,
                              style: AppStyles.textStyleTransactionAddress(
                                  context)),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text('Average availability : ',
                              style:
                                  AppStyles.textStyleDialogButtonText(context)),
                          Text(node.averageAvailability.toString(),
                              style: AppStyles.textStyleTransactionAddress(
                                  context)),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text('Authorized : ',
                              style:
                                  AppStyles.textStyleDialogButtonText(context)),
                          Text(node.authorized.toString(),
                              style: AppStyles.textStyleTransactionAddress(
                                  context)),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text('Reward address : ',
                          style: AppStyles.textStyleDialogButtonText(context)),
                      Text(Address(node.rewardAddress).getShortString2(),
                          style:
                              AppStyles.textStyleTransactionAddress(context)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Divider(
          height: 2,
          color: StateContainer.of(context).curTheme.text15,
        ),
      ]),
    );
  }
}
