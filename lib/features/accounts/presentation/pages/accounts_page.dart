
import 'package:floy/floy.dart';
import 'package:flutter/material.dart';
import 'package:zoncan/core/common/common.dart';

import '../views/accounts_view_large.dart';

class AccountsPage extends StatelessWidget {
  final Widget child;

  const AccountsPage({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: FloyResponsive(
      largePage: AccountsViewLarge(
        child: child,
      ),
      xLargePage: AccountsViewLarge(
        child: child,
      ),
      xxLargePage: AccountsViewLarge(
        child: child,
      ),
      unsupportedSizePage: const UnsupportedSizeScreen(),
    ));
  }
}
