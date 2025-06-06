import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:zoncan/config/src/constants/app_constants.dart';

class WizardTitleInfo extends StatelessWidget {
  final String info;
  const WizardTitleInfo({super.key, required this.info});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(kPadding),
      padding: const EdgeInsets.all(kPadding / 3),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary.withValues(alpha: .1),
        borderRadius: BorderRadius.all(Radius.circular(kBorderRadius)),
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            EvaIcons.clockOutline,
            color: Theme.of(
              context,
            ).colorScheme.onPrimary.withValues(alpha: .8),
            size: 16.0,
          ),
          const SizedBox(width: 5.0),
          Text(
            info,
            style: TextStyle(
              color: Theme.of(
                context,
              ).colorScheme.onPrimary.withValues(alpha: .8),
              fontSize: 12.0,
            ),
          ),
        ],
      ),
    );
  }
}
