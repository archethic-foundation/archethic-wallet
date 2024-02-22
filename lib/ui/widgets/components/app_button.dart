/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AppButton extends StatefulWidget {
  const AppButton({
    super.key,
    required this.labelBtn,
    this.onPressed,
    this.height = 40,
    this.disabled = false,
    this.background = const Color(0xFF3D1D63),
    this.fontSize = 16,
  });
  final String labelBtn;
  final Function? onPressed;
  final bool disabled;
  final double height;
  final Color background;
  final double fontSize;

  @override
  AppButtonState createState() => AppButtonState();
}

class AppButtonState extends State<AppButton> {
  bool _over = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _over = true;
        });
      },
      onExit: (_) {
        setState(() {
          _over = false;
        });
      },
      child: widget.disabled
          ? OutlinedButton(
              style: ButtonStyle(
                side: MaterialStateProperty.all(BorderSide.none),
                overlayColor: MaterialStateProperty.all(Colors.transparent),
              ),
              onPressed: null,
              child: _buttonContent(),
            )
          : widget.onPressed == null
              ? OutlinedButton(
                  style: ButtonStyle(
                    side: MaterialStateProperty.all(BorderSide.none),
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                  ),
                  onPressed: null,
                  child: _buttonContent(),
                ).animate(target: _over ? 0 : 1).fade(end: 0.8)
              : OutlinedButton(
                  style: ButtonStyle(
                    side: MaterialStateProperty.all(BorderSide.none),
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                  ),
                  onPressed: () {
                    widget.onPressed!();
                  },
                  child: _buttonContent(),
                ).animate(target: _over ? 0 : 1).fade(end: 0.8),
    );
  }

  Widget _buttonContent() {
    return Container(
      alignment: Alignment.center,
      height: widget.height,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      decoration: ShapeDecoration(
        gradient: ArchethicTheme.gradientMainButton,
        shape: const StadiumBorder(),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.labelBtn,
            style: TextStyle(
              color: widget.disabled
                  ? Colors.white.withOpacity(0.5)
                  : Colors.white,
              fontSize: widget.fontSize,
              fontWeight: FontWeight.w400,
            ),
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}
