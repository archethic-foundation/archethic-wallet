// ignore_for_file: must_be_immutable

/// SPDX-License-Identifier: AGPL-3.0-or-later

// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:intl/intl.dart';

// Project imports:
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/address.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/util/get_it_instance.dart';

// Package imports:
import 'package:archethic_lib_dart/archethic_lib_dart.dart'
    show Node, ApiService;

class NodesList extends StatefulWidget {
  NodesList(this.nodesController, this.nodesOpen, {super.key});

  final AnimationController nodesController;
  bool nodesOpen;

  @override
  State<NodesList> createState() => _NodesListState();
}

class _NodesListState extends State<NodesList> {
  List<Node>? _nodes;

  @override
  void initState() {
    super.initState();
    // Initial nodes list
    initNodesList();
  }

  Future<void> initNodesList() async {
    _nodes = await sl.get<ApiService>().getNodeList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          border: Border(
            right: BorderSide(
                color: StateContainer.of(context).curTheme.text30!, width: 1),
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
          minimum: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height * 0.035,
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
                        color: StateContainer.of(context).curTheme.text,
                        onPressed: () {
                          setState(() {
                            widget.nodesOpen = false;
                          });
                          widget.nodesController.reverse();
                        },
                      ),
                    ),
                    Expanded(
                      child: AutoSizeText(
                        AppLocalization.of(context)!.nodesHeader,
                        style: AppStyles.textStyleSize24W700EquinoxPrimary(
                            context),
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ),

              if (_nodes == null)
                const SizedBox()
              else
                Container(
                  margin: const EdgeInsetsDirectional.only(start: 20.0),
                  alignment: Alignment.bottomLeft,
                  child: Text(
                      AppLocalization.of(context)!.nodeNumber +
                          _nodes!.length.toString(),
                      style: AppStyles.textStyleSize12W100Primary(context)),
                ),
              // Nodes list + top and bottom gradients
              Expanded(
                child: Stack(
                  children: <Widget>[
                    if (_nodes == null)
                      const SizedBox()
                    else
                      ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: const EdgeInsets.only(top: 15.0, bottom: 15),
                        itemCount: _nodes!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return buildSingleNode(context, _nodes![index]);
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
        ));
  }

  Widget buildSingleNode(BuildContext context, Node node) {
    return Column(
      children: <Widget>[
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
                  margin: const EdgeInsetsDirectional.only(start: 2.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(AppLocalization.of(context)!.nodeFirstPublicKey,
                          style: AppStyles.textStyleSize12W600Primary(context)),
                      Text(Address(node.firstPublicKey!).getShortString2(),
                          style: AppStyles.textStyleSize12W100Primary(context)),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        AppLocalization.of(context)!.nodeLastPublicKey,
                        style: AppStyles.textStyleSize12W600Primary(context),
                      ),
                      Text(
                        Address(node.lastPublicKey!).getShortString2(),
                        style: AppStyles.textStyleSize12W100Primary(context),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: <Widget>[
                          Text(AppLocalization.of(context)!.nodeIP,
                              style: AppStyles.textStyleSize12W600Primary(
                                  context)),
                          Text('${node.ip!}:${node.port}',
                              style: AppStyles.textStyleSize12W100Primary(
                                  context)),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: <Widget>[
                          Text(AppLocalization.of(context)!.nodeGeoPatch,
                              style: AppStyles.textStyleSize12W600Primary(
                                  context)),
                          Text(node.geoPatch!,
                              style: AppStyles.textStyleSize12W100Primary(
                                  context)),
                          Text(
                              ' - ${AppLocalization.of(context)!.nodeNetworkPatch}',
                              style: AppStyles.textStyleSize12W600Primary(
                                  context)),
                          Text(node.networkPatch!,
                              style: AppStyles.textStyleSize12W100Primary(
                                  context)),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                              AppLocalization.of(context)!
                                  .nodeAverageAvailability,
                              style: AppStyles.textStyleSize12W600Primary(
                                  context)),
                          Text(node.averageAvailability.toString(),
                              style: AppStyles.textStyleSize12W100Primary(
                                  context)),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      node.enrollmentDate == null
                          ? const SizedBox()
                          : Row(
                              children: <Widget>[
                                Text(
                                    AppLocalization.of(context)!
                                        .nodeEnrollmentDate,
                                    style: AppStyles.textStyleSize12W600Primary(
                                        context)),
                                Text(
                                    DateFormat.yMMMEd(
                                            Localizations.localeOf(context)
                                                .languageCode)
                                        .add_Hms()
                                        .format(
                                            DateTime.fromMillisecondsSinceEpoch(
                                                    node.enrollmentDate! * 1000)
                                                .toLocal())
                                        .toString(),
                                    style: AppStyles.textStyleSize12W100Primary(
                                        context)),
                              ],
                            ),
                      node.enrollmentDate == null
                          ? const SizedBox()
                          : const SizedBox(
                              height: 10,
                            ),
                      node.authorizationDate == null
                          ? const SizedBox()
                          : Row(
                              children: <Widget>[
                                Text(
                                    AppLocalization.of(context)!
                                        .nodeAuthorizationDate,
                                    style: AppStyles.textStyleSize12W600Primary(
                                        context)),
                                Text(
                                    DateFormat.yMMMEd(
                                            Localizations.localeOf(context)
                                                .languageCode)
                                        .add_Hms()
                                        .format(
                                            DateTime.fromMillisecondsSinceEpoch(
                                                    node.authorizationDate! *
                                                        1000)
                                                .toLocal())
                                        .toString(),
                                    style: AppStyles.textStyleSize12W100Primary(
                                        context)),
                              ],
                            ),
                      node.authorizationDate == null
                          ? const SizedBox()
                          : const SizedBox(
                              height: 10,
                            ),
                      Row(
                        children: <Widget>[
                          Text(AppLocalization.of(context)!.nodeAuthorized,
                              style: AppStyles.textStyleSize12W600Primary(
                                  context)),
                          Text(
                              node.authorized!
                                  ? AppLocalization.of(context)!.yes
                                  : AppLocalization.of(context)!.no,
                              style: AppStyles.textStyleSize12W100Primary(
                                  context)),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(AppLocalization.of(context)!.nodeRewardAddress,
                          style: AppStyles.textStyleSize12W600Primary(context)),
                      Text(Address(node.rewardAddress!).getShortString2(),
                          style: AppStyles.textStyleSize12W100Primary(context)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Divider(height: 2, color: StateContainer.of(context).curTheme.text60),
      ],
    );
  }
}
