// ignore_for_file: must_be_immutable

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:archethic_lib_dart/archethic_lib_dart.dart' show NFTTransfer;

// Project imports:
import 'package:archethic_wallet/appstate_container.dart';
import 'package:archethic_wallet/localization.dart';
import 'package:archethic_wallet/model/address.dart';
import 'package:archethic_wallet/model/data/hive_db.dart';
import 'package:archethic_wallet/ui/util/styles.dart';
import 'package:archethic_wallet/ui/widgets/components/context_menu.dart';
import 'package:archethic_wallet/ui/widgets/components/context_menu_item.dart';

class NftTransferListWidget extends StatefulWidget {
  NftTransferListWidget(
      {Key? key,
      this.listNftTransfer,
      this.onGet,
      this.onDelete,
      this.contacts,
      @required this.displayContextMenu})
      : super(key: key);

  List<NFTTransfer>? listNftTransfer;
  final List<Contact>? contacts;
  final Function(NFTTransfer)? onGet;
  final Function()? onDelete;
  final bool? displayContextMenu;

  @override
  _NftTransferListWidgetState createState() => _NftTransferListWidgetState();
}

class _NftTransferListWidgetState extends State<NftTransferListWidget> {
  @override
  Widget build(BuildContext context) {
    widget.listNftTransfer!
        .sort((NFTTransfer a, NFTTransfer b) => a.to!.compareTo(b.to!));
    return Stack(
      children: <Widget>[
        SizedBox(
          child: Padding(
            padding: const EdgeInsets.only(top: 0.0),
            child: Container(
              height: widget.listNftTransfer!.length * 50,
              padding: const EdgeInsets.only(left: 3.5, right: 3.5),
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                color: StateContainer.of(context).curTheme.background,
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: StateContainer.of(context).curTheme.backgroundDark!,
                    blurRadius: 5.0,
                    spreadRadius: 0.0,
                    offset: const Offset(5.0, 5.0),
                  ),
                ],
              ),
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 6, right: 6, top: 6, bottom: 6),
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  itemCount: widget.listNftTransfer!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return widget.displayContextMenu == true
                        ? ContextMenu(
                            menuWidth: MediaQuery.of(context).size.width * 0.50,
                            blurSize: 5.0,
                            menuItemExtent: 45,
                            menuBoxDecoration: const BoxDecoration(
                                color: Colors.grey,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0))),
                            duration: const Duration(milliseconds: 100),
                            animateMenuItems: true,
                            blurBackgroundColor: Colors.black54,
                            openWithTap:
                                false, // Open Focused-Menu on Tap rather than Long Press
                            menuOffset:
                                10.0, // Offset value to show menuItem from the selected item
                            bottomOffsetHeight: 200.0,
                            menuItems: <ContextMenuItem>[
                              ContextMenuItem(
                                  title: Text(
                                      AppLocalization.of(context)!.getOption,
                                      style: AppStyles
                                          .textStyleSize14W700ContextMenuPrimary(
                                              context)),
                                  trailingIcon: Icon(Icons.get_app,
                                      color: StateContainer.of(context)
                                          .curTheme
                                          .contextMenuText),
                                  onPressed: () {
                                    setState(() {
                                      final NFTTransfer _nftTransfer =
                                          NFTTransfer(
                                              to: widget
                                                  .listNftTransfer![index].to,
                                              amount: widget
                                                  .listNftTransfer![index]
                                                  .amount);
                                      widget.onGet!(_nftTransfer);
                                    });
                                  }),
                              ContextMenuItem(
                                  title: Text(
                                    AppLocalization.of(context)!.deleteOption,
                                    style: AppStyles
                                        .textStyleSize14W700ContextMenuTextRed(
                                            context),
                                  ),
                                  trailingIcon: Icon(
                                    Icons.delete,
                                    color: StateContainer.of(context)
                                        .curTheme
                                        .contextMenuTextRed,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      widget.listNftTransfer!.removeAt(index);
                                      widget.onDelete!();
                                    });
                                  }),
                            ],
                            onPressed: () {},
                            child: displayNftDetail(
                                context, widget.listNftTransfer![index]))
                        : displayNftDetail(
                            context, widget.listNftTransfer![index]);
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget displayNftDetail(BuildContext context, NFTTransfer nftTransfer) {
    String displayName = Address(nftTransfer.to!).getShortString3();

    for (Contact contact in widget.contacts!) {
      if (contact.address == nftTransfer.to!) {
        displayName = contact.name!;
      }
    }

    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                        nftTransfer.nft == null
                            ? 'NFT 1....'
                            : nftTransfer.nft!,
                        style: AppStyles.textStyleSize14W100Primary(context)),
                    Text(Address(displayName).getShortString3(),
                        style: AppStyles.textStyleSize10W100Primary60(context))
                  ],
                ),
              ],
            ),
            Text(nftTransfer.amount!.toString(),
                style: AppStyles.textStyleSize14W100Primary(context)),
          ],
        ),
        const SizedBox(height: 6),
        Divider(
            height: 4,
            color: StateContainer.of(context).curTheme.backgroundDark),
        const SizedBox(height: 6),
      ],
    );
  }
}
