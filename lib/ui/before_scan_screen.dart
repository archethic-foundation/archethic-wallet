// @dart=2.9

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:uniris_mobile_wallet/app_icons.dart';

class BeforeScanScreen extends StatefulWidget {
  @override
  _BeforeScanScreenState createState() => _BeforeScanScreenState();
}

class _BeforeScanScreenState extends State<BeforeScanScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 150), () async {
      String scanResult;
      Navigator.pop(context, scanResult);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Hero(
        tag: 'scanButton',
        child: AnimatedContainer(
          duration: Duration(milliseconds: 100),
          curve: Curves.easeOut,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(0),
          ),
          child: Icon(
            AppIcons.scan,
            size: 50,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
