import 'package:aewallet/domain/models/step.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
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

  void updateStepStatus(
    int stepIndex,
    StepStatus status, {
    Map<String, dynamic>? snapshot,
    aedappfm.Failure? failure,
  }) {
    final updatedSteps = List<Step>.from(state.steps);
    updatedSteps[stepIndex] = Step(
      stepIndex,
      status,
      failure,
    );
    if (snapshot != null) {
      state = StepsState(
        updatedSteps,
        snapshot: snapshot,
      );
    } else {
      state = StepsState(
        updatedSteps,
        snapshot: state.snapshot,
      );
    }
  }
}

final stepsNotifierProvider =
    StateNotifierProvider<StepsNotifier, StepsState>((ref) {
  return StepsNotifier();
});
