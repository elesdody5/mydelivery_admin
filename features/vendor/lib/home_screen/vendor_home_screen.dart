import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:vendor/available_orders/shop_available_orders.dart';
import 'package:vendor/available_orders/shop_avaliable_orders_provider.dart';
import 'package:vendor/delivered_orders/shop_delivered_orders.dart';
import 'package:vendor/delivered_orders/shop_delivered_orders_provider.dart';
import 'package:vendor/vendor_quick_orders/vendor_quick_orders_provider.dart';
import 'package:vendor/vendor_quick_orders/vendor_quick_orders_screen.dart';

import 'package:vendor/vendor_shops/vendor_shops_provider.dart';
import 'package:vendor/vendor_shops/vendor_shops_screen.dart';

class VendorHomeScreen extends StatefulWidget {
  const VendorHomeScreen({Key? key}) : super(key: key);

  @override
  State<VendorHomeScreen> createState() => _VendorHomeScreen();
}

class _VendorHomeScreen extends State<VendorHomeScreen> {
  int _page = 0;
  bool isInit = true;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  final List<Widget> _screens = <Widget>[
    ChangeNotifierProvider.value(
      value: VendorShopsProvider(),
      child: const VendorShopsScreen(),
    ),
    ChangeNotifierProvider.value(
      value: ShopAvailableOrdersProvider(),
      child: const ShopAvailableOrders(),
    ),
    ChangeNotifierProvider.value(
      value: ShopDeliveredOrdersProvider(),
      child: const ShopDeliveredOrdersScreen(),
    ),
    ChangeNotifierProvider.value(
      value: VendorQuickOrdersProvider(),
      child: const VendorQuickOrdersScreen(),
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
          backgroundColor: Colors.white,
          index: _page,
          height: 50,
          items: <Widget>[
            Image.asset(
              "assets/images/shops.png",
              width: 30,
              height: 30,
            ),
            Image.asset(
              "assets/images/food-delivery.png",
              width: 30,
              height: 30,
            ),
            const Icon(
              Icons.check_circle,
              color: Colors.green,
            ),
            Image.asset(
              "assets/images/notification.png",
              width: 30,
              height: 30,
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
