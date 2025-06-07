// // import 'package:zoncan/zoncan.dart';

import 'package:flutter/material.dart';
import 'package:zoncan/config/config.dart';

/// A dynamic progress indicator that shows steps as circles with titles and descriptions.
/// It now receives its current state from its parent and reports taps via a callback.
class WizardStepper extends StatefulWidget {
  final List<StepItemData> stepsData;
  final int currentStep; // This is now passed from parent
  final int lastCompletedStepIndex; // This is now passed from parent
  final ValueChanged<int>?
  onStepTapped; // Callback for when a step circle is tapped

  final double defaultCircleSize;
  final double currentCircleSize;
  final double circleVerticalPadding;
  final Color? activeColor;
  final Color? completedColor;
  final Color? defaultColor;
  final TextStyle? textStyle;
  final TextStyle? titleStyle;
  final TextStyle? descriptionStyle;

  const WizardStepper({
    super.key,
    required this.stepsData,
    required this.currentStep, // Now required
    required this.lastCompletedStepIndex, // Now required
    this.onStepTapped, // Optional callback
    this.defaultCircleSize = 24.0,
    this.currentCircleSize = 34.0,
    this.circleVerticalPadding = 5.0,
    this.activeColor = Colors.blue,
    this.completedColor = Colors.green,
    this.defaultColor = Colors.grey,
    this.textStyle,
    this.titleStyle,
    this.descriptionStyle,
  }) : assert(
         currentStep >= 1 && currentStep <= stepsData.length,
       ), // Must be a valid step
       assert(
         lastCompletedStepIndex >= -1 &&
             lastCompletedStepIndex < stepsData.length,
       );

  @override
  State<WizardStepper> createState() => _WizardStepperState();
}

class _WizardStepperState extends State<WizardStepper>
    with SingleTickerProviderStateMixin {
  late List<StepItemData> _currentStepsState;
  late AnimationController _lineAnimationController;

  @override
  void initState() {
    super.initState();
    _lineAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    // Initialize state based on widget properties
    _updateStepsState();

    // If there are already completed steps on init, show lines fully
    if (widget.lastCompletedStepIndex >= 0) {
      _lineAnimationController.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(covariant WizardStepper oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Only update internal state if the external `currentStep` or `lastCompletedStepIndex` changes
    // or if the `stepsData` list itself (titles/descriptions) changes.
    if (widget.currentStep != oldWidget.currentStep ||
        widget.lastCompletedStepIndex != oldWidget.lastCompletedStepIndex ||
        !ListEquality().equals(widget.stepsData, oldWidget.stepsData)) {
      int oldLastCompleted = oldWidget.lastCompletedStepIndex;

      _updateStepsState(); // Re-calculate internal step statuses

      // Manage animation based on the change in `lastCompletedStepIndex`
      if (widget.lastCompletedStepIndex > oldLastCompleted) {
        _lineAnimationController.forward(from: 0.0);
      } else if (widget.lastCompletedStepIndex < oldLastCompleted) {
        // If progress reversed, reset and re-animate if needed
        _lineAnimationController.reset();
        if (widget.lastCompletedStepIndex >= 0) {
          _lineAnimationController.forward();
        }
      } else {
        // If no change in completion, ensure lines are fully drawn (e.g., if only current step moved)
        _lineAnimationController.value = 1.0;
      }
    }
  }

  /// Updates the status of each step in `_currentStepsState` based on
  /// `widget.currentStep` and `widget.lastCompletedStepIndex`.
  void _updateStepsState() {
    _currentStepsState = List.generate(widget.stepsData.length, (index) {
      StepStatus status = StepStatus.notStarted;
      bool isPassed = false;
      // Mark completed steps
      if (index <= widget.lastCompletedStepIndex) {
        status = StepStatus.completed;
        isPassed = true;
      }

      // Mark current step (overrides completed if current step is also completed)
      // Only mark as current if it's not already completed AND it's the current step.
      // Or if it's the last step and _lastCompletedStepIndex is not yet its index.
      if (index == widget.currentStep - 1 &&
          index > widget.lastCompletedStepIndex) {
        status = StepStatus.current;
        isPassed = true;
      }
      // Special case: if _currentStep is the last step and it's also completed, it should still show as completed
      // But if it's the last step and _lastCompletedStepIndex is NOT the last step index, it should be current.
      if (index == widget.stepsData.length - 1 &&
          widget.currentStep == widget.stepsData.length &&
          widget.lastCompletedStepIndex < widget.stepsData.length - 1) {
        status = StepStatus.current;
        isPassed = true;
      }

      return widget.stepsData[index].copyWith(status: status);
    });
  }

  /// Internal handler for step taps, which then calls the external `onStepTapped` callback.
  void _handleStepCircleTap(int tappedStepNumber) {
    // We only pass the tap event to the parent.
    // The parent is responsible for updating the currentStep and lastCompletedStepIndex.
    // The validation logic for what steps can be tapped will reside in the parent.
    widget.onStepTapped?.call(tappedStepNumber);
  }

  @override
  void dispose() {
    _lineAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9, // Adjust width as needed
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_currentStepsState.length, (index) {
            final step = _currentStepsState[index];
            return Padding(
              padding: EdgeInsets.symmetric(
                vertical: widget.circleVerticalPadding,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ProgressStepCircle(
                    step: step,
                    defaultSize: widget.defaultCircleSize,
                    currentStepSize: widget.currentCircleSize,
                    activeColor: widget.activeColor,
                    completedColor: widget.completedColor,
                    defaultColor: widget.defaultColor,
                    textStyle: widget.textStyle,
                    onTap:
                        () => _handleStepCircleTap(
                          step.number,
                        ), // Make circles clickable
                  ),
                  const SizedBox(
                    width: kSpacing,
                  ), // Space between circle and text
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min, // Use minimum space
                      children: [
                        Text(
                          step.title,
                          style: widget.titleStyle?.copyWith(
                            color:
                                step.status == StepStatus.current
                                    ? widget.activeColor
                                    : step.status == StepStatus.completed
                                    ? widget.completedColor
                                    : widget.defaultColor,
                          ),
                        ),
                        step.status == StepStatus.current
                            ? Text(
                              step.description,
                              style: widget.descriptionStyle?.copyWith(
                                color:
                                    step.status == StepStatus.current
                                        ? widget.activeColor?.withAlpha(150)
                                        : step.status == StepStatus.completed
                                        ? widget.completedColor?.withAlpha(150)
                                        : widget.defaultColor?.withAlpha(150),
                              ),
                            )
                            : Container(),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}

/// Enum to define the status of each step in the progress indicator.
enum StepStatus { notStarted, current, completed }

/// Data model for a single step in the progress indicator.
/// Now includes title and description for each step.
class StepItemData {
  final int number;
  final String title;
  final String description;
  final AppRoute route;
  StepStatus status; // This status will be dynamically updated internally

  StepItemData({
    required this.number,
    required this.title,
    required this.description,
    required this.route,
    this.status = StepStatus.notStarted,
  });

  // Create a copy with a new status
  StepItemData copyWith({StepStatus? status}) {
    return StepItemData(
      number: number,
      title: title,
      description: description,
      route: route,
      status: status ?? this.status,
    );
  }
}

// ---
// ProgressStepCircle Widget (Unchanged)
// ---

/// A single circular step indicator for the progress bar.
///
/// It animates its size and color based on the [step]'s status
/// and animates its content (number or checkmark). Now also accepts an onTap callback.
class ProgressStepCircle extends StatelessWidget {
  final StepItemData step; // Now uses StepItemData
  final double defaultSize;
  final double currentStepSize;
  final Color? activeColor;
  final Color? completedColor;
  final Color? defaultColor;
  final TextStyle? textStyle;
  final VoidCallback? onTap; // Added onTap callback

  const ProgressStepCircle({
    super.key,
    required this.step,
    this.defaultSize = 40.0,
    this.currentStepSize = 50.0,
    this.activeColor = Colors.blue,
    this.completedColor = Colors.green,
    this.defaultColor = Colors.grey,
    this.textStyle,
    this.onTap, // Initialize onTap
  });

  @override
  Widget build(BuildContext context) {
    Color? circleColor;
    double? size;
    Widget childWidget;

    switch (step.status) {
      case StepStatus.completed:
        circleColor = completedColor;
        size = defaultSize;
        childWidget = const Icon(
          Icons.check,
          color: Colors.white,
          size: 20,
          key: ValueKey('check'), // Unique key for AnimatedSwitcher
        );
        break;
      case StepStatus.current:
        circleColor = activeColor;
        size = currentStepSize;
        childWidget = Text(
          '${step.number}',
          style: textStyle?.copyWith(fontSize: 20),
          key: ValueKey('number_${step.number}'), // Unique key
        );
        break;
      case StepStatus.notStarted:
        circleColor = defaultColor;
        size = defaultSize;
        childWidget = Text(
          '${step.number}',
          style: textStyle,
          key: ValueKey('number_${step.number}_default'), // Unique key
        );
        break;
    }

    return GestureDetector(
      onTap: onTap, // Apply the onTap here
      child: AnimatedContainer(
        duration: const Duration(
          milliseconds: 500,
        ), // Animate size and color changes
        width: size,
        height: size,
        decoration: BoxDecoration(color: circleColor, shape: BoxShape.circle),
        alignment: Alignment.center,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return ScaleTransition(
              scale: animation,
              child: child,
            ); // Simple scale transition
          },
          child: childWidget,
        ),
      ),
    );
  }
}

// Helper for deep list comparison
class ListEquality {
  bool equals(List<StepItemData>? list1, List<StepItemData>? list2) {
    if (list1 == list2) return true;
    if (list1 == null || list2 == null) return false;
    if (list1.length != list2.length) return false;
    for (int i = 0; i < list1.length; i++) {
      if (list1[i] != list2[i]) return false;
    }
    return true;
  }
}
