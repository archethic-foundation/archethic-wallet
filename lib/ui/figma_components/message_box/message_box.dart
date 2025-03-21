import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

// TODO(reddwarf03): Update locked
enum MessageBoxType { success, warning, locked, info, processing }

typedef MessageBoxStyle = ({
  Color cardColor,
  Color borderColor,
  Widget leadingIcon,
  bool autoTrailingIcon,
});

extension MessageBoxStyleExt on MessageBoxType {
  MessageBoxStyle get style => switch (this) {
        MessageBoxType.processing => (
            cardColor: const Color(0xFF5540BF).withValues(alpha: 0.2),
            borderColor: const Color(0xFF5540BF),
            leadingIcon: const SizedBox.square(
              dimension: 16,
              child: CircularProgressIndicator(
                strokeWidth: 1,
              ),
            ),
            autoTrailingIcon: true,
          ),
        MessageBoxType.success => (
            cardColor: const Color(0xFF00B67A).withValues(alpha: 0.1),
            borderColor: const Color(0xFF00B67A),
            leadingIcon:
                const Icon(Icons.done_all, color: Colors.white, size: 16),
            autoTrailingIcon: true,
          ),
        MessageBoxType.warning => (
            cardColor: const Color(0xFFFF8400).withValues(alpha: 0.2),
            borderColor: const Color(0xFFFF8400),
            leadingIcon: const Icon(
              Symbols.emergency_home,
              color: Color(0xFFFF8400),
              size: 16,
            ),
            autoTrailingIcon: true,
          ),
        MessageBoxType.locked => (
            cardColor: const Color(0xFF262626),
            borderColor: const Color(0xFF343434),
            leadingIcon: const Opacity(
              opacity: 0.8,
              child: Icon(
                Icons.lock_outline,
                color: Color(0xFFFFFFFF),
                size: 16,
              ),
            ),
            autoTrailingIcon: false,
          ),
        MessageBoxType.info => (
            cardColor: const Color(0xFF5540BF).withValues(alpha: 0.2),
            borderColor: const Color(0xFF5540BF),
            leadingIcon: const Opacity(
              opacity: 0.8,
              child: Icon(
                Icons.info_outlined,
                color: Color(0xFFFFFFFF),
                size: 16,
              ),
            ),
            autoTrailingIcon: true,
          ),
      };
}

class MessageBox extends StatelessWidget {
  const MessageBox({
    super.key,
    required this.messageBoxType,
    required this.content,
    this.onTap,
    this.trailing,
  });

  factory MessageBox.withRichText({
    Key? key,
    required MessageBoxType messageBoxType,
    required List<TextSpan> text,
    VoidCallback? onTap,
    Widget? trailing,
  }) =>
      MessageBox(
        key: key,
        messageBoxType: messageBoxType,
        onTap: onTap,
        content: Text.rich(TextSpan(children: text)),
        trailing: trailing,
      );

  final MessageBoxType messageBoxType;
  final Widget content;

  /// Item displayed on the right part of [MessageBox]
  ///
  /// If [trailing] is null, a ">" icon will be displayed
  /// if [onTap] is specified.
  final Widget? trailing;

  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final messageBoxStyle = messageBoxType.style;
    return Material(
      color: messageBoxStyle.cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: messageBoxStyle.borderColor,
          width: 0.5,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: messageBoxStyle.leadingIcon,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: content,
              ),
            ),
            if (_trailingIcon(messageBoxStyle) case final Widget trailing)
              trailing,
          ],
        ),
      ),
    );
  }

  Widget? _trailingIcon(MessageBoxStyle messageBoxStyle) {
    if (trailing != null) return trailing;
    if (messageBoxStyle.autoTrailingIcon && onTap != null) {
      return const Padding(
        padding: EdgeInsets.only(right: 12),
        child: Icon(
          Icons.arrow_forward_ios,
          color: Colors.white,
          size: 14,
        ),
      );
    }
    return null;
  }
}
