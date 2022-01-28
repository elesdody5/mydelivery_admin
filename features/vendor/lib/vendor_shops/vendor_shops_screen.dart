import 'package:core/model/shop.dart';
import 'package:core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:vendor/vendor_shops/vendor_shops_provider.dart';
import 'package:vendor/widgets/shops_grid_view.dart';
import 'package:widgets/empty_widget.dart';
import 'package:widgets/future_with_loading_progress.dart';

class VendorShopsScreen extends StatelessWidget {
  const VendorShopsScreen({Key? key}) : super(key: key);


  void _setupListener(VendorShopsProvider provider) {
    setupErrorMessageListener(provider.errorMessage);
    setupLoadingListener(provider.isLoading);
    setupNavigationListener(provider.navigation);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<VendorShopsProvider>(context, listen: false);
    _setupListener(provider);
    return Scaffold(
      appBar: AppBar(
        title: Text("shops".tr),
      ),
      body: SafeArea(
          left: false,
          right: false,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              FutureWithLoadingProgress(
                future: provider.getVendorShops,
                child: Consumer<VendorShopsProvider>(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: EmptyWidget(
                        icon: Image.asset("assets/images/shops.png"),
                        title: "empty_shops_title".tr,
                      ),
                    ),
                    builder: (_, provider, child) => provider.shops.isEmpty
                        ? child ?? Container()
                        : Expanded(
                            child: ShopsGridView(
                            shops: provider.shops,
                            onLongTap: (Shop shop) => {},
                          ))),
              )
            ],
          )),
    );
  }
}
