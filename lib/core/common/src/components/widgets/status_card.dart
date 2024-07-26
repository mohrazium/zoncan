part of '../components.dart';

class StatusCardData {
  final String label;
  final String value;
  final String descriptions;

  const StatusCardData({
    required this.label,
    required this.value,
    required this.descriptions,
  });
}

class StatusCard extends StatelessWidget {
  const StatusCard({
    required this.data,
    required this.primary,
    required this.onPrimary,
    Key? key,
  }) : super(key: key);

  final StatusCardData data;
  final Color primary;
  final Color onPrimary;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(kBorderRadius),
      child: Material(
        child: InkWell(
          onTap: () {},
          child: Container(
            width: 250 * Fonts.instance.fontScale,
            height: 250 * Fonts.instance.fontScale,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primary, primary.withOpacity(.7)],
                begin: AlignmentDirectional.topCenter,
                end: AlignmentDirectional.bottomCenter,
              ),
            ),
            child: _BackgroundDecoration(
              child: Padding(
                padding:  EdgeInsets.all(kPadding * Fonts.instance.fontScale),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 150 * Fonts.instance.fontScale,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildLabel(),
                           SizedBox(height: 20 * Fonts.instance.fontScale),
                          _buildValuePresenter(),
                        ],
                      ),
                    ),
                    const Spacer(flex: 1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildDescriptions(),
                        // SizedBox(
                        //   height: 20,
                        //   child: VerticalDivider(
                        //     thickness: 1,
                        //     color: onPrimary,
                        //   ),
                        // ),
                        // _buildHours(),
                      ],
                    ),
                    // const Spacer(flex: 2),
                    // _doneButton(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel() {
    return Text(
      convertEnToFa(data.label),
      style: TextStyle(
        fontSize: 18 * Fonts.instance.fontScale,
        fontWeight: FontWeight.w800,
        color: onPrimary,
        letterSpacing: 1,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildValuePresenter() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 200 * Fonts.instance.fontScale,
          decoration: BoxDecoration(
            color: onPrimary.withOpacity(.3),
            borderRadius: BorderRadius.circular(kBorderRadius),
          ),
          padding:  EdgeInsets.symmetric(horizontal: 10 * Fonts.instance.fontScale, vertical: 5 * Fonts.instance.fontScale),
          child: Center(
            child: Text(
              convertEnToFa(data.value),
              style: TextStyle(
                color: onPrimary,
                fontSize: Fonts.instance.headline3().fontSize,
                letterSpacing: 1,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDescriptions() {
    return _IconLabel(
      color: onPrimary,
      iconData: EvaIcons.listOutline,
      label: convertEnToFa(data.descriptions),
    );
  }

  // Widget _buildHours() {
  //   return _IconLabel(
  //     color: onPrimary,
  //     iconData: EvaIcons.clockOutline,
  //     label: data.descriptions.descriptions(),
  //   );
  // }

  // Widget _doneButton() {
  //   return ElevatedButton.icon(
  //     onPressed: () {},
  //     style: ElevatedButton.styleFrom(
  //       primary: onPrimary,
  //       onPrimary: primary,
  //     ),
  //     icon: const Icon(EvaIcons.checkmarkCircle2Outline),
  //     label: const Text("Done"),
  //   );
  // }
}

class _IconLabel extends StatelessWidget {
  const _IconLabel({
    required this.color,
    required this.iconData,
    required this.label,
    Key? key,
  }) : super(key: key);

  final Color color;
  final IconData iconData;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          iconData,
          color: color,
          size: Fonts.instance.subtitle1().fontSize,
        ),
         SizedBox(width: 5 * Fonts.instance.fontScale),
        Text(
          label,
          style: TextStyle(
            fontSize: Fonts.instance.subtitle1().fontSize,
            color: color.withOpacity(.8),
          ),
        )
      ],
    );
  }
}

class _BackgroundDecoration extends StatelessWidget {
  const _BackgroundDecoration({required this.child, Key? key})
      : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: Transform.translate(
            offset: const Offset(25, -25),
            child: CircleAvatar(
              radius: 50 * Fonts.instance.fontScale,
              backgroundColor: Colors.white.withOpacity(.1),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Transform.translate(
            offset: const Offset(-70, 70),
            child: CircleAvatar(
              radius: 100 * Fonts.instance.fontScale,
              backgroundColor: Colors.white.withOpacity(.1),
            ),
          ),
        ),
        child,
      ],
    );
  }
}
