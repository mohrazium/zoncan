part of zoncan.features.splash;

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 1)).then((s) {
      Modular.to.navigate(Routing.routes().home.path);
    });

    return const SplashScreen.show(
      title: Text("title"),
      loadingText: Text("loading"),
    );
  }
}
