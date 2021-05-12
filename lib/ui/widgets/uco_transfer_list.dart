import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:uniris_lib_dart/transaction_builder.dart';
import 'package:uniris_lib_dart/utils.dart';
import 'package:uniris_mobile_wallet/appstate_container.dart';
import 'package:uniris_mobile_wallet/model/address.dart';
import 'package:uniris_mobile_wallet/model/db/appdb.dart';
import 'package:uniris_mobile_wallet/model/db/contact.dart';
import 'package:uniris_mobile_wallet/service_locator.dart';
import 'package:uniris_mobile_wallet/styles.dart';

class UcoTransferListWidget extends StatefulWidget {
  List<UcoTransfer>? listUcoTransfer;
  final List<Contact>? contacts;
  final Function(UcoTransfer)? onGet;
  final Function()? onDelete;

  UcoTransferListWidget({this.listUcoTransfer, this.onGet, this.onDelete, this.contacts})
      : super();

  _UcoTransferListWidgetState createState() => _UcoTransferListWidgetState();
}

enum AddressStyle { TEXT60, TEXT90, PRIMARY }

class _UcoTransferListWidgetState extends State<UcoTransferListWidget> {

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          child: Padding(
            padding: const EdgeInsets.only(top: 0.0),
            child: Container(
              height: widget.listUcoTransfer!.length * 60,
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
                  itemCount: widget.listUcoTransfer!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return FocusedMenuHolder(
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
                            false, // Open Focused-Menu on Tap rather than Long Press
                        menuOffset:
                            10.0, // Offset value to show menuItem from the selected item
                        bottomOffsetHeight: 200.0,
                        menuItems: <FocusedMenuItem>[
                          FocusedMenuItem(
                              title: Text("Get",
                                  style: AppStyles.textContextMenu(context)),
                              trailingIcon: Icon(Icons.get_app,
                                  color: StateContainer.of(context)
                                      .curTheme
                                      .contextMenuText),
                              onPressed: () {
                                setState(() {
                                  UcoTransfer _ucoTransfer = new UcoTransfer(
                                      to: widget.listUcoTransfer![index].to,
                                      amount: widget
                                          .listUcoTransfer![index].amount);
                                  widget.onGet!(_ucoTransfer);
                                });
                              }),
                          FocusedMenuItem(
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
                                  widget.listUcoTransfer!.removeAt(index);
                                  widget.onDelete!();
                                });
                              }),
                        ],
                        onPressed: () {},
                        child: displayUcoDetail(
                            context, widget.listUcoTransfer![index]));
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget displayUcoDetail(BuildContext context, UcoTransfer ucoTransfer) {
    String displayName =
        Address(uint8ListToHex(ucoTransfer.to!)).getShortString3();

    widget.contacts!.forEach((contact) {
      if (contact.address == uint8ListToHex(ucoTransfer.to!)) {
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
                Text(displayName,
                    style: AppStyles.textStyleAddressText90(context)),
              ],
            ),
            Text(ucoTransfer.amount!.toString(),
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
