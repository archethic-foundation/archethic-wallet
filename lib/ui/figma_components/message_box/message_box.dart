import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

// TODO(reddwarf03): Update locked
enum MessageBoxType { success, warning, locked }

class MessageBox extends StatelessWidget {
  const MessageBox({
    super.key,
    required this.messageBoxType,
    required this.text,
    this.onTap,
  });

  final MessageBoxType messageBoxType;
  final String text;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    if (text.isEmpty) {
      return const SizedBox();
    }

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
                  child: Text(
                    text,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
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
        return const Color(0xFF00B67A).withOpacity(0.1);
      case MessageBoxType.warning:
        return const Color(0xFFFF8400).withOpacity(0.2);
      case MessageBoxType.locked:
        return const Color(0xFF262626);
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
    }
  }
}
