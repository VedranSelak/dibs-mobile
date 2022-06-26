import 'package:app/blocs/create_listing_bloc/create_listing_bloc.dart';
import 'package:app/res/listing_type.dart';
import 'package:app/res/text_styles.dart';
import 'package:app/ui/widgets/dialogs/bottom_input_popup.dart';
import 'package:domain/public_listing/entities/spot.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SpotListItem extends StatelessWidget {
  const SpotListItem(
      {required this.spot, required this.type, required this.index, required this.showSeparator, Key? key})
      : super(key: key);
  final Spot spot;
  final ListingType type;
  final int index;
  final bool showSeparator;

  @override
  Widget build(BuildContext context) {
    final textStyles = TextStyles.of(context);
    return Column(
      children: [
        Row(
          children: [
            type == ListingType.restaurant
                ? const Icon(
                    Icons.table_restaurant,
                    size: 40.0,
                  )
                : type == ListingType.sportcenter
                    ? const Icon(Icons.directions_run, size: 40.0)
                    : type == ListingType.club
                        ? const Icon(Icons.table_bar, size: 40.0)
                        : type == ListingType.bar
                            ? const Icon(Icons.table_bar, size: 40.0)
                            : Container(),
            const SizedBox(width: 15.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(type.itemTitle, style: textStyles.labelText),
                const SizedBox(height: 8.0),
                Text(
                  type == ListingType.sportcenter
                      ? 'Allowed players: ${spot.availableSpots.toString()}'
                      : 'Available seats: ${spot.availableSpots.toString()}',
                  style: textStyles.secondaryLabel,
                ),
              ],
            ),
            Expanded(child: Container()),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    BottomInputPopupWidget(
                      context: context,
                      type: type,
                      index: index,
                      availableSpots: spot.availableSpots.toString(),
                    ).onTapped();
                  },
                  child: const Icon(
                    Icons.edit,
                    color: Colors.blueAccent,
                  ),
                ),
                const SizedBox(width: 8.0),
                GestureDetector(
                  onTap: () {
                    context.read<CreateListingBloc>().add(RemoveListingSpot(index: index));
                  },
                  child: const Icon(
                    Icons.remove_circle,
                    color: Colors.red,
                  ),
                ),
              ],
            )
          ],
        ),
        const SizedBox(height: 10.0),
        showSeparator
            ? Container(
                height: 1,
                color: Colors.grey,
              )
            : Container(),
        const SizedBox(height: 10.0),
      ],
    );
  }
}
