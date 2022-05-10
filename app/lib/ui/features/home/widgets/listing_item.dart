import 'package:app/res/text_styles.dart';
import 'package:domain/public_listing/entities/public_listing.dart';
import 'package:flutter/material.dart';

class ListingItem extends StatelessWidget {
  const ListingItem({required this.listing, Key? key}) : super(key: key);
  final PublicListing listing;

  @override
  Widget build(BuildContext context) {
    final textStyles = TextStyles.of(context);
    final mediaQuery = MediaQuery.of(context);
    return SizedBox(
      height: 80.0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: const Icon(Icons.image, size: 80),
          ),
          const SizedBox(
            width: 10.0,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(listing.name, style: textStyles.labelText),
              Text(listing.shortDescription, style: textStyles.secondaryLabel),
            ],
          )
        ],
      ),
    );
  }
}
