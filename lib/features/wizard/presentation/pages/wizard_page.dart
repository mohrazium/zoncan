import 'package:floy/floy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:zoncan/core/common/common.dart';

import '../views/setup_wizard_view.dart';

class WizardPage extends HookWidget {
  final Widget child;

  const WizardPage({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: FloyResponsive(
        largePage: SetupWizardView(child: child),
        unsupportedSizePage: const UnsupportedSizeScreen(),
      ),
    );
  }
}