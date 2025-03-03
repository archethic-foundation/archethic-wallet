import 'package:aewallet/ui/figma_components/custom_styles.dart';
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
    return Card(
      color: messageBoxType == MessageBoxType.success
          ? const Color(0xFF00B67A).withOpacity(0.2)
          : messageBoxType == MessageBoxType.warning
              ? const Color(0xFFFF8400).withOpacity(0.2)
              : const Color(0xFF262626),
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: messageBoxType == MessageBoxType.success
              ? const Color(0xFF00B67A)
              : messageBoxType == MessageBoxType.warning
                  ? const Color(0xFFFF8400)
                  : const Color(0xFF343434),
          width: 0.5,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        onTap: onTap,
        titleAlignment: ListTileTitleAlignment.top,
        leading: messageBoxType == MessageBoxType.success
            ? const Icon(Icons.done_all, color: Colors.white, size: 16)
            : messageBoxType == MessageBoxType.warning
                ? const Icon(
                    Symbols.emergency_home,
                    color: Color(0xFFFF8400),
                    size: 16,
                  )
                : const Opacity(
                    opacity: 0.8,
                    child: Icon(
                      Icons.lock_outline,
                      color: Color(0xFFFFFFFF),
                      size: 16,
                    ),
                  ),
        title: Padding(
          padding: const EdgeInsets.only(top: 2),
          child: Text(
            text,
            style: messageBoxType == MessageBoxType.warning
                ? Theme.of(context).textTheme.bodySmall
                : Theme.of(context).textTheme.bodySmallWithOpacity,
          ),
        ),
        trailing: onTap == null
            ? null
            : messageBoxType != MessageBoxType.locked
                ? const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 14,
                  )
                : null,
      ),
    );
  }
}
