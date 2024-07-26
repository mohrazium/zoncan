part of '../components.dart';

class UserProfileTile extends StatelessWidget {
  const UserProfileTile({
    required this.name,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  final String name;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kPadding),
      child: ListTile(
        leading: _buildAvatar(context),
        title: _buildName(context),
        trailing: IconButton(
          onPressed: onPressed,
          icon:  Icon(Icons.more_horiz,size:16 * Fonts.instance.fontScale),
          splashRadius: kBorderRadius,
        ),
      ),
    );
  }

  Widget _buildAvatar(BuildContext context) {
    return CircleAvatar(
      radius: 20,
      backgroundColor: Theme.of(context).colorScheme.background.withOpacity(.2),
      child: Text(
        name.toUpperCase(),
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildName(BuildContext context) {
    return Text(
      name,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.surface,
        fontSize: 13 * Fonts.instance.fontScale,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
