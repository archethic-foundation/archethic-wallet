// @dart=2.9

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:archethic_mobile_wallet/appstate_container.dart';

class ReleaseNote extends StatefulWidget {
  @override
  _ReleaseNoteState createState() => _ReleaseNoteState();
}

class _ReleaseNoteState extends State<ReleaseNote> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        minimum:
            EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.035),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                //Empty SizedBox
                const SizedBox(
                  width: 60,
                  height: 60,
                ),

                Column(
                  children: <Widget>[
                    // Sheet handle
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      height: 5,
                      width: MediaQuery.of(context).size.width * 0.15,
                      decoration: BoxDecoration(
                        color: StateContainer.of(context).curTheme.primary10,
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                    ),
                  ],
                ),
                //Empty SizedBox
                const SizedBox(
                  width: 60,
                  height: 60,
                ),
              ],
            ),
            Expanded(
              child: Center(
                child: Stack(
                  children: <Widget>[
                    // Outer ring
                    Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width / 1.68,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color:
                                  StateContainer.of(context).curTheme.primary,
                              width: MediaQuery.of(context).size.width / 110),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
