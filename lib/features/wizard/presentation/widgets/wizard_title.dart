import 'package:flutter/material.dart';
import 'package:zoncan/config/src/constants/app_constants.dart';

class WizardTitle extends StatelessWidget {
  final String title;
  const WizardTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(kPadding),
        child: Text(
          title,
          softWrap: true,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary.withValues(alpha: 1),
            fontSize: 14.0,
          ),
        ),
      ),
    );
  }
}
