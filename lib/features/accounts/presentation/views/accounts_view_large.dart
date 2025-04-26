import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:zoncan/config/config.dart';
import 'package:zoncan/core/common/common.dart';

import '../widgets/slider.dart';

class AccountsViewLarge extends StatefulWidget {
  final Widget child;

  const AccountsViewLarge({super.key, required this.child});

  @override
  State<AccountsViewLarge> createState() => _AccountsViewLargeState();
}

class _AccountsViewLargeState extends State<AccountsViewLarge> {
  @override
  void initState() {
    // GoRoute..to.navigate(Routing.to.login.path);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Scaffold(
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(Assets.images.loginBackgroundJPG),
              ),
            ),
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
                      height: 650,
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
                              child: widget.child,
                            ),
                          ),
                          Expanded(
                            flex: 6,
                            child: ZSlider(
                              slides: [
                                ZSlide(
                                  image: AssetImage(Assets.images.bg41PNG),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
