import 'package:app/blocs/rooms_bloc/rooms_bloc.dart';
import 'package:app/res/dimensions.dart';
import 'package:app/res/text_styles.dart';
import 'package:app/ui/features/room_details/room_details_screen.dart';
import 'package:app/ui/widgets/buttons/primary_button.dart';
import 'package:app/ui/widgets/dialogs/alert_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:domain/private_room/entities/participant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class RoomsListItem extends StatelessWidget {
  const RoomsListItem({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.invites,
    Key? key,
  }) : super(key: key);
  final int id;
  final String imageUrl;
  final String name;
  final List<Participant> invites;

  String _getParticipantsText() {
    final List<String> names = invites.map((invite) => '${invite.user.firstName} ${invite.user.lastName}').toList();
    final buffer = StringBuffer()
      ..write('People: ')
      ..writeAll(names, ', ');
    return buffer.toString();
  }

  @override
  Widget build(BuildContext context) {
    final dimensions = Dimensions.of(context);
    final textStyles = TextStyles.of(context);
    return InkWell(
      onTap: () {
        Get.to<dynamic>(RoomDeatilsScreen(id: id));
      },
      child: Container(
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
                    _getParticipantsText(),
                    style: textStyles.secondaryLabelSmall,
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {
                AlertDialogWidget(
                  context: context,
                  title: 'Leave room "$name""',
                  description:
                      "Are you sure you want to leave the room. If you leave the room you will not be able to come back without another invite.",
                  acceptButton: PrimaryButton(
                    buttonText: "Leave",
                    onPress: () {
                      context.read<RoomsBloc>().add(LeaveRoom(id: id));
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
              icon: const Icon(
                Icons.logout,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
