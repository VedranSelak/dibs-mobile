import 'package:app/blocs/reservations_bloc/reservations_bloc.dart';
import 'package:app/res/dimensions.dart';
import 'package:app/res/text_styles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class RecentListItem extends StatelessWidget {
  const RecentListItem({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.date,
    required this.isPrivate,
    Key? key,
  }) : super(key: key);
  final int id;
  final String imageUrl;
  final String name;
  final String date;
  final bool isPrivate;

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
          Stack(
            children: [
              SizedBox(
                width: 70.0,
                height: 60.0,
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
              isPrivate
                  ? Positioned(
                      top: 2,
                      right: 2,
                      child: Container(
                        padding: const EdgeInsets.all(2.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blueAccent,
                        ),
                        child: const Icon(Icons.meeting_room_outlined, size: 15.0, color: Colors.white),
                      ),
                    )
                  : Container(),
            ],
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
                      onTap: () {
                        context.read<ReservationsBloc>().add(RemoveFromHistory(id: id));
                      },
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
