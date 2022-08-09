part of zoncan.features.login;

class AccountsViewLarge extends StatefulWidget {
  const AccountsViewLarge({Key? key}) : super(key: key);

  @override
  State<AccountsViewLarge> createState() => _AccountsViewLargeState();
}

class _AccountsViewLargeState extends State<AccountsViewLarge> {
  @override
  void initState() {
    Modular.to.navigate(Routing.routes().login.path);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Scaffold(
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(Assets.images.loginBackgroundJPG),
          )),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  BlurryContainer(
                    blur: 5,
                    elevation: 0,
                    color: Theme.of(context).splashColor,
                    padding: const EdgeInsets.all(8),
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    height: 600,
                    width: 1000,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                              flex: 4,
                              child: GroupBox(
                                  color: Theme.of(context).cardColor,
                                  padding: const EdgeInsets.all(kPadding * 2),
                                  margin: const EdgeInsets.all(kMargin),
                                  child: const RouterOutlet())),
                          Expanded(
                            flex: 6,
                            child: Slider(slides: [
                              Slide(
                                  image: AssetImage(
                                Assets.images.bg41PNG,
                              )),
                            ]),
                          ),
                        ]),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
