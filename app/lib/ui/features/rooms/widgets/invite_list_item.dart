import 'package:app/blocs/rooms_bloc/rooms_bloc.dart';
import 'package:app/blocs/your_room_bloc/your_room_bloc.dart';
import 'package:app/res/dimensions.dart';
import 'package:app/res/text_styles.dart';
import 'package:app/ui/widgets/avatar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InviteListItem extends StatelessWidget {
  const InviteListItem({
    required this.id,
    required this.roomId,
    required this.name,
    required this.firstName,
    required this.lastName,
    required this.imageUrl,
    this.isPending = false,
    Key? key,
  }) : super(key: key);
  final int id;
  final int roomId;
  final String name;
  final String firstName;
  final String lastName;
  final String? imageUrl;
  final bool isPending;

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
          AvatarWidget(imageUrl: imageUrl, size: 70.0),
          const SizedBox(width: 10.0),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('$firstName $lastName', style: textStyles.labelText),
                const SizedBox(height: 8.0),
                Text(
                  name,
                  style: textStyles.secondaryLabel,
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
          ),
          !isPending
              ? Row(
                  children: [
                    InkWell(
                      onTap: () {
                        context.read<RoomsBloc>().add(RespondToInvite(id: id, response: true));
                      },
                      child: const Icon(Icons.check_circle_outline, color: Colors.green),
                    ),
                    const SizedBox(width: 20.0),
                    InkWell(
                      onTap: () {
                        context.read<RoomsBloc>().add(RespondToInvite(id: id, response: false));
                      },
                      child: const Icon(Icons.delete_outline, color: Colors.red),
                    ),
                  ],
                )
              : InkWell(
                  onTap: () {
                    context.read<YourRoomBloc>().add(RemoveInvite(index: id));
                  },
                  child: const Icon(Icons.delete_outline, color: Colors.red),
                ),
        ],
      ),
    );
  }
}
