part of '../presentation.dart';

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
