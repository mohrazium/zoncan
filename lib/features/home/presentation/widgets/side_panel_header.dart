import 'package:flutter/material.dart';
import 'package:zoncan/config/config.dart';
import 'package:zoncan/core/common/common.dart';
import 'package:zoncan/features/home/presentation/controllers/home_controller.dart';

class SidePanelHeader extends StatelessWidget {
  final HomeController controller;
  const SidePanelHeader({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    var translator = TranslationsProvider.translator;
    return Transform.scale(
      scale: controller.appStateController.scaleFactor,
      child: Padding(
        padding: const EdgeInsets.all(kPadding / 2),
        child: GroupBox(
          color: Theme.of(context).colorScheme.onPrimaryContainer.withAlpha(50),
          child: Padding(
            padding: const EdgeInsets.all(kPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  Assets.icons.logo96PNG,
                  height: kLogoHeight,
                  width: kLogoWidth,
                ),
                const SizedBox(width: kSpacing),
                Text(
                  translator.appName,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    inherit: true,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),

                const SizedBox(height: kSpacing),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
