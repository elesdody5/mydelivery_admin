import 'package:flutter/material.dart';

import 'package:widgets/empty_widget.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'package:widgets/user_list/user_list_item/future_with_shimmer.dart';
import 'package:widgets/user_list/users_list_view.dart';
import 'delivery_list_provider.dart';

class DeliveryListScreen extends StatelessWidget {
  const DeliveryListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DeliveryListProvider>(context, listen: false);
    return Scaffold(
      body: UserListWithShimmer(
        future:  provider.getAllDelivery,
        child: Consumer<DeliveryListProvider>(builder: (_, provider, __) {
          return provider.deliveryList.isEmpty
              ? EmptyWidget(
            icon: Image.asset('assets/images/delivery-man.png'),
            title: "empty_delivery_title".tr,
          )
              : UsersListView(
            usersList: provider.deliveryList,
            onUserClicked:(id){},
          );
        }),
      ),
    );
  }
}
