import 'package:flutter/material.dart';
import 'package:uniris_lib_dart/transaction_builder.dart';
import 'package:uniris_lib_dart/utils.dart';
import 'package:uniris_mobile_wallet/appstate_container.dart';
import 'package:uniris_mobile_wallet/localization.dart';
import 'package:uniris_mobile_wallet/model/address.dart';
import 'package:uniris_mobile_wallet/model/db/contact.dart';
import 'package:uniris_mobile_wallet/styles.dart';
import 'package:uniris_mobile_wallet/ui/widgets/context_menu.dart';
import 'package:uniris_mobile_wallet/ui/widgets/context_menu_item.dart';

class UcoTransferListWidget extends StatefulWidget {
  UcoTransferListWidget(
      {this.listUcoTransfer, this.onGet, this.onDelete, this.contacts, @required this.displayContextMenu})
      : super();

  List<UcoTransfer>? listUcoTransfer;
  final List<Contact>? contacts;
  final Function(UcoTransfer)? onGet;
  final Function()? onDelete;
  final bool? displayContextMenu;

  @override
  _UcoTransferListWidgetState createState() => _UcoTransferListWidgetState();
}

class _UcoTransferListWidgetState extends State<UcoTransferListWidget> {
  @override
  Widget build(BuildContext context) {
    widget.listUcoTransfer!.sort((UcoTransfer a, UcoTransfer b) => uint8ListToHex(a.to!).compareTo(uint8ListToHex(b.to!)));
    return Stack(
      children: [
        SizedBox(
          child: Padding(
            padding: const EdgeInsets.only(top: 0.0),
            child: Container(
              height: widget.listUcoTransfer!.length * 45,
              padding: const EdgeInsets.only(left: 3.5, right: 3.5),
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                color: StateContainer.of(context).curTheme.background,
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
                boxShadow: [
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
                  itemCount: widget.listUcoTransfer!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return widget.displayContextMenu == true ? ContextMenu(
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
                              title: Text(AppLocalization.of(context).getOption,
                                  style: AppStyles.textContextMenu(context)),
                              trailingIcon: Icon(Icons.get_app,
                                  color: StateContainer.of(context)
                                      .curTheme
                                      .contextMenuText),
                              onPressed: () {
                                setState(() {
                                  final UcoTransfer _ucoTransfer = UcoTransfer(
                                      to: widget.listUcoTransfer![index].to,
                                      amount: widget
                                          .listUcoTransfer![index].amount);
                                  widget.onGet!(_ucoTransfer);
                                });
                              }),
                          ContextMenuItem(
                              title: Text(
                                AppLocalization.of(context).deleteOption,
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
                            context, widget.listUcoTransfer![index])) : displayUcoDetail(
                            context, widget.listUcoTransfer![index]);
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

    widget.contacts!.forEach((Contact contact) {
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
        const SizedBox(height: 6),
        Divider(
            height: 4,
            color: StateContainer.of(context).curTheme.backgroundDark),
        const SizedBox(height: 6),
      ],
    );
  }
}
