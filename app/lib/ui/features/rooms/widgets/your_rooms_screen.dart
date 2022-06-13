import 'package:app/blocs/rooms_bloc/rooms_bloc.dart';
import 'package:app/res/text_styles.dart';
import 'package:app/ui/features/rooms/widgets/your_room_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class YourRoomsScreen extends StatefulWidget {
  const YourRoomsScreen({Key? key}) : super(key: key);

  @override
  State<YourRoomsScreen> createState() => _YourRoomsScreenState();
}

class _YourRoomsScreenState extends State<YourRoomsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textStyles = TextStyles.of(context);
    return Expanded(
      flex: 1,
      child: BlocBuilder<RoomsBloc, RoomsState>(
        builder: (context, state) {
          if (state is YourRoomsFetched) {
            if (state.rooms.isNotEmpty) {
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<RoomsBloc>().add(FetchYourRooms());
                  const Duration(seconds: 1);
                },
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                  itemCount: state.rooms.length,
                  itemBuilder: (context, index) {
                    final room = state.rooms[index];

                    return YourRoomListItem(
                      id: room.id,
                      imageUrl: room.imageUrl,
                      description: room.description,
                      name: room.name,
                    );
                  },
                ),
              );
            } else {
              return Center(
                child: Text(
                  'You have no rooms',
                  style: textStyles.descriptiveText,
                  textAlign: TextAlign.center,
                ),
              );
            }
          }
          return const Center(
              child: SpinKitWave(
            color: Colors.blueAccent,
          ));
        },
      ),
    );
  }
}
