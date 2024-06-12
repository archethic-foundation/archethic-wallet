part of '../auto_lock_guard.dart';

/// Manages a singleton overlay
/// It is used to easily lock screen.
class LockMaskOverlay with LockOverlayMixin {
  factory LockMaskOverlay.instance() =>
      _instance ?? (_instance = LockMaskOverlay._());
  LockMaskOverlay._();

  static LockMaskOverlay? _instance;

  @override
  Widget get child => const LockMask();
}

class LockMask extends StatelessWidget {
  const LockMask({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox.expand(
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.black,
                image: DecorationImage(
                  image: AssetImage(
                    ArchethicTheme.backgroundWelcome,
                  ),
                  fit: BoxFit.fitHeight,
                  alignment: Alignment.centerRight,
                  opacity: 0.5,
                ),
              ),
            ),
          ),
          const LitStarfieldContainer(
            backgroundDecoration: BoxDecoration(
              color: Colors.transparent,
            ),
          ),
          Image.asset(
            '${ArchethicTheme.assetsFolder}logo_crystal.png',
            width: 200,
          ),
        ],
      ),
    );
  }
}
