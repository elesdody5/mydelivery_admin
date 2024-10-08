import 'package:authentication/login/login_provider.dart';
import 'package:authentication/login/login_screen.dart';
import 'package:authentication/signup/signup_screen.dart';
import 'package:authentication/splash/splash_provider.dart';
import 'package:authentication/splash/splash_screen.dart';
import 'package:core/screens.dart';
import 'package:dashboard/categories/categories_provider.dart';
import 'package:dashboard/categories/categories_screen.dart';

import 'package:dashboard/home_page/home_page.dart';
import 'package:dashboard/notifications_list/notification_list_screen.dart';
import 'package:dashboard/notifications_list/notification_provider.dart';
import 'package:dashboard/offers/offers_provider.dart';
import 'package:dashboard/offers/offers_screen.dart';
import 'package:dashboard/offer_details/offer_details_provider.dart';
import 'package:dashboard/offer_details/offer_details_screen.dart';
import 'package:dashboard/settings/settings_alert_dialog.dart';
import 'package:dashboard/shop_details/shop_details_provider.dart';
import 'package:dashboard/shop_details/shop_details_screen.dart';
import 'package:dashboard/shops/shops_provider.dart';
import 'package:dashboard/shops/shops_screen.dart';
import 'package:dashboard/users_list_screen/user_list_proivder.dart';
import 'package:dashboard/users_list_screen/user_list_screen.dart';
import 'package:debts/debts/debts_provider.dart';
import 'package:debts/debts/debts_screen.dart';
import 'package:debts/debts_transactions/debts_transactions_provider.dart';
import 'package:debts/debts_transactions/debts_transactions_screen.dart';
import 'package:delivery/all_orders/AllOrdersProvider.dart';
import 'package:delivery/all_orders/all_orders_screen.dart';
import 'package:delivery/all_quick_orders/all_quick_orders_provider.dart';
import 'package:delivery/all_orders/avalible_orders/available_orders/available_orders_provider.dart';
import 'package:delivery/all_orders/avalible_orders/available_orders/available_orders_screen.dart';
import 'package:delivery/all_quick_orders/all_quick_orders_screen.dart';
import 'package:delivery/current_delivery_orders/all_current_delivery_orders.dart';
import 'package:delivery/current_delivery_orders/all_current_delivery_orders_provider.dart';
import 'package:delivery/deliverd_orders/all_delivered_orders_provider.dart';
import 'package:delivery/deliverd_orders/all_delivered_orders_screen.dart';
import 'package:delivery/delivery_details/delivery_details_provider.dart';
import 'package:delivery/delivery_details/delivery_details_screen.dart';
import 'package:delivery/avalible_orders/available_order_details_screen/avaliable_user_order_provider.dart';
import 'package:delivery/avalible_orders/available_order_details_screen/avaliable_user_orders_details_screen.dart';
import 'package:delivery/delivery_list/delivery_list_provider.dart';
import 'package:delivery/delivery_list/delivery_list_screen.dart';
import 'package:delivery/delivery_reviews/delivery_reviews_provider.dart';
import 'package:delivery/delivery_reviews/delivery_reviews_screen.dart';
import 'package:delivery/delivery_profile/profile_screen.dart';
import 'package:delivery/quick_orders_with_debts/quick_orders_with_debts_provider.dart';
import 'package:delivery/quick_orders_with_debts/quick_orders_with_debts_screen.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:authentication/signup/signup_provider.dart';
import 'package:quickorder/scheduled_quick_order/scheduled_quick_order_provider.dart';
import 'package:quickorder/scheduled_quick_order/scheduled_quick_order_screen.dart';
import 'package:quickorder/send_quick_order/QuickOrderFormProvider.dart';
import 'package:quickorder/send_quick_order/quick_order_form.dart';
import 'package:safe/safe_transactions/safe_transactions_provider.dart';
import 'package:safe/safe_transactions/safe_transactions_screen.dart';
import 'package:user_profile/current_user_orders/all_current_user_orders.dart';
import 'package:user_profile/current_user_orders/all_current_user_orders_provider.dart';
import 'package:user_profile/deliverd_orders/all_delivered_orders_provider.dart';
import 'package:user_profile/deliverd_orders/all_delivered_orders_screen.dart';
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
      name: loginScreenRouteName,
      page: () => ChangeNotifierProvider.value(
            value: LoginProvider(),
            child: LoginScreen(),
          )),
  GetPage(
      name: splashScreenRouteName,
      page: () => ChangeNotifierProvider.value(
            value: SplashProvider(),
            child: const SplashScreen(),
          )),
  GetPage(
      name: homeScreen,
      page: () => ChangeNotifierProvider.value(
            value: HomeProvider(),
            child: const HomePage(),
          )),
  GetPage(
    name: vendorHomeScreen,
    page: () => const VendorHomeScreen(),
  ),
  GetPage(
    name: deliveryProfileScreen,
    page: () => DeliveryProfileScreen(),
  ),
  GetPage(
      name: deliveryDetailsScreenRouteName,
      page: () => ChangeNotifierProvider.value(
            value: DeliveryDetailsProvider(),
            child: const DeliveryDetailsScreen(),
          )),
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
      name: allOrdersScreen,
      page: () => ChangeNotifierProvider.value(
            value: AllOrdersProvider(),
            child: const AllOrdersScreen(),
          )),
  GetPage(
      name: quickOrdersScreen,
      page: () => ChangeNotifierProvider.value(
            value: AllQuickOrdersProvider(),
            child: const AllQuickOrdersScreen(),
          )),
  GetPage(
      name: availableOrderDetailsScreen,
      page: () => ChangeNotifierProvider.value(
            value: AvailableUserOrdersDetailsProvider(),
            child: AvailableUserOrdersDetailsScreen(),
          )),
  GetPage(
      name: categoriesScreenRouteName,
      page: () => ChangeNotifierProvider.value(
            value: CategoriesProvider(),
            child: const CategoriesScreen(),
          )),
  GetPage(
      name: shopsScreenRouteName,
      page: () => ChangeNotifierProvider.value(
            value: ShopsProvider(),
            child: const ShopsScreen(),
          )),
  GetPage(
      name: shopDetailsScreenRouteName,
      page: () => ChangeNotifierProvider.value(
            value: ShopDetailsProvider(),
            child: const ShopDetailsScreen(),
          )),
  GetPage(
      name: notificationsScreenRouteName,
      page: () => ChangeNotifierProvider.value(
            value: NotificationListProvider(),
            child: const NotificationListScreen(),
          )),
  GetPage(
      name: deliveryReviewsScreenRouteName,
      page: () => ChangeNotifierProvider.value(
            value: DeliveryReviewsProvider(),
            child: const DeliveryReviewsScreen(),
          )),
  GetPage(
      name: currentDeliveryOrdersScreen,
      page: () => ChangeNotifierProvider.value(
            value: AllCurrentOrdersProvider(),
            child: const AllCurrentDeliveryOrders(),
          )),
  GetPage(
      name: currentUserOrdersScreen,
      page: () => ChangeNotifierProvider.value(
            value: AllCurrentUserOrdersProvider(),
            child: const AllCurrentUserOrders(),
          )),
  GetPage(
      name: currentUserOrdersScreen,
      page: () => ChangeNotifierProvider.value(
            value: UserDeliveredOrdersProvider(),
            child: const UserDeliveredOrdersScreen(),
          )),
  GetPage(
    name: deliveryDeliveredOrdersScreen,
    page: () => ChangeNotifierProvider.value(
      value: DeliveryDeliveredOrdersProvider(),
      child: const DeliveryDeliveredOrdersScreen(),
    ),
  ),
  GetPage(
    name: quickOrderForm,
    page: () => ChangeNotifierProvider.value(
      value: QuickOrderFormProvider(),
      child: QuickOrderForm(),
    ),
  ),
  GetPage(
    name: scheduledQuickOrders,
    page: () => ChangeNotifierProvider.value(
      value: ScheduledQuickOrdersProvider(),
      child: const ScheduledQuickOrderScreen(),
    ),
  ),
  GetPage(
    name: debtsScreen,
    page: () => ChangeNotifierProvider.value(
      value: DebtsProvider(),
      child: const DebtsScreen(),
    ),
  ),
  GetPage(
    name: debtTransactionsScreen,
    page: () => ChangeNotifierProvider.value(
      value: DebtsTransactionsProvider(),
      child: const DebtsTransactionsScreen(),
    ),
  ),
  GetPage(
    name: deliveryQuickOrdersWithDebts,
    page: () => ChangeNotifierProvider.value(
      value: QuickOrdersWithDebtsProvider(),
      child: const QuickOrdersWithDebtsScreen(),
    ),
  ),
  GetPage(
    name: safeTransactionsRouteName,
    page: () => ChangeNotifierProvider.value(
      value: SafeTransactionsProvider(),
      child: const SafeTransactionsScreen(),
    ),
  ),
  // GetPage(name: settingsDialog, page: SettingsAlertDialog(orderSettings: orderSettings, updateOrderSettings: updateOrderSettings))
];
