import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:floy/floy.dart';
import 'package:flutter/material.dart';
import 'package:zoncan/config/src/constants/app_constants.dart';
import 'package:zoncan/features/home/presentation/controllers/home_controller.dart';
import 'package:zoncan/features/home/presentation/widgets/side_panel_header.dart';

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
        header: SidePanelHeader(controller: controller),
        itemsBorderRadius: BorderRadius.all(Radius.circular(kBorderRadius)),
        items: [
          FloyMenuItem(
            activeIcon: EvaIcons.home,
            title: "Home",
            description: "thi is description",
            totalNotify: 10,
            iconSize: 36,
            icon: EvaIcons.homeOutline,
            onTap: () {},
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
