import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

// TODO(dev): Update locked
enum MessageBoxType { success, warning, locked, info }

class MessageBox extends StatelessWidget {
  const MessageBox({
    super.key,
    required this.messageBoxType,
    required this.content,
    this.onTap,
  });

  factory MessageBox.withRichText({
    Key? key,
    required MessageBoxType messageBoxType,
    required List<TextSpan> text,
    VoidCallback? onTap,
  }) =>
      MessageBox(
        key: key,
        messageBoxType: messageBoxType,
        onTap: onTap,
        content: Text.rich(TextSpan(children: text)),
      );

  final MessageBoxType messageBoxType;
  final Widget content;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: _getCardColor(messageBoxType),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: _getBorderColor(messageBoxType),
          width: 0.5,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 2),
                child: _getLeadingIcon(messageBoxType),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: content,
                ),
              ),
              if (onTap != null && messageBoxType != MessageBoxType.locked)
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                  size: 14,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getCardColor(MessageBoxType messageBoxType) {
    switch (messageBoxType) {
      case MessageBoxType.success:
        return const Color(0xFF00B67A).withValues(alpha: 0.1);
      case MessageBoxType.warning:
        return const Color(0xFFFF8400).withValues(alpha: 0.2);
      case MessageBoxType.locked:
        return const Color(0xFF262626);
      case MessageBoxType.info:
        return const Color(0xFF5540BF).withValues(alpha: 0.2);
    }
  }

  Color _getBorderColor(MessageBoxType messageBoxType) {
    switch (messageBoxType) {
      case MessageBoxType.success:
        return const Color(0xFF00B67A);
      case MessageBoxType.warning:
        return const Color(0xFFFF8400);
      case MessageBoxType.locked:
        return const Color(0xFF343434);
      case MessageBoxType.info:
        return const Color(0xFF5540BF);
    }
  }

  Widget _getLeadingIcon(MessageBoxType messageBoxType) {
    switch (messageBoxType) {
      case MessageBoxType.success:
        return const Icon(Icons.done_all, color: Colors.white, size: 16);
      case MessageBoxType.warning:
        return const Icon(
          Symbols.emergency_home,
          color: Color(0xFFFF8400),
          size: 16,
        );
      case MessageBoxType.locked:
        return const Opacity(
          opacity: 0.8,
          child: Icon(
            Icons.lock_outline,
            color: Color(0xFFFFFFFF),
            size: 16,
          ),
        );
      case MessageBoxType.info:
        return const Opacity(
          opacity: 0.8,
          child: Icon(
            Icons.info_outlined,
            color: Color(0xFFFFFFFF),
            size: 16,
          ),
        );
    }
  }
}
