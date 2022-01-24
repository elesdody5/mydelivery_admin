import 'package:core/domain/user.dart';
import 'package:flutter/material.dart';

import 'available_order_list_item.dart';

class AvailableOrdersList extends StatelessWidget {
  final List<User?> users;
  final Function(String) onTap;

  const AvailableOrdersList(
      {Key? key, required this.users, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) => AvailableOrderListItem(
              user: users[index],
              onTap: onTap,
            ));
  }
}
