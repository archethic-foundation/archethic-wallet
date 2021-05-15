import 'package:flutter/material.dart';

class ContextMenuItem {
  Color? backgroundColor;
  Widget title;
  Icon? trailingIcon;
  Function onPressed;

  ContextMenuItem(
      {this.backgroundColor,
      required this.title,
      this.trailingIcon,
      required this.onPressed});
}
