part of zoncan.features.accounts.presentation;

class LoginHeader extends StatelessWidget {
  const LoginHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "زونکن", //TODO: add to localization.
              style: Theme.of(context).textTheme.subtitle1?.copyWith(
                  inherit: true, fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            Text(
              "سیستم مدیریت مالی", //TODO: add to localization.
              style: Theme.of(context).textTheme.subtitle1?.copyWith(
                  inherit: true, fontSize: 14.0, fontWeight: FontWeight.bold),
            ),
            Text(
              "با زونکن حساب و کتاب کن", //TODO: add to localization.
              maxLines: 2,
              style: Theme.of(context).textTheme.caption,
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
