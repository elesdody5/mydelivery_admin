import 'package:core/utils/utils.dart';
import 'package:dashboard/users_list_screen/user_list_proivder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'package:widgets/empty_widget.dart';
import 'package:widgets/user_list/user_list_item/future_with_shimmer.dart';
import 'package:widgets/user_list/users_list_view.dart';
class UsersListScreen extends StatelessWidget {
  const UsersListScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UsersListProvider>(context, listen: false);
    setupNavigationListener(provider.navigation);
    return Scaffold(
      body: UserListWithShimmer(
        future: provider.getAllUsers,
        child: Consumer<UsersListProvider>(builder: (_, provider, __) {
          return provider.usersList.isEmpty
              ? EmptyWidget(
            icon: Image.asset('assets/images/profile.png'),
            title: "empty_user_title".tr,
          )
              : UsersListView(
            usersList: provider.usersList,
            onUserClicked: provider.onUserClicked,
            onLongTap: (user) => {},
          );
        }),
      ),
    );
  }
}
