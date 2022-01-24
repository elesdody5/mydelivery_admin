import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:delivery/current_delivery_orders/all_current_delivery_orders.dart';
import 'package:delivery/current_delivery_orders/all_current_delivery_orders_provider.dart';
import 'package:delivery/deliverd_orders/all_delivered_orders_provider.dart';
import 'package:delivery/deliverd_orders/all_delivered_orders_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class DeliveryHomeScreen extends StatefulWidget {
  const DeliveryHomeScreen({Key? key}) : super(key: key);

  @override
  State<DeliveryHomeScreen> createState() => _DeliveryHomeScreenState();
}

class _DeliveryHomeScreenState extends State<DeliveryHomeScreen> {
  int _page = 0;
  bool isInit = true;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  final List<Widget> _screens = <Widget>[
    ChangeNotifierProvider.value(
      value: AllCurrentOrdersProvider(),
      child: const AllCurrentDeliveryOrders(),
    ),
    ChangeNotifierProvider.value(
      value: AllDeliveredOrdersProvider(),
      child: const AllDeliveredOrdersScreen(),
    ),
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (isInit) {
      _page = Get.arguments ?? 0;
      isInit = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          color: Get.theme.primaryColor,
          backgroundColor: Get.isDarkMode ? Colors.black : Colors.white,
          index: _page,
          height: 50,
          items: <Widget>[
            Image.asset(
              "assets/images/food-delivery.png",
              width: 30,
              height: 30,
            ),
            const Icon(
              Icons.check_circle,
              color: Colors.green,
            ),
          ],
          onTap: (currentIndex) {
            setState(() {
              _page = currentIndex;
            });
          },
        ),
        body: _screens[_page]);
  }
}
