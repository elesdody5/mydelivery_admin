import 'package:core/screens.dart';
import 'package:core/utils/utils.dart';
import 'package:dashboard/cities/cities_dialog.dart';
import 'package:dashboard/home_page/home_provider.dart';
import 'package:dashboard/home_page/widgets/notification_dialog.dart';
import 'package:dashboard/home_page/widgets/password_dialog.dart';
import 'package:dashboard/settings/settings_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import '../cities/cities_dialog_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  void _setupListener(HomeProvider provider) {
    setupErrorMessageListener(provider.errorMessage);
    setupLoadingListener(provider.isLoading);
    setupSuccessMessageListener(provider.successMessage);
    setupNavigationListener(provider.navigation);
  }

  void _openPasswordDialog(HomeProvider provider) {
    Get.dialog(PasswordDialog(submitPassword: provider.onPasswordEntered));
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeProvider>(context, listen: false);
    _setupListener(provider);
    return Scaffold(
        floatingActionButton: SpeedDial(
          animatedIconTheme: const IconThemeData(size: 22.0),
          icon: Icons.add,
          direction: SpeedDialDirection.left,
          children: [
            SpeedDialChild(
                label: "cities_out_menouf".tr,
                onTap: () => Get.dialog(ChangeNotifierProvider.value(
                    value: CitiesDialogProvider(), child: CitiesDialog()))),
            SpeedDialChild(
                label: "send_notification".tr,
                onTap: () => Get.dialog(NotificationDialog(
                      notificationMessage: provider.notificationMessage,
                      sendNotification: provider.sendNotification,
                    )))
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        appBar: AppBar(
          elevation: 2.0,
          backgroundColor: Colors.white,
          title: const Text('Dashboard',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 30.0)),
          actions: <Widget>[
            Container(
              margin: const EdgeInsets.only(left: 8.0),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text('My Delivery',
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w700,
                          fontSize: 14.0)),
                ],
              ),
            )
          ],
        ),
        body: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 12.0,
          mainAxisSpacing: 12.0,
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          children: <Widget>[
            _buildTile(
              Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Material(
                                  color: Colors.blue,
                                  shape: CircleBorder(),
                                  child: Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Icon(Icons.timeline,
                                        color: Colors.white, size: 30.0),
                                  )),
                              const Padding(
                                  padding: EdgeInsets.only(bottom: 16.0)),
                              Text('users'.tr,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 24.0)),
                            ]),
                      ])),
              onTap: () => Get.toNamed(usersScreen),
            ),
            _buildTile(
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Material(
                          color: Colors.teal,
                          shape: CircleBorder(),
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Icon(
                              Icons.pedal_bike,
                              color: Colors.white,
                              size: 30,
                            ),
                          )),
                      const Padding(padding: EdgeInsets.only(bottom: 16.0)),
                      Text('delivery'.tr,
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 24.0)),
                    ]),
              ),
              onTap: () => Get.toNamed(deliveryListScreen),
            ),
            _buildTile(
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Material(
                          color: Colors.blueGrey,
                          shape: CircleBorder(),
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Icon(Icons.account_circle_rounded,
                                color: Colors.white, size: 30.0),
                          )),
                      const Padding(padding: EdgeInsets.only(bottom: 16.0)),
                      Text('vendor'.tr,
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 24.0)),
                    ]),
              ),
              onTap: () => Get.toNamed(vendorsListScreen),
            ),
            _buildTile(
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Material(
                          color: Colors.deepPurpleAccent,
                          shape: CircleBorder(),
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Icon(Icons.store,
                                color: Colors.white, size: 30.0),
                          )),
                      const Padding(padding: EdgeInsets.only(bottom: 16.0)),
                      Text('shops'.tr,
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 24.0)),
                    ]),
              ),
              onTap: () => Get.toNamed(categoriesScreenRouteName),
            ),
            _buildTile(
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Material(
                          color: Colors.deepOrange,
                          shape: CircleBorder(),
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Icon(Icons.delivery_dining_rounded,
                                color: Colors.white, size: 30.0),
                          )),
                      const Padding(padding: EdgeInsets.only(bottom: 16.0)),
                      Text('quick_order'.tr,
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 24.0)),
                    ]),
              ),
              onTap: () => Get.toNamed(quickOrdersScreen),
            ),
            _buildTile(
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Material(
                          color: Colors.greenAccent,
                          shape: CircleBorder(),
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Icon(Icons.alarm,
                                color: Colors.white, size: 30.0),
                          )),
                      const Padding(padding: EdgeInsets.only(bottom: 16.0)),
                      Text('scheduled_quick_order'.tr,
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 20.0)),
                    ]),
              ),
              onTap: () => Get.toNamed(scheduledQuickOrders),
            ),
            _buildTile(
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Material(
                          color: Colors.orangeAccent,
                          shape: CircleBorder(),
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Icon(Icons.shopping_cart,
                                color: Colors.white, size: 30.0),
                          )),
                      const Padding(padding: EdgeInsets.only(bottom: 16.0)),
                      Text('orders'.tr,
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 24.0)),
                    ]),
              ),
              onTap: () => Get.toNamed(allOrdersScreen),
            ),
            _buildTile(
              Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Material(
                                  color: Colors.blue,
                                  shape: CircleBorder(),
                                  child: Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Icon(Icons.send,
                                        color: Colors.white, size: 30.0),
                                  )),
                              const Padding(
                                  padding: EdgeInsets.only(bottom: 16.0)),
                              Text('send_quick_order'.tr,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20.0)),
                            ]),
                      ])),
              onTap: () => Get.toNamed(quickOrderForm),
            ),
            _buildTile(
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Material(
                          color: Colors.red,
                          shape: CircleBorder(),
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Icon(Icons.local_offer,
                                color: Colors.white, size: 30.0),
                          )),
                      const Padding(padding: EdgeInsets.only(bottom: 16.0)),
                      Text('offers'.tr,
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 24.0)),
                    ]),
              ),
              onTap: () => Get.toNamed(offersScreenRouteName),
            ),
            _buildTile(
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Material(
                            color: Colors.green,
                            shape: CircleBorder(),
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Icon(Icons.attach_money,
                                  color: Colors.white, size: 30.0),
                            )),
                        const Padding(padding: EdgeInsets.only(bottom: 16.0)),
                        Text('debts'.tr,
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 24.0)),
                      ]),
                ), onTap: () async {
              await provider.getSettings();
              _openPasswordDialog(provider);
            }),
            _buildTile(
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Material(
                            color: Colors.amber,
                            shape: CircleBorder(),
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Icon(Icons.settings,
                                  color: Colors.white, size: 30.0),
                            )),
                        const Padding(padding: EdgeInsets.only(bottom: 16.0)),
                        Text('settings'.tr,
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 24.0)),
                      ]),
                ), onTap: () async {
              await provider.getSettings();
              Get.dialog(SettingsAlertDialog(
                  orderSettings: provider.orderSettings,
                  updateOrderSettings: provider.updateSettings));
            }),
            _buildTile(
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Material(
                            color: Color(0xFFFFe477),
                            shape: CircleBorder(),
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Icon(Icons.notifications_active,
                                  color: Colors.white, size: 30.0),
                            )),
                        const Padding(padding: EdgeInsets.only(bottom: 16.0)),
                        Text('notifications'.tr,
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 24.0)),
                      ]),
                ),
                onTap: () => Get.toNamed(notificationsScreenRouteName)),
            _buildTile(
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Material(
                            color: Colors.blueGrey,
                            shape: CircleBorder(),
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Icon(Icons.logout,
                                  color: Colors.white, size: 30.0),
                            )),
                        const Padding(padding: EdgeInsets.only(bottom: 16.0)),
                        Text('logout'.tr,
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 24.0)),
                      ]),
                ),
                onTap: () => provider.logout()),
          ],
        ));
  }

  Widget _buildTile(Widget child, {required Function() onTap}) {
    return Material(
        elevation: 14.0,
        borderRadius: BorderRadius.circular(12.0),
        shadowColor: const Color(0x802196F3),
        child: InkWell(
            // Do onTap() if it isn't null, otherwise do print()
            onTap: () => onTap(),
            child: child));
  }
}
