// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:archethic_lib_dart/archethic_lib_dart.dart' show UCOTransfer;

// Project imports:
import 'package:archethic_mobile_wallet/appstate_container.dart';
import 'package:archethic_mobile_wallet/localization.dart';
import 'package:archethic_mobile_wallet/model/address.dart';
import 'package:archethic_mobile_wallet/model/db/contact.dart';
import 'package:archethic_mobile_wallet/styles.dart';
import 'package:archethic_mobile_wallet/ui/widgets/context_menu.dart';
import 'package:archethic_mobile_wallet/ui/widgets/context_menu_item.dart';

class UcoTransferListWidget extends StatefulWidget {
  UcoTransferListWidget(
      {this.listUcoTransfer,
      this.onGet,
      this.onDelete,
      this.contacts,
      @required this.displayContextMenu})
      : super();

  List<UCOTransfer>? listUcoTransfer;
  final List<Contact>? contacts;
  final Function(UCOTransfer)? onGet;
  final Function()? onDelete;
  final bool? displayContextMenu;

  @override
  _UcoTransferListWidgetState createState() => _UcoTransferListWidgetState();
}

class _UcoTransferListWidgetState extends State<UcoTransferListWidget> {
  @override
  Widget build(BuildContext context) {
    widget.listUcoTransfer!
        .sort((UCOTransfer a, UCOTransfer b) => a.to!.compareTo(b.to!));
    return Stack(
      children: <Widget>[
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
                  itemCount: widget.listUcoTransfer!.length,
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
                                      final UCOTransfer _ucoTransfer =
                                          UCOTransfer(
                                              to: widget
                                                  .listUcoTransfer![index].to,
                                              amount: widget
                                                  .listUcoTransfer![index]
                                                  .amount);
                                      widget.onGet!(_ucoTransfer);
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
                                      widget.listUcoTransfer!.removeAt(index);
                                      widget.onDelete!();
                                    });
                                  }),
                            ],
                            onPressed: () {},
                            child: displayUcoDetail(
                                context, widget.listUcoTransfer![index]))
                        : displayUcoDetail(
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

  Widget displayUcoDetail(BuildContext context, UCOTransfer ucoTransfer) {
    String displayName = Address(ucoTransfer.to!).getShortString3();

    for (Contact contact in widget.contacts!) {
      if (contact.address == ucoTransfer.to!) {
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
                Text(displayName,
                    style: AppStyles.textStyleSize14W100Primary(context)),
              ],
            ),
            Text(ucoTransfer.amount!.toString() + ' UCO',
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
