import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:zoncan/config/config.dart';
import 'package:zoncan/config/src/constants/app_constants.dart';
import 'package:zoncan/core/common/common.dart';
import '../widgets/wizard_title.dart';
import '../widgets/wizard_title_info.dart';

class SetupWizardView extends HookWidget {
  final Widget child;
  const SetupWizardView({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    // Define your step data here, including titles and descriptions
    // This can be a constant list since it doesn't change during runtime
    final List<StepItemData> stepsData = useMemoized(
      () => [
        // Use useMemoized for constant data
        StepItemData(
          number: 1,
          title: 'Order Placed',
          description: 'Your order has been received.',
          onTapped: () {
            debugPrint("1 step called");
          },
          content: Container(color: Colors.amber, child: Text("data")),
        ),
        StepItemData(
          number: 2,
          title: 'Payment Confirmed',
          description: 'Payment successfully processed.',
          content: GroupBox(color: Colors.blue, child: Text("data")),
          onTapped: () {
            debugPrint("2 step called");
          },
        ),
      ],
    );

    // Use useState to manage mutable state
    final currentStep = useState(1); // 1-based index
    final lastCompletedStepIndex = useState(-1); // 0-based index

    // Helper functions for step navigation
    final nextStep = useCallback(
      () {
        // If we are currently on the last step
        if (currentStep.value == stepsData.length) {
          // And if the last step is not yet marked as completed
          if (lastCompletedStepIndex.value < stepsData.length - 1) {
            lastCompletedStepIndex.value =
                stepsData.length - 1; // Mark the very last step as completed
          }
        }
        // If not at the last step, proceed to the next step normally
        else {
          lastCompletedStepIndex.value =
              currentStep.value - 1; // Mark the current step as completed
          currentStep.value++; // Move to the next step
        }
        debugPrint(
          'Next: Current Step: ${currentStep.value}, Last Completed Index: ${lastCompletedStepIndex.value}',
        );
      },
      [currentStep, lastCompletedStepIndex, stepsData.length],
    ); // Dependencies for useCallback

    final previousStep = useCallback(() {
      // If all steps are completed, and we press previous, un-complete the last step
      if (lastCompletedStepIndex.value == stepsData.length - 1 &&
          currentStep.value == stepsData.length) {
        lastCompletedStepIndex.value =
            stepsData.length - 2; // Un-complete the last step
        // currentStep remains the last step, but it will now be "current" again, not "completed"
      }
      // If not at the very beginning (step 1 and no completed steps)
      else if (currentStep.value > 1) {
        currentStep.value--;
        // If the new current step is 1, then no steps are completed
        if (currentStep.value == 1) {
          lastCompletedStepIndex.value = -1;
        } else {
          // The step *before* the new current step should be the last completed
          lastCompletedStepIndex.value = currentStep.value - 1;
        }
      }
      debugPrint(
        'Previous: Current Step: ${currentStep.value}, Last Completed Index: ${lastCompletedStepIndex.value}',
      );
    }, [currentStep, lastCompletedStepIndex, stepsData.length]);

    final resetProgress = useCallback(() {
      currentStep.value = 1;
      lastCompletedStepIndex.value = -1;
      debugPrint(
        'Reset: Current Step: ${currentStep.value}, Last Completed Index: ${lastCompletedStepIndex.value}',
      );
    }, [currentStep, lastCompletedStepIndex]);
    final double progressValue;
    if (stepsData.last.number == 0) {
      // Avoid division by zero if stepsData is empty or misconfigured
      progressValue = 0.01;
    } else {
      progressValue =
          (stepsData[currentStep.value - 1].number) / (stepsData.last.number);
    }
    final handleStepTappedFromIndicator = useCallback(
      (int tappedStepNumber) {
        final tappedIndex =
            tappedStepNumber - 1; // Convert 1-based to 0-based index

        // Capture the status of the tapped item *before* any state changes
        final bool wasTappedItemCurrent =
            (tappedIndex == currentStep.value - 1);
        final VoidCallback? tappedItemCallback =
            stepsData[tappedIndex].onTapped;

        // Case 1: Tapping the current step (do nothing to general progress)
        if (tappedIndex == currentStep.value - 1) {
          debugPrint('Tapped current step: No change in general progress.');
          if (wasTappedItemCurrent && tappedItemCallback != null) {
            debugPrint(
              'Calling specific onTapped callback for step ${tappedIndex + 1}',
            );
            tappedItemCallback(); // Call the specific callback
          }
          return; // Don't proceed with general progress changes
        }

        // Cases 2 & 3: Tapping a completed or future step (standard progress logic)
        if (tappedIndex < currentStep.value - 1) {
          currentStep.value = tappedStepNumber;
          lastCompletedStepIndex.value = tappedIndex - 1;
        } else if (tappedIndex > currentStep.value - 1) {
          if (tappedIndex == currentStep.value) {
            lastCompletedStepIndex.value = currentStep.value - 1;
            currentStep.value = tappedStepNumber;
          } else {
            debugPrint(
              'Cannot jump directly to a future step. Please complete previous steps first.',
            );
            return;
          }
        }
        debugPrint(
          'Tapped: Current Step: ${currentStep.value}, Last Completed Index: ${lastCompletedStepIndex.value}',
        );
      },
      [currentStep, lastCompletedStepIndex, stepsData],
    ); // Add stepsData to dependencies for onTapped access

    // Determine conditions for button enablement
    bool isAllStepsCompleted =
        (currentStep.value == stepsData.length &&
            lastCompletedStepIndex.value == stepsData.length - 1);
    bool isAtStart =
        (currentStep.value == 1 && lastCompletedStepIndex.value == -1);

    String? previousTitle;
    String? currentTitle;
    String? nextTitle;

    try {
      previousTitle = stepsData[currentStep.value - 2].title;
    } catch (i) {
      //ignore
    }
    try {
      currentTitle = stepsData[currentStep.value - 1].title;
    } catch (i) {
      //ignore
    }
    try {
      nextTitle = stepsData[currentStep.value].title;
    } catch (ignore) {
      nextTitle = "پایان";
    }

    return InnerScafold(
      backgroundColor: Theme.of(context).hoverColor,
      floatingActionButton: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            mini: true,
            onPressed:
                isAllStepsCompleted
                    ? () {
                      QR.to(Routing.to.dashboard.path);
                    }
                    : nextStep,
            heroTag: 'next',
            child:
                isAllStepsCompleted
                    ? Icon(
                      EvaIcons.doneAll,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    )
                    : (currentStep.value == stepsData.length
                        ? const Text('تمام')
                        : Icon(
                          EvaIcons.arrowForward,
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                        )),
          ),
          const SizedBox(width: kSpacing),
          FloatingActionButton(
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            mini: true,
            onPressed: isAtStart ? null : previousStep,
            heroTag: 'previous',
            child: Icon(
              EvaIcons.arrowBack,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
          ),
          const SizedBox(width: kSpacing),
          FloatingActionButton(
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            mini: true,
            onPressed:
                (isAtStart && !isAllStepsCompleted) ? null : resetProgress,
            heroTag: 'reset',
            child: Icon(
              EvaIcons.refresh,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
          ),
        ],
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            padding: const EdgeInsets.all(kPadding / 3),
            color: Theme.of(context).cardColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                LinearProgressIndicator(
                  value: progressValue,
                  backgroundColor: Colors.grey[300],
                  color: Theme.of(context).colorScheme.primary,
                  minHeight: 4, // Make it a bit thicker
                  borderRadius: BorderRadius.circular(
                    kBorderRadius,
                  ), // Rounded corners
                ),
                const SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                        kPadding,
                        0,
                        kPadding,
                        0,
                      ),
                      child: SizedBox(
                        width: 200,
                        child: Text(
                          previousTitle ?? "شروع",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 200,
                      child: Text(
                        currentTitle ?? "-",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                        kPadding,
                        0,
                        kPadding,
                        0,
                      ),
                      child: SizedBox(
                        width: 200,
                        child: Text(
                          nextTitle,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  stepsData[currentStep.value - 1].description,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(
                milliseconds: 500,
              ), // Duration of the animation
              switchInCurve:
                  Curves.easeOut, // Curve for the new widget coming in
              switchOutCurve:
                  Curves.easeIn, // Curve for the old widget going out
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(opacity: animation, child: child);
              },
              // The child must have a unique key that changes when its content changes.
              // We use ValueKey with currentStep.value to achieve this.
              child: SizedBox.expand(
                key: ValueKey<int>(currentStep.value), // <-- KEY IS HERE!
                // child: stepsData[currentStep.value - 1].content,
                child: child,
              ),
            ),
          ),
        ],
      ),
      sidePanelWidth: 350,
      sidePanel: Container(
        color: Theme.of(context).primaryColor,
        child: Column(
          children: [
            ApplicationFramedLogo(),
            WizardTitle(
              title:
                  '.از اینکه نرم افزار ما را برای مدیریت امور مالی خود انتخاب کرده‌اید، سپاسگزاریم. برای شروع، لطفاً اطلاعات خواسته شده را وارد کنید',
            ),
            WizardTitleInfo(
              info: 'تکمیل این اطلاعات تقریبا ۳۰ دقیقه زمان می برد',
            ),
            WizardStepper(
              stepsData: stepsData,
              currentStep: currentStep.value,
              lastCompletedStepIndex: lastCompletedStepIndex.value,
              onStepTapped: handleStepTappedFromIndicator,
              defaultColor: Theme.of(
                context,
              ).colorScheme.onPrimary.withValues(alpha: .5),
              activeColor: Theme.of(
                context,
              ).colorScheme.onPrimary.withValues(alpha: .9),
              descriptionStyle: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              titleStyle: TextStyle(
                color: Theme.of(
                  context,
                ).colorScheme.onPrimary.withValues(alpha: .9),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
