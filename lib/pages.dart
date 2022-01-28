import 'package:authentication/signup/signup_screen.dart';
import 'package:core/screens.dart';
import 'package:core/utils/custom_transition.dart';
import 'package:dashboard/home_page/home_page.dart';
import 'package:delivery/delivery_list/delivery_list_provider.dart';
import 'package:delivery/delivery_list/delivery_list_screen.dart';
import 'package:delivery/home_screen/delivery_home_screen.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:authentication/signup/signup_provider.dart';
import 'package:vendor/home_screen/vendor_home_screen.dart';
import 'package:vendor/product_list/products_provider.dart';
import 'package:vendor/product_list/products_screen.dart';
import 'package:vendor/vendors_list_screen/vendors_list_provider.dart';
import 'package:vendor/vendors_list_screen/vendors_list_screen.dart';

List<GetPage> appPages = [
  GetPage(
      name: signupScreenRouteName,
      page: () => ChangeNotifierProvider.value(
            value: SignUpProvider(),
            child: SignupScreen(),
          )),
  GetPage(
    name: homeScreen,
    page: () => const HomePage(),
  ),
  GetPage(
    name: deliveryHomeScreen,
    page: () => const DeliveryHomeScreen(),
  ),
  GetPage(
    name: vendorHomeScreen,
    page: () => const VendorHomeScreen(),
  ),
  GetPage(
      name: deliveryListScreen,
      page: () => ChangeNotifierProvider.value(
            value: DeliveryListProvider(),
            child: const DeliveryListScreen(),
          )),
  GetPage(
      name: shopProductsScreenRouteName,
      page: () => ChangeNotifierProvider.value(
            value: ProductsProvider(),
            child: ProductsScreen(),
          )),
  GetPage(
      name: vendorsListScreen,
      page: () => ChangeNotifierProvider.value(
            value: VendorsListProvider(),
            child: const VendorsListScreen(),
          )),
];
