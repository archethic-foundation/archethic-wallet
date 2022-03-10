// Flutter imports:
import 'package:aemail/constants.dart';
import 'package:flutter/material.dart';

// Project imports:

class CounterBadge extends StatelessWidget {
  const CounterBadge({
    Key? key,
    @required this.count,
  }) : super(key: key);

  final int? count;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
          color: kBadgeColor, borderRadius: BorderRadius.circular(9)),
      child: Text(
        count.toString(),
        style: Theme.of(context).textTheme.caption!.copyWith(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
      ),
    );
  }
}
