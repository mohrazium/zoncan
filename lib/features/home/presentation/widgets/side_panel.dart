import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:floy/floy.dart';
import 'package:flutter/material.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:zoncan/config/config.dart';
import 'package:zoncan/core/common/common.dart';
import 'package:zoncan/features/home/presentation/controllers/home_controller.dart';

class SidePanel extends StatelessWidget {
  final HomeController controller;
  const SidePanel({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: controller.appStateController.scaleFactor,
      child: FloyMenu(
        inRowItemContent: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        itemsPadding: EdgeInsets.all(kPadding),
        header: ApplicationFramedLogo(),
        itemsBorderRadius: BorderRadius.all(Radius.circular(kBorderRadius)),
        items: [
          FloyMenuItem(
            activeIcon: EvaIcons.home,
            title: "Home",
            description: "thi is description",
            totalNotify: 10,
            iconSize: 36,
            icon: EvaIcons.homeOutline,
            onTap: () => QR.to(Routing.to.dashboard.path),
          ),
          FloyMenuItem(
            activeIcon: EvaIcons.home,
            title: "Setup",
            description: "thi is description",
            totalNotify: 10,
            iconSize: 36,
            icon: EvaIcons.homeOutline,
            onTap: () => QR.to(Routing.to.firstSetup.path),
          ),
          FloyMenuItem(
            activeIcon: EvaIcons.home,
            title: "Setup",
            description: "thi is description",
            totalNotify: 10,
            iconSize: 36,
            icon: EvaIcons.homeOutline,
            onTap: () => QR.to(Routing.to.wizard.path),
          ),
        ],
        footer: Padding(
          padding: const EdgeInsets.all(kPadding),
          child: Row(
            children: [
              Icon(Icons.settings, color: Colors.white70, size: 18),
              SizedBox(width: 8),
              Text(
                'powered by',
                style: TextStyle(color: Colors.white70, fontSize: 12),
              ),
              SizedBox(width: 4),
              Text(
                'quirky',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
