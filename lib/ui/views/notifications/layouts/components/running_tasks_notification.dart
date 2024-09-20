part of '../tasks_notification_widget.dart';

class RunningTasksNotificationWidget extends ConsumerWidget {
  const RunningTasksNotificationWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final runningTasksCount = ref.watch(
      NotificationProviders.runningTasks
          .select((value) => value.valueOrNull?.length ?? 0),
    );

    if (runningTasksCount == 0) return const SizedBox();
    return Align(
      alignment: Alignment.topRight,
      child: Material(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: ElegantNotification(
            icon: const SizedBox.shrink(),
            stackedOptions: StackedOptions(
              key: 'top',
              itemOffset: const Offset(-5, -5),
            ),
            background: Colors.transparent,
            description: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox.square(
                  dimension: 10,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 2, right: 2),
                    child: CircularProgressIndicator(
                      strokeWidth: 0.5,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  runningTasksCount > 1
                      ? '$runningTasksCount ${AppLocalizations.of(context)!.runningTasksNotificationTasksInProgress}'
                      : '$runningTasksCount ${AppLocalizations.of(context)!.runningTasksNotificationTaskInProgress}',
                ),
              ],
            ),
            showProgressIndicator: false,
            autoDismiss: false,
            displayCloseButton: false,
            width: 250,
            height: 80,
          ),
        ),
      ),
    );
    //   ,
  }
}
