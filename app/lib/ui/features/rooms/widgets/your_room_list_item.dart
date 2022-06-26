import 'package:app/blocs/rooms_bloc/rooms_bloc.dart';
import 'package:app/res/dimensions.dart';
import 'package:app/res/text_styles.dart';
import 'package:app/ui/features/invite_friends/invite_friends_screen.dart';
import 'package:app/ui/features/your_room/your_room_screen.dart';
import 'package:app/ui/widgets/buttons/primary_button.dart';
import 'package:app/ui/widgets/dialogs/alert_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class YourRoomListItem extends StatelessWidget {
  const YourRoomListItem({
    required this.id,
    required this.imageUrl,
    required this.description,
    required this.name,
    this.isChoose = false,
    Key? key,
  }) : super(key: key);
  final int id;
  final String imageUrl;
  final String description;
  final String name;
  final bool isChoose;

  @override
  Widget build(BuildContext context) {
    final dimensions = Dimensions.of(context);
    final textStyles = TextStyles.of(context);
    return InkWell(
      onTap: () {
        if (isChoose) {
          Get.to<dynamic>(InviteFriendsScreen(id: id));
        } else {
          Get.to<dynamic>(YourRoomScreen(id: id));
        }
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
            !isChoose
                ? IconButton(
                    icon: const Icon(
                      Icons.delete_outline,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      AlertDialogWidget(
                        context: context,
                        title: 'Delete room "$name"',
                        description:
                            "Are you sure you want to delete the room. If you delete the room you will not be able to recover it back. Everything related to the room will be deleted.",
                        acceptButton: PrimaryButton(
                          buttonText: "Delete",
                          onPress: () {
                            context.read<RoomsBloc>().add(DeleteRoom(id: id));
                            Get.back<dynamic>();
                          },
                          backgroundColor: Colors.red,
                        ),
                        rejectButton: PrimaryButton(
                          buttonText: "Cancel",
                          onPress: () {
                            Get.back<dynamic>();
                          },
                          backgroundColor: Colors.grey,
                        ),
                      ).showAlertDialog();
                    },
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
