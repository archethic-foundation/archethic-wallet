import 'package:aewallet/ui/views/main/messenger_tab/components/talk_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class LoadingTalksList extends StatelessWidget {
  const LoadingTalksList({super.key});

  @override
  Widget build(BuildContext context) => ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) => TalkListItem.loading(
          animationDelay: (10 * index).ms,
        ),
      );
}
