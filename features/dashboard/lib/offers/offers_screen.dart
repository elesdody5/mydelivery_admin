import 'package:core/model/offer.dart';
import 'package:core/screens.dart';
import 'package:core/utils/utils.dart';
import 'package:dashboard/offers/widgets/offer_list_item.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'package:widgets/future_with_loading_progress.dart';
import 'offers_provider.dart';

class OffersScreen extends StatelessWidget {
  const OffersScreen({Key? key}) : super(key: key);

  void _showAlertDialog(OffersProvider provider, Offer offer) {
    Get.dialog(AlertDialog(
      title: Text("are_you_sure".tr),
      content: Text("do_you_to_remove_offer".tr),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
            provider.deleteOfferById(offer);
          },
          child: Text("yes".tr),
        ),
        TextButton(
          onPressed: () => Get.back(),
          child: Text("cancel".tr),
        )
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<OffersProvider>(context, listen: false);
    setupLoadingListener(provider.isLoading);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "offers".tr,
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => Get.toNamed(offerDetailsScreenRouteName)),
      body: FutureWithLoadingProgress(
        future: provider.getOffers,
        child: Consumer<OffersProvider>(builder: (context, provider, _) {
          return ListView.builder(
              padding: const EdgeInsets.all(8),
              shrinkWrap: true,
              itemCount: provider.offers.length,
              itemBuilder: (context, index) => OfferListItem(
                    offer: provider.offers[index],
                    deleteOfferById: (offer) =>
                        _showAlertDialog(provider, offer),
                  ));
        }),
      ),
    );
  }
}
