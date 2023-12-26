import 'package:core/domain/user.dart';
import 'package:core/domain/user_type.dart';
import 'package:core/utils/utils.dart';
import 'package:dashboard/users_list_screen/user_list_proivder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'package:widgets/empty_widget.dart';
import 'package:widgets/user_list/user_list_item/future_with_shimmer.dart';
import 'package:widgets/user_list/users_list_view.dart';
import 'package:widgets/search_widget.dart';

class UsersListScreen extends StatelessWidget {
  const UsersListScreen({Key? key}) : super(key: key);

  void _showChangeUserTypeDialog(UsersListProvider provider, User user) {
    provider.selectedUserType = user.userType;
    Get.dialog(ChangeNotifierProvider.value(
      value: provider,
      child: userTypeRadioGroup(user),
    ));
  }

  Widget userTypeRadioGroup(User user) {
    return Consumer<UsersListProvider>(builder: (context, provider, key) {
      return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<UserType>(
                value: UserType.user,
                title: Text("user".tr),
                // selected: user.userType == UserType.user,
                groupValue: provider.selectedUserType,
                onChanged: (userType) =>
                    provider.onTypeSelected(user, userType)),
            RadioListTile<UserType>(
                value: UserType.delivery,
                title: Text("delivery".tr),
                // selected: user.userType == UserType.delivery,
                groupValue: provider.selectedUserType,
                onChanged: (userType) =>
                    provider.onTypeSelected(user, userType)),
            RadioListTile<UserType>(
                value: UserType.vendor,
                title: Text("vendor".tr),
                // selected: user.userType == UserType.vendor,
                groupValue: provider.selectedUserType,
                onChanged: (userType) =>
                    provider.onTypeSelected(user, userType)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
              provider.updateUserType(user);
            },
            child: Text("confirm".tr),
          ),
          TextButton(
            onPressed: () => Get.back(),
            child: Text("cancel".tr),
          )
        ],
      );
    });
  }

  void _showDialog(UsersListProvider provider, User user) {
    Get.dialog(AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton(
              onPressed: () {
                Get.back();
                _showChangeUserTypeDialog(provider, user);
              },
              child: Text("change".tr)),
          TextButton(
              onPressed: () {
                Get.back();
                _showBlockDialog(provider, user);
              },
              child: Text("block".tr)),
        ],
      ),
    ));
  }

  void _showBlockDialog(UsersListProvider provider, User user) {
    Get.dialog(AlertDialog(
      title: Text("are_you_sure".tr),
      content: user.isBlocked
          ? Text("do_you_to_unblock_user".tr)
          : Text("do_you_to_block_user".tr),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
            provider.blockUser(user);
          },
          child: Text("yes".tr),
        ),
        TextButton(
          onPressed: () => Get.back(),
          child: Text("cancel".tr),
        )
      ],
    ));
  }

  void _setupListener(UsersListProvider provider) {
    setupErrorMessageListener(provider.errorMessage);
    setupLoadingListener(provider.isLoading);
    setupNavigationListener(provider.navigation);
    setupSuccessMessageListener(provider.successMessage);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UsersListProvider>(context, listen: false);
    _setupListener(provider);
    return Scaffold(
      body: SafeArea(
        child: UserListWithShimmer(
          future: provider.getAllUsers,
          child: Consumer<UsersListProvider>(builder: (_, provider, __) {
            return provider.filteredUsers.isEmpty
                ? EmptyWidget(
                    icon: Image.asset('assets/images/profile.png'),
                    title: "empty_user_title".tr,
                  )
                : Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: SearchWidget(search: provider.search),
                      ),
                      Expanded(
                        child: UsersListView(
                          usersList: provider.filteredUsers,
                          onUserClicked: provider.onUserClicked,
                          onLongTap: (user) => _showDialog(provider, user),
                        ),
                      ),
                    ],
                  );
          }),
        ),
      ),
    );
  }
}
