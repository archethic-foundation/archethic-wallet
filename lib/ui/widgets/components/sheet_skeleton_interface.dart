import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class SheetSkeletonInterface {
  Widget getFloatingActionButton(BuildContext context, WidgetRef ref);

  PreferredSizeWidget getAppBar(BuildContext context, WidgetRef ref);

  Widget getSheetContent(BuildContext context, WidgetRef ref);
}
