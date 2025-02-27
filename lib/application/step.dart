import 'package:aewallet/domain/models/step.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StepsNotifier extends StateNotifier<StepsState> {
  StepsNotifier() : super(StepsState([]));

  void initializeSteps(int nbSteps) {
    state = StepsState(
      List<Step>.generate(
        nbSteps,
        (index) => Step(
          index,
          StepStatus.pending,
          null,
        ),
      ),
    );
  }

  void updateStepStatus(int stepIndex, StepStatus status, {String? reason}) {
    final updatedSteps = List<Step>.from(state.steps);
    updatedSteps[stepIndex] = Step(
      stepIndex,
      status,
      reason,
    );
    state = StepsState(updatedSteps);
  }
}

final stepsNotifierProvider =
    StateNotifierProvider<StepsNotifier, StepsState>((ref) {
  return StepsNotifier();
});
