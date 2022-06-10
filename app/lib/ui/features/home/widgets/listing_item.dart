import 'package:app/res/text_styles.dart';
import 'package:app/ui/features/listing_details/listing_details_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:domain/public_listing/entities/public_listing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class ListingItem extends StatelessWidget {
  const ListingItem({required this.listing, Key? key}) : super(key: key);
  final PublicListing listing;

  @override
  Widget build(BuildContext context) {
    final textStyles = TextStyles.of(context);
    return InkWell(
      onTap: () {
        Get.to<dynamic>(ListingDeatilsScreen(title: listing.name, id: listing.id));
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        height: 100.0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 100.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: listing.imageUrls[0],
                  placeholder: (context, _) {
                    return const SpinKitRing(
                      size: 20.0,
                      lineWidth: 2,
                      color: Colors.blueAccent,
                    );
                  },
                  maxWidthDiskCache: 200,
                  maxHeightDiskCache: 200,
                ),
              ),
            ),
            const SizedBox(
              width: 10.0,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    listing.name,
                    style: textStyles.labelText,
                    maxLines: 1,
                  ),
                  Text(listing.shortDescription, style: textStyles.secondaryLabel),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
