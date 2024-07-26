part of '../../splash.dart';


class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SplashScreen.show(
      title: Text("title"),
      loadingText: Text("loading"),
    );
  }
}