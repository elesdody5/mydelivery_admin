import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:get/get.dart';

class OrdersListTile extends StatelessWidget {
  final String ordersNumber;
  final Function(DateTimeRange) onDateSelected;

  const OrdersListTile(
      {Key? key, required this.ordersNumber, required this.onDateSelected})
      : super(key: key);

  void _showDatePicker(context) async {
    DateTimeRange? dateTime = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
      builder: (BuildContext context,  child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Colors.deepPurple,
              onPrimary: Colors.white,
              surface: Colors.blueAccent,
              onSurface: Colors.black,
            ),
            dialogBackgroundColor:Colors.blue[900],
          ),
          child: child!,
        );
      },
    );
    if (dateTime != null) {
      onDateSelected(dateTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        "($ordersNumber) ${"orders".tr}",
      ),
      trailing: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            PopupMenuButton(
              onSelected: (value) {
                if (value == 1) _showDatePicker(context);
              },
              icon: const Icon(
                Icons.filter_list_rounded,
                color: Colors.grey,
              ),
              itemBuilder: (_) => [
                PopupMenuItem(
                  child: Text("select_date".tr),
                  value: 1,
                ),
              ],
            ),
          ]),
    );
  }
}
