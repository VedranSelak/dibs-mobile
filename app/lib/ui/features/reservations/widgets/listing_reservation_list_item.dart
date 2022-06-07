import 'package:app/res/dimensions.dart';
import 'package:app/res/text_styles.dart';
import 'package:flutter/material.dart';

class ListingReservationListItem extends StatelessWidget {
  const ListingReservationListItem({
    required this.arrivalTime,
    required this.fullName,
    required this.date,
    required this.numOfPeople,
    required this.stay,
    Key? key,
  }) : super(key: key);
  final String arrivalTime;
  final String fullName;
  final String date;
  final int numOfPeople;
  final int stay;

  @override
  Widget build(BuildContext context) {
    final dimensions = Dimensions.of(context);
    final textStyles = TextStyles.of(context);
    return Container(
      padding: const EdgeInsets.all(8.0),
      width: dimensions.fullWidth,
      height: 100.0,
      child: Row(
        children: [
          const Icon(Icons.person, size: 80.0),
          const SizedBox(width: 10.0),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(fullName, style: textStyles.labelText),
              const SizedBox(height: 8.0),
              Text('Arrival time: $arrivalTime', style: textStyles.secondaryLabelSmall),
              const SizedBox(height: 4.0),
              Text(date, style: textStyles.secondaryLabelSmall),
            ],
          ),
          Expanded(child: Container()),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(numOfPeople.toString(), style: textStyles.secondaryLabelSmall),
                  const SizedBox(width: 5.0),
                  const Icon(Icons.people),
                ],
              ),
              const SizedBox(height: 4.0),
              Row(
                children: [
                  Text('${stay}h', style: textStyles.secondaryLabelSmall),
                  const SizedBox(width: 5.0),
                  const Icon(Icons.access_time),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
