import 'package:app/res/dimensions.dart';
import 'package:app/res/text_styles.dart';
import 'package:app/ui/features/your_room/your_room_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class YourRoomListItem extends StatelessWidget {
  const YourRoomListItem({
    required this.id,
    required this.imageUrl,
    required this.description,
    required this.name,
    Key? key,
  }) : super(key: key);
  final int id;
  final String imageUrl;
  final String description;
  final String name;

  @override
  Widget build(BuildContext context) {
    final dimensions = Dimensions.of(context);
    final textStyles = TextStyles.of(context);
    return InkWell(
      onTap: () {
        Get.to<dynamic>(YourRoomScreen(id: id));
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        width: dimensions.fullWidth,
        height: 80.0,
        child: Row(
          children: [
            SizedBox(
              width: 80.0,
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
                  maxWidthDiskCache: 200,
                  maxHeightDiskCache: 200,
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: textStyles.labelText),
                  const SizedBox(height: 8.0),
                  Text(
                    description,
                    style: textStyles.secondaryLabelSmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            PopupMenuButton<dynamic>(
                itemBuilder: (BuildContext context) => [
                      PopupMenuItem<dynamic>(
                        child: Row(
                          children: [
                            const Icon(Icons.cancel, color: Colors.red),
                            const SizedBox(width: 10.0),
                            Text('Delete room', style: textStyles.regularText),
                          ],
                        ),
                      ),
                    ],
                icon: const Icon(Icons.more_vert)),
          ],
        ),
      ),
    );
  }
}
