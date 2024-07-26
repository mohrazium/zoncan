import 'package:flutter/material.dart';

class ContextPage extends StatefulWidget {
  final Widget child;

  const ContextPage({super.key, required this.child});

  @override
  State<ContextPage> createState() => _ContextPageState();
}

class _ContextPageState extends State<ContextPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      color: Colors.deepOrange,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: widget.child,
      ),
    ));
  }
}
