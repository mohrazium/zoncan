import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:zoncan/config/config.dart';
import 'package:zoncan/core/common/common.dart';

import '../widgets/slider.dart';

class AccountsView extends HookWidget {
  final Widget child;

  const AccountsView({super.key, required this.child});

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
                              child: child,
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
