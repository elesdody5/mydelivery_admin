import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class UserShimmerListItem extends StatelessWidget {
  const UserShimmerListItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Shimmer.fromColors(
          enabled: true,
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: ListTile(
            leading: CircleAvatar(),
            title: Container(
              width: 15.0,
              height: 8.0,
              color: Colors.white,
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(padding: EdgeInsets.symmetric(vertical: 8)),
                Container(
                  width: double.infinity,
                  height: 8.0,
                  color: Colors.white,
                ),
                const Padding(padding: EdgeInsets.symmetric(vertical: 8)),
                Container(
                  width: 100.0,
                  height: 8.0,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
