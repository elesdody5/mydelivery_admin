import 'package:flutter/material.dart';
import 'package:widgets/error_widget.dart';
import 'package:widgets/user_list/user_list_item/user_shimmer_list_item.dart';

class UserListWithShimmer extends StatelessWidget {
  final Function future;
  final Widget child;

  const UserListWithShimmer(
      {Key? key, required this.future, required this.child})
      : super(key: key);

  @override
  Widget build(context) {
    return FutureBuilder(
        future: future(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) => const UserShimmerListItem());
          } else if (snapshot.error != null) {
            print(snapshot.error);
            return const ErrorImage();
          } else {
            return child;
          }
        });
  }
}
