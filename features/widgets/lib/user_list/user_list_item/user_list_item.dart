import 'package:core/domain/user.dart';
import 'package:flutter/material.dart';
import 'package:core/domain/user_type.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:widgets/user_avatar.dart';
import 'package:get/get_utils/get_utils.dart';
class UserListItem extends StatelessWidget {
  final User user;
  final Function(User) onTap;
  final Function(User)? onLongTap;

  const UserListItem(
      {Key? key, required this.user, required this.onTap, this.onLongTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: ListTile(
          onLongPress: onLongTap != null ? () => onLongTap!(user) : null,
          onTap: () => onTap(user),
          leading: UserAvatar(id: user.id ?? "", imageUrl: user.imageUrl),
          title: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              user.name ?? "",
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
            ),
          ),
          subtitle: Text(user.userType?.enmToString().tr ?? ""),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (user.coins != null)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.monetization_on,
                      color: Colors.amberAccent,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(user.coins.toString()),
                    ),
                  ],
                ),
              IconButton(
                  icon: const Icon(Icons.phone),
                  onPressed: () => launch("tel://${user.phone}")),
            ],
          ),
        ),
      ),
    );
  }
}
