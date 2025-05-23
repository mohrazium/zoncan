import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_popup/flutter_popup.dart';
import 'package:zoncan/config/config.dart';
import 'package:zoncan/core/common/common.dart'
    show DialogButtons, DialogHelper, DialogResult, DialogType;
import 'package:zoncan/core/common/components/widgets/group_box.dart';
import 'package:zoncan/features/home/presentation/controllers/home_controller.dart';

class ProfilePopup extends StatelessWidget {
  final HomeController controller;
  const ProfilePopup({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final translator = TranslationsProvider.translator;
    final currentUser = controller.appStateController.currentUser;
    return CustomPopup(
      barrierColor: Colors.transparent,
      content: Observer(
        builder: (_) {
          final bool canPress = !controller.logoutState.isLoading;
          return GroupBox(
            width: 150,
            child: Transform.scale(
              scale: controller.appStateController.scaleFactor,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.blueGrey,
                    backgroundImage: null,
                    child: Image(
                      image: AssetImage(Assets.images.profilePictureTemp),
                    ),
                  ),
                  const SizedBox(height: kSpacing),

                  Text(
                    currentUser?.nickName ?? "",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      inherit: true,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  (currentUser?.person?.name != null &&
                          currentUser?.person?.family != null)
                      ? Text(
                        "${currentUser?.person?.name} ${currentUser?.person?.family}",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          inherit: true,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                      : Container(),
                  const SizedBox(height: kSpacing),
                  Text(
                    currentUser?.userName ?? "",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      inherit: true,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  (currentUser?.person?.name != null &&
                          currentUser?.person?.family != null)
                      ? Text(
                        currentUser?.phoneNumber ?? "",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          inherit: true,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                      : Container(),

                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(EvaIcons.logOut),
                        onPressed: () async {
                          if (canPress) {
                            final res = await DialogHelper.showMessageBox(
                              context: context,
                              title: translator.accounts.logout,
                              message: translator.accounts.sureToLogout,
                              dialogType: DialogType.WARNING,
                              dialogButtons: DialogButtons.YES_NO,
                            );
                            if (res == DialogResult.YES) {
                              await controller.logoutUser();
                            }
                          }
                        },

                        color: Colors.grey,
                      ),
                      IconButton(
                        icon: Icon(Icons.settings),
                        onPressed: () {},
                        color: Colors.grey,
                      ),
                      IconButton(
                        icon: Icon(Icons.lock),
                        onPressed: () {},
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
      child: Observer(
        builder: (_) {
          return Transform.scale(
            scale: controller.appStateController.scaleFactor,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blueGrey.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.all(2),
                margin: const EdgeInsets.all(2),
                child: CircleAvatar(
                  backgroundColor: Colors.blueGrey,
                  backgroundImage: null,
                  child: Image(
                    image: AssetImage(Assets.images.profilePictureTemp),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
