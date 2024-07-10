import 'package:flutter/material.dart';

class StepperAlertDialogButtons extends StatelessWidget {
  const StepperAlertDialogButtons({
    super.key,
    this.onStepContinue,
    this.onStepCancel,
    required this.firstStep,
    required this.lastStep, required this.onFinish,
  });

  final void Function()? onStepContinue;
  final void Function()? onStepCancel;
  final void Function() onFinish;
  final bool firstStep, lastStep;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(20),
              backgroundColor: Colors.red.shade600,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: onStepCancel,
            child: Text(
              firstStep ? "Cancel" : "Back",
              style: const TextStyle(fontSize: 18),
            ),
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Expanded(
          flex: 3,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(20),
              backgroundColor: const Color(0xff3259E8),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: lastStep ? onFinish : onStepContinue,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  lastStep ? "Finish" : "Next",
                  style: const TextStyle(fontSize: 18),
                ),
                lastStep
                    ? const SizedBox()
                    : const Icon(Icons.arrow_right_alt_sharp)
              ],
            ),
          ),
        ),
      ],
    );
  }
}
