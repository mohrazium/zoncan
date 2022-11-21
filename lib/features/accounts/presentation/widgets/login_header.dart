part of zoncan.features.accounts.presentation;

class LoginHeader extends StatelessWidget {
  const LoginHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var translator = Translations.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          width: kSpacing,
        ),
        Image.asset(
          Assets.icons.logo96PNG,
          // fit: BoxFit.fill,
          height: kLogoHeight,
          width: kLogoWidth,
        ),
        const SizedBox(
          width: kSpacing,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              translator.appName,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  inherit: true, fontWeight: FontWeight.bold),
            ),
            Text(
              translator.appDescriptor,
              maxLines: 2,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(
              height: kSpacing,
            ),
          ],
        ),
        const SizedBox(
          width: kSpacing,
        ),
      ],
    );
  }
}
