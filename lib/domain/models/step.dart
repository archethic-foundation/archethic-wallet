enum StepStatus { pending, inProgress, completed, failed }

class Step {
  Step(this.stepIndex, this.status, this.reason);
  final int stepIndex;
  final StepStatus status;
  final String? reason;
}

class StepsState {
  StepsState(this.steps);
  final List<Step> steps;
}
