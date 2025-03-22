part of '../components.dart';

class HeaderText extends StatelessWidget {
  const HeaderText(
    this.data, {
    super.key,
  });
  final String data;
  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context)
          .textTheme
          .bodyLarge
          ?.copyWith(fontWeight: FontWeight.bold),
    );
  }
}
