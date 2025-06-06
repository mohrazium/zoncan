import 'package:flutter/material.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:zoncan/config/config.dart';
import 'package:zoncan/features/wizard/presentation/pages/wizard_page.dart';

class WizardRouetr {
  static WizardRouetr get get => WizardRouetr();

  QRoute get routes => QRoute.withChild(
    path: Routing.to.wizard.path,
    name: Routing.to.wizard.named,
    builderChild: (router) => WizardPage(child: router),
    initRoute: Routing.to.wizardStepVerifyPhonenumber.path,
    children: [
      QRoute(
        path: Routing.to.wizardStepVerifyPhonenumber.named,
        name: Routing.to.wizardStepVerifyPhonenumber.named,
        builder:
            () =>
                Container( color: Colors.green),
      ),
      // QRoute(path: Routing.to.products.named, name: Routing.to.products.named, builder: () => const ProductsPage()),
    ],
  );
}
