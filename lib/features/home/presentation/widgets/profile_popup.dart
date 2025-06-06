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

class AccountSwitcherWidget extends StatelessWidget {
  const AccountSwitcherWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Define colors based on the screenshot (approximate)

    return CustomPopup(
      child: Observer(
        builder: (_) {
          return Transform.scale(
            scale: 1,
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
      content: Container(
        width: 360, // Set a typical width for such a widget/dialog
        
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // Top section: Email and Close button
              Row(
                mainAxisAlignment: MainAxisAlignment.center, // Centering the email text
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 28.0), // Space for close button on the right
                      child: Text(
                        'mohrazeum@gmail.com',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 13),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 28, // Width for the IconButton
                    height: 28, // Height for the IconButton
                    child: IconButton(
                      icon: const Icon(Icons.close,),
                      onPressed: () {
                        // Handle close action
                        print('Close button pressed');
                      },
                      iconSize: 20,
                      padding: EdgeInsets.zero,
                      tooltip: 'Close',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
      
              // Profile Picture with Camera Icon
              Stack(
                alignment: Alignment.center,
                children: [
                  const CircleAvatar(
                    radius: 40,
                    // Replace with your actual image provider
                    backgroundImage: NetworkImage(
                        'https://lh3.googleusercontent.com/a/ACg8ocK_0B9qpk9tXsGpAvxQBkPlQY7nlqD9coL2Q_x7WBIvLQ=s96-c-rg-br100'),
                  ),
                  Positioned(
                    right: (MediaQuery.of(context).size.width / 2) - 180 + 40 - 12, // Approximate centering for stack
                    bottom: 0,
                    child: Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        shape: BoxShape.circle,
                        border: Border.all( width: 2),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.camera_alt, color: Colors.white),
                        iconSize: 14,
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          // Handle camera icon press
                          print('Camera icon pressed');
                        },
                        tooltip: 'Change profile picture',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
      
              // Greeting
              const Text(
                'Hi, Mohammad Hadi!',
                style: TextStyle( fontSize: 22, fontWeight: FontWeight.w400),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
      
              // Manage your Google Account Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  elevation: 0,
                  minimumSize: const Size(200, 40), // Ensure a good tap target size
                ),
                onPressed: () {
                  // Handle manage account action
                  print('Manage your Google Account pressed');
                },
                child: const Text(
                  'Manage your Google Account',
                  style: TextStyle( fontSize: 13.5, fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(height: 24),
      
              // Divider (Subtle)
              Divider(color: Colors.grey[800], height: 1),
              const SizedBox(height: 8),
      
      
              // Show more accounts
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    print('Show more accounts tapped');
                  },
                  borderRadius: BorderRadius.circular(4.0),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 4.0),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 16,
                          
                          child: Text(
                            'Mr',
                            style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(width: 16),
                        const Expanded(
                          child: Text(
                            'Show more accounts',
                            style: TextStyle( fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                        ),
                        Icon(Icons.arrow_drop_down,size: 24),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}