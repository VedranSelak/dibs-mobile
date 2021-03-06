import 'package:app/res/dimensions.dart';
import 'package:app/res/text_styles.dart';
import 'package:app/ui/widgets/avatar_widget.dart';
import 'package:flutter/material.dart';

class RoomReservationListItem extends StatelessWidget {
  const RoomReservationListItem({
    required this.fullName,
    required this.date,
    required this.time,
    required this.stay,
    required this.imageUrl,
    Key? key,
  }) : super(key: key);
  final String fullName;
  final String date;
  final String time;
  final int stay;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    final dimensions = Dimensions.of(context);
    final textStyles = TextStyles.of(context);
    return Container(
      padding: const EdgeInsets.all(8.0),
      width: dimensions.fullWidth,
      height: 80.0,
      child: Row(
        children: [
          AvatarWidget(imageUrl: imageUrl, size: 80.0),
          const SizedBox(width: 10.0),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(fullName, style: textStyles.labelText),
              Text(time, style: textStyles.secondaryLabelSmall),
              Text(date, style: textStyles.secondaryLabelSmall),
            ],
          ),
          Expanded(child: Container()),
          Text('Stay: ${stay}h', style: textStyles.accentText),
        ],
      ),
    );
  }
}
