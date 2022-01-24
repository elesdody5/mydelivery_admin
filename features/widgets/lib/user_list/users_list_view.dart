import 'package:core/domain/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'user_list_item/user_list_item.dart';

class UsersListView extends StatelessWidget {
  final List<User> usersList;
  final Function(String) onUserClicked;
  final Function(User)? onLongTap;

  const UsersListView(
      {Key? key,
      required this.usersList,
      required this.onUserClicked,
      this.onLongTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: ListView.builder(
        itemCount: usersList.length,
        itemBuilder: (context, index) => AnimationConfiguration.staggeredList(
          position: index,
          duration: const Duration(milliseconds: 375),
          child: SlideAnimation(
            verticalOffset: 50.0,
            child: FadeInAnimation(
              child: UserListItem(
                user: usersList[index],
                onTap: onUserClicked,
                onLongTap: onLongTap,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
