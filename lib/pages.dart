import 'package:core/screens.dart';
import 'package:core/utils/custom_transition.dart';
import 'package:dashboard/home_page/home_page.dart';
import 'package:delivery/delivery_list/delivery_list_provider.dart';
import 'package:delivery/delivery_list/delivery_list_screen.dart';
import 'package:delivery/home_screen/delivery_home_screen.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

List<GetPage> appPages = [
  GetPage(
    name: homeScreen,
    page: () => const HomePage(),
  ),GetPage(
    name: deliveryHomeScreen,
    page: () => const DeliveryHomeScreen(),
  ),
  GetPage(
      name: deliveryListScreen,
      page: () => ChangeNotifierProvider.value(
            value: DeliveryListProvider(),
            child: const DeliveryListScreen(),
          )),
];
