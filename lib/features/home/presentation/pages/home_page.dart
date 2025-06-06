import 'package:floy/floy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:zoncan/core/common/common.dart' show UnsupportedSizeScreen;
import 'package:zoncan/features/home/presentation/views/home_view.dart';

class HomePage extends HookWidget {
  final Widget child;

  const HomePage({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: FloyResponsive(
        largePage: HomeView(child: child),
        xLargePage: HomeView(child: child),
        xxLargePage: HomeView(child: child),
        unsupportedSizePage: const UnsupportedSizeScreen(),
      ),
    );
  }
}

class AutoFadingWidgetImplicit extends StatefulWidget {
  final Widget child;
  const AutoFadingWidgetImplicit({super.key, required this.child});

  @override
  State<AutoFadingWidgetImplicit> createState() =>
      _AutoFadingWidgetImplicitState();
}

class _AutoFadingWidgetImplicitState extends State<AutoFadingWidgetImplicit> {
  double _currentOpacity = 0.0; // Start fully transparent

  @override
  void initState() {
    super.initState();
    // Trigger the fade-in animation shortly after the widget is built
    // This gives time for the framework to lay out the widget
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _currentOpacity = 1.0; // Animate to fully opaque
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _currentOpacity,
      duration: const Duration(
        seconds: 2,
      ), // Long duration for clear visibility
      curve: Curves.easeInOut,
      child: widget.child
    );
  }
}
