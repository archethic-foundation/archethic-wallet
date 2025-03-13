import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class BoxPurpleGradient extends StatelessWidget {
  const BoxPurpleGradient({
    super.key,
    required this.content,
    this.onClose,
  });

  final Widget content;
  final Function()? onClose;

  @override
  Widget build(BuildContext context) {
    return _buildBannerContainer(
      context,
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: content,
          ),
          if (onClose != null)
            Positioned(
              child: IconButton(
                onPressed: onClose,
                icon: const Icon(
                  Symbols.close,
                  color: Colors.white,
                  size: 16,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildBannerContainer(
    BuildContext context, {
    required Widget child,
  }) {
    return aedappfm.BlockInfo(
      borderWidth: 0,
      paddingEdgeInsetsClipRRect: EdgeInsets.zero,
      paddingEdgeInsetsInfo: EdgeInsets.zero,
      width: MediaQuery.of(context).size.width,
      info: Stack(
        children: [
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: RadialGradient(
                  center: const Alignment(0, -1.5),
                  radius: 1.1,
                  colors: [
                    const Color(0xFFC002FF),
                    const Color(0xFFC002FF).withValues(alpha: 0.8),
                    const Color(0xFF322070),
                  ],
                  stops: const [0.0, 0.3, 1.0],
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xFF5540BF).withValues(alpha: 0.4),
              ),
            ),
          ),
          _buildBackgroundImage(),
          child,
        ],
      ),
    );
  }

  Widget _buildBackgroundImage() {
    return Positioned.fill(
      top: -60,
      left: -300,
      child: Transform.rotate(
        angle: -10 * 3.14 / 180,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Opacity(
            opacity: 0.2,
            child: Image.asset(
              'assets/themes/archethic/logo_crystal.png',
            ),
          ),
        ),
      ),
    );
  }
}
