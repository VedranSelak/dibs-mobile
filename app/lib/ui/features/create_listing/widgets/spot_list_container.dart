import 'package:app/res/listing_type.dart';
import 'package:app/res/text_styles.dart';
import 'package:app/ui/features/create_listing/widgets/spot_list_item.dart';
import 'package:app/ui/widgets/dialogs/bottom_input_popup.dart';
import 'package:domain/public_listing/entities/spot.dart';
import 'package:flutter/material.dart';

class SpotListContainer extends StatelessWidget {
  const SpotListContainer({required this.type, required this.spots, Key? key}) : super(key: key);
  final ListingType type;
  final List<Spot> spots;

  @override
  Widget build(BuildContext context) {
    final textStyles = TextStyles.of(context);
    return Expanded(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(type.title, style: textStyles.subheaderText),
              GestureDetector(
                  onTap: () {
                    BottomInputPopupWidget(context: context, type: type).onTapped();
                  },
                  child: const Icon(
                    Icons.add_outlined,
                    color: Colors.green,
                  )),
            ],
          ),
          const SizedBox(height: 10.0),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.blueAccent,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: spots.length,
                itemBuilder: (context, index) {
                  return SpotListItem(
                    spot: spots[index],
                    type: type,
                    index: index,
                    showSeparator: index != spots.length - 1,
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
