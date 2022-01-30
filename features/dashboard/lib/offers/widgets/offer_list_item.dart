import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/model/offer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OfferListItem extends StatelessWidget {
  final Offer offer;

  final void Function(Offer offer) deleteOfferById;

  const OfferListItem(
      {Key? key, required this.offer, required this.deleteOfferById})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onLongPress: () => deleteOfferById(offer),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: offer.photo ?? "",
                    placeholder: (context, _) =>
                        const Center(child: CupertinoActivityIndicator()),
                    fit: BoxFit.contain,
                    height: 250,
                    width: double.infinity,
                  )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                    child: Text(
                  offer.description ?? "",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
