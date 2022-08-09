part of zoncan.features.login;

class AccountsPage extends StatelessWidget {
  const AccountsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
        child: FloyResponsive(
      largePage: AccountsViewLarge(),
      xLargePage: AccountsViewLarge(),
      xxLargePage: AccountsViewLarge(),
      unsupportedSizePage: UnsupportedSizeScreen(),
    ));
  }
}
