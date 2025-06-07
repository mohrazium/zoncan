import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:zoncan/app/app.dart';
import 'package:zoncan/core/exceptions/exceptions.dart';
import 'package:zoncan/core/common/common.dart';

part 'wizard_controller.g.dart';

@Injectable()
class WizardController extends _WizardController with _$WizardController {
  WizardController();

  @override
  Future<void> initState() async {
    Future.microtask(() async {}).whenComplete(() {
      ZLogger(
        logLevel: LogLevel.INFO,
        message: "${this.runtimeType} has been initialized.",
      );
    });
  }

  @override
  void didChangeDependencies() {
    Future.microtask(() async {}).whenComplete(() {
      ZLogger(
        logLevel: LogLevel.INFO,
        message: "${this.runtimeType} dependencies changed.",
      );
    });
  }

  @override
  void dispose() {
    Future.microtask(() async {}).whenComplete(() {
      ZLogger(
        logLevel: LogLevel.INFO,
        message: "${this.runtimeType} disposed.",
      );
    });
  }
}

abstract class _WizardController extends Controller with Store {
  _WizardController();

  // @observable
  // UsecaseExecutor<bool?> logoutState = UsecaseExecutor<bool?>();

  @observable
  FailureException? exception;

  @observable
  late List<StepItemData> stepsData;

  @observable
  int currentStep = 1; // 0-based index of the currently displayed step

  @observable
  int lastCompletedStep = -1; // 0-based index of the last step successfully completed

  @computed
  StepItemData get currentStepItemData => stepsData[currentStep-1];

  @computed
  double get progressValue =>
      stepsData.last.number == 0
          ? 0.1
          : (stepsData[currentStep - 1].number) / (stepsData.last.number);

  @computed
  bool get isAllStepsCompleted =>
      (currentStep == stepsData.length &&
          lastCompletedStep == stepsData.length);
  @computed
  bool get isAtStart => (currentStep == 1 && lastCompletedStep == -1);

  @computed
  bool get isAtEnd => currentStep == stepsData.length;

  @computed
  String? get previousTitle =>
      currentStep >= 2 ? stepsData[currentStep - 2].title : null;
  @computed
  String? get currentTitle =>
      currentStep >= 1 ? stepsData[currentStep - 1].title : null;
  @computed
  String? get nextTitle =>
      currentStep <= stepsData.length ? currentStep == stepsData.length ? null: stepsData[currentStep-1].title : null;
  @action
  void initStepsData(List<StepItemData> steps) => stepsData = steps;
  // Actions for navigation
  @action
  Future<void> nextStep() async {
    try {
      if (currentStep == stepsData.length) {
        if (lastCompletedStep < stepsData.length - 1) {
          lastCompletedStep = stepsData.length - 1;
        }
      } else {
        lastCompletedStep = currentStep - 1;
        currentStep++;
      }
    } catch (e) {
      debugPrint("eerorr =>$e");
    }
    ZLogger(
      logLevel: LogLevel.INFO,
      message:
          'Next: Current Step: $currentStep, Last Completed Index: $lastCompletedStep',
    );
  }

  @action
  Future<void> previousStep() async {
    // If all steps are completed, and we press previous, un-complete the last step
    if (lastCompletedStep == stepsData.length - 1 &&
        currentStep == stepsData.length) {
      lastCompletedStep = stepsData.length - 2; // Un-complete the last step
      // currentStep remains the last step, but it will now be "current" again, not "completed"
    }
    // If not at the very beginning (step 1 and no completed steps)
    else if (currentStep > 1) {
      currentStep--;
      // If the new current step is 1, then no steps are completed
      if (currentStep == 1) {
        lastCompletedStep = -1;
      } else {
        // The step *before* the new current step should be the last completed
        lastCompletedStep = currentStep - 1;
      }
    }
    debugPrint(
      'Previous: Current Step: $currentStep, Last Completed Index: $lastCompletedStep',
    );
  }

  @action
  void resetProgress() {
    currentStep = 1;
    lastCompletedStep = -1;
  }

  @action
  void onStepTapped(int tappedStepNumber) {
    final tappedIndex =
        tappedStepNumber - 1; // Convert 1-based to 0-based index

    // Capture the status of the tapped item *before* any state changes
    final bool wasTappedItemCurrent = (tappedIndex == currentStep - 1);

    // Case 1: Tapping the current step (do nothing to general progress)
    if (tappedIndex == currentStep - 1) {
      debugPrint('Tapped current step: No change in general progress.');
      if (wasTappedItemCurrent) {
        debugPrint(
          'Calling specific onTapped callback for step ${tappedIndex + 1}',
        );
      }
      return; // Don't proceed with general progress changes
    }

    // Cases 2 & 3: Tapping a completed or future step (standard progress logic)
    if (tappedIndex < currentStep - 1) {
      currentStep = tappedStepNumber;
      lastCompletedStep = tappedIndex - 1;
    } else if (tappedIndex > currentStep - 1) {
      if (tappedIndex == currentStep) {
        lastCompletedStep = currentStep - 1;
        currentStep = tappedStepNumber;
      } else {
        debugPrint(
          'Cannot jump directly to a future step. Please complete previous steps first.',
        );
        return;
      }
    }
    debugPrint(
      'Tapped: Current Step: $currentStep, Last Completed Index: $lastCompletedStep',
    );
  }
}
