import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;

enum StepStatus { pending, inProgress, completed, failed }

class Step {
  Step(this.stepIndex, this.status, this.failure);
  final int stepIndex;
  final StepStatus status;
  final aedappfm.Failure? failure;
}

class StepsState {
  StepsState(this.steps, {this.snapshot});
  final List<Step> steps;
  final Map<String, dynamic>? snapshot;
}
