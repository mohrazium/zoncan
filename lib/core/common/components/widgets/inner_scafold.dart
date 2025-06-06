import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class InnerScafold extends HookWidget {
  final PreferredSizeWidget? appBar;
  final Widget
  sidePanel; // Required: The content for your always-visible side panel
  final Widget body; // Required: The content for your main screen body
  final Widget?
  floatingActionButton; // Optional: A single FAB or a Column of FABs
  final double sidePanelWidth; // Customizable width for the side panel
  final Color? backgroundColor;
  final bool? resizeToAvoidBottomInset;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final FloatingActionButtonAnimator? floatingActionButtonAnimator;

  const InnerScafold({
    super.key,
    this.appBar,
    required this.sidePanel,
    required this.body,
    this.floatingActionButton,
    this.sidePanelWidth = 250.0, // Default width for the side panel
    this.backgroundColor,
    this.resizeToAvoidBottomInset,
    this.floatingActionButtonLocation,
    this.floatingActionButtonAnimator,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      // The crucial part: The body is a Row containing the side panel and the main content
      body: Row(
        children: [
          // 1. The always-visible Side Panel
          SizedBox(
            width: sidePanelWidth,
            child: sidePanel, // Your custom side panel widget goes here
          ),
          // 2. The Main Body Content, which expands to fill the remaining space
          Expanded(
            child: body, // Your main screen content widget goes here
          ),
        ],
      ),
      // The Floating Action Button is managed by the outer Scaffold as usual
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation:
          floatingActionButtonLocation, // Customize position
      floatingActionButtonAnimator:
          floatingActionButtonAnimator, // Customize animation
    );
  }
}
