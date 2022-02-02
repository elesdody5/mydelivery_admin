import 'package:authentication/signup/signup_screen.dart';
import 'package:core/screens.dart';
import 'package:dashboard/home_page/home_page.dart';
import 'package:dashboard/offers/offers_provider.dart';
import 'package:dashboard/offers/offers_screen.dart';
import 'package:dashboard/offer_details/offer_details_provider.dart';
import 'package:dashboard/offer_details/offer_details_screen.dart';
import 'package:dashboard/users_list_screen/user_list_proivder.dart';
import 'package:dashboard/users_list_screen/user_list_screen.dart';
import 'package:delivery/avalible_orders/all_available_orders.dart';
import 'package:delivery/avalible_orders/all_available_orders_provider.dart';
import 'package:delivery/avalible_orders/available_order_details_screen/avaliable_user_order_provider.dart';
import 'package:delivery/avalible_orders/available_order_details_screen/avaliable_user_orders_details_screen.dart';
import 'package:delivery/avalible_orders/available_orders/available_orders_provider.dart';
import 'package:delivery/avalible_orders/available_orders/available_orders_screen.dart';
import 'package:delivery/delivery_list/delivery_list_provider.dart';
import 'package:delivery/delivery_list/delivery_list_screen.dart';
import 'package:delivery/home_screen/delivery_home_screen.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:authentication/signup/signup_provider.dart';
import 'package:user_profile/profile_provider.dart';
import 'package:user_profile/profile_screen.dart';
import 'package:vendor/home_screen/vendor_home_screen.dart';
import 'package:vendor/product_list/products_provider.dart';
import 'package:vendor/product_list/products_screen.dart';
import 'package:vendor/vendors_list_screen/vendors_list_provider.dart';
import 'package:vendor/vendors_list_screen/vendors_list_screen.dart';
import 'package:dashboard/home_page/home_provider.dart';

List<GetPage> appPages = [
  GetPage(
      name: signupScreenRouteName,
      page: () => ChangeNotifierProvider.value(
            value: SignUpProvider(),
            child: SignupScreen(),
          )),
  GetPage(
      name: homeScreen,
      page: () => ChangeNotifierProvider.value(
            value: HomeProvider(),
            child: const HomePage(),
          )),
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
  GetPage(
      name: profileScreenRouteName,
      page: () => ChangeNotifierProvider.value(
            value: ProfileProvider(),
            child: ProfileScreen(),
          )),
  GetPage(
      name: usersScreen,
      page: () => ChangeNotifierProvider.value(
            value: UsersListProvider(),
            child: const UsersListScreen(),
          )),
  GetPage(
      name: offersScreenRouteName,
      page: () => ChangeNotifierProvider.value(
            value: OffersProvider(),
            child: const OffersScreen(),
          )),
  GetPage(
      name: offerDetailsScreenRouteName,
      page: () => ChangeNotifierProvider.value(
            value: OfferDetailsProvider(),
            child: const OfferDetailsScreen(),
          )),
  GetPage(
      name: availableOrdersScreen,
      page: () => ChangeNotifierProvider.value(
            value: AllAvailableOrdersProvider(),
            child: const AllAvailableOrdersScreen(),
          )),
  GetPage(
      name: availableOrderDetailsScreen,
      page: () => ChangeNotifierProvider.value(
            value: AvailableUserOrdersDetailsProvider(),
            child: AvailableUserOrdersDetailsScreen(),
          )),
];
