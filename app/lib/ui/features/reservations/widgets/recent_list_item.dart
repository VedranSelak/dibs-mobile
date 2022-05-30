import 'package:app/res/dimensions.dart';
import 'package:app/res/text_styles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class RecentListItem extends StatelessWidget {
  const RecentListItem({
    required this.imageUrl,
    required this.name,
    required this.date,
    Key? key,
  }) : super(key: key);
  final String imageUrl;
  final String name;
  final String date;

  @override
  Widget build(BuildContext context) {
    final dimensions = Dimensions.of(context);
    final textStyles = TextStyles.of(context);
    return Container(
      padding: const EdgeInsets.all(8.0),
      width: dimensions.fullWidth,
      height: 70.0,
      child: Row(
        children: [
          SizedBox(
            width: 70.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: imageUrl,
                placeholder: (context, _) {
                  return const SpinKitWave(
                    size: 20.0,
                    color: Colors.blueAccent,
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: 10.0),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: textStyles.labelText),
              const SizedBox(height: 8.0),
              Text(date, style: textStyles.secondaryLabelSmall),
            ],
          ),
          Expanded(child: Container()),
          PopupMenuButton<dynamic>(
              itemBuilder: (BuildContext context) => [
                    PopupMenuItem<dynamic>(
                      child: Row(
                        children: [
                          const Icon(Icons.cancel, color: Colors.red),
                          const SizedBox(width: 10.0),
                          Text('Remove from history', style: textStyles.regularText),
                        ],
                      ),
                    ),
                  ],
              icon: const Icon(Icons.more_vert)),
        ],
      ),
    );
  }
}