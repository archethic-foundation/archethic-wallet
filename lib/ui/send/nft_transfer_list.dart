import 'package:flutter/material.dart';
import 'package:uniris_lib_dart/transaction_builder.dart';
import 'package:uniris_lib_dart/utils.dart';
import 'package:uniris_mobile_wallet/appstate_container.dart';
import 'package:uniris_mobile_wallet/model/address.dart';
import 'package:uniris_mobile_wallet/model/db/contact.dart';
import 'package:uniris_mobile_wallet/styles.dart';
import 'package:uniris_mobile_wallet/ui/widgets/context_menu.dart';
import 'package:uniris_mobile_wallet/ui/widgets/context_menu_item.dart';

class NftTransferListWidget extends StatefulWidget {
  List<NftTransfer>? listNftTransfer;
  final List<Contact>? contacts;
  final Function(NftTransfer)? onGet;
  final Function()? onDelete;

  NftTransferListWidget({this.listNftTransfer, this.onGet, this.onDelete, this.contacts})
      : super();

  _NftTransferListWidgetState createState() => _NftTransferListWidgetState();
}

class _NftTransferListWidgetState extends State<NftTransferListWidget> {

  @override
  Widget build(BuildContext context) {
    widget.listNftTransfer!.sort((a, b) => uint8ListToHex(a.to!).compareTo(uint8ListToHex(b.to!)));
    return Stack(
      children: [
        SizedBox(
          child: Padding(
            padding: const EdgeInsets.only(top: 0.0),
            child: Container(
              height: widget.listNftTransfer!.length * 50,
              padding: EdgeInsets.only(left: 3.5, right: 3.5),
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                color: StateContainer.of(context).curTheme.background,
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
                boxShadow: [
                  BoxShadow(
                    color: StateContainer.of(context).curTheme.backgroundDark,
                    blurRadius: 5.0,
                    spreadRadius: 0.0,
                    offset: Offset(5.0, 5.0),
                  ),
                ],
              ),
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 6, right: 6, top: 6, bottom: 6),
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  itemCount: widget.listNftTransfer!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ContextMenu(
                        menuWidth: MediaQuery.of(context).size.width * 0.50,
                        blurSize: 5.0,
                        menuItemExtent: 45,
                        menuBoxDecoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0))),
                        duration: Duration(milliseconds: 100),
                        animateMenuItems: true,
                        blurBackgroundColor: Colors.black54,
                        openWithTap:
                            false, 
                        menuOffset:
                            10.0,
                        bottomOffsetHeight: 200.0,
                        menuItems: <ContextMenuItem>[
                          ContextMenuItem(
                              title: Text("Get",
                                  style: AppStyles.textContextMenu(context)),
                              trailingIcon: Icon(Icons.get_app,
                                  color: StateContainer.of(context)
                                      .curTheme
                                      .contextMenuText),
                              onPressed: () {
                                setState(() {
                                  NftTransfer _nftTransfer = new NftTransfer(
                                      to: widget.listNftTransfer![index].to,
                                      amount: widget
                                          .listNftTransfer![index].amount);
                                  widget.onGet!(_nftTransfer);
                                });
                              }),
                          ContextMenuItem(
                              title: Text(
                                "Delete",
                                style: AppStyles.textContextMenuRed(context),
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
                            context, widget.listNftTransfer![index]));
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget displayNftDetail(BuildContext context, NftTransfer nftTransfer) {
    String displayName =
        Address(uint8ListToHex(nftTransfer.to!)).getShortString3();

    widget.contacts!.forEach((contact) {
      if (contact.address == uint8ListToHex(nftTransfer.to!)) {
        displayName = contact.name;
      }
    });
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(nftTransfer.nft == null ? "NFT 1...." : uint8ListToHex(nftTransfer.nft!),
                        style: AppStyles.textStyleAddressText90(context)),
                    Text(Address(displayName).getShortString3(),
                        style: AppStyles.textStyleTiny(context))
                  ],
                ),
              ],
            ),
            Text(nftTransfer.amount!.toString(),
                style: AppStyles.textStyleAddressText90(context)),
          ],
        ),
        SizedBox(height: 6),
        Divider(
            height: 4,
            color: StateContainer.of(context).curTheme.backgroundDark),
        SizedBox(height: 6),
      ],
    );
  }
}
