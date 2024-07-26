part of '../components.dart';

class ToolbarIconButton extends StatelessWidget {
  const ToolbarIconButton({super.key, this.onTap, required this.icon});

  final GestureTapCallback? onTap;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: const BorderRadius.all(Radius.circular(kBorderRadius)),
      child:  Padding(
        padding: const EdgeInsets.all(5),
        child: icon,
      ),
    );
  }
}
