import 'package:core/domain/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:widgets/user_avatar.dart';

class AvailableOrderListItem extends StatelessWidget {
  final User? user;
  final Function(String) onTap;

  const AvailableOrderListItem(
      {Key? key, required this.user, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => onTap(user?.id ?? ""),
      leading: UserAvatar(id: user?.id ?? "", imageUrl: user?.imageUrl),
      title: Text(user?.name ?? ""),
      subtitle: Text(user?.address ?? ""),
      trailing: const Icon(CupertinoIcons.forward),
    );
  }
}
