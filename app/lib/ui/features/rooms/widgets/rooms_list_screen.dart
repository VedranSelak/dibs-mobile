import 'package:app/blocs/rooms_bloc/rooms_bloc.dart';
import 'package:app/ui/features/rooms/widgets/rooms_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class RoomsListScreen extends StatefulWidget {
  const RoomsListScreen({Key? key}) : super(key: key);

  @override
  State<RoomsListScreen> createState() => _RoomsListScreenState();
}

class _RoomsListScreenState extends State<RoomsListScreen> {
  @override
  void initState() {
    super.initState();
    context.read<RoomsBloc>().add(FetchRooms());
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: BlocBuilder<RoomsBloc, RoomsState>(builder: (context, state) {
        if (state is RoomsFetched) {
          return RefreshIndicator(
            onRefresh: () async {
              context.read<RoomsBloc>().add(FetchRooms());
              const Duration(seconds: 1);
            },
            child: ListView.builder(
              physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              itemCount: state.rooms.length,
              itemBuilder: (context, index) {
                final room = state.rooms[index].room;

                return RoomsListItem(
                  id: room.id,
                  imageUrl: room.imageUrl,
                  name: room.name,
                  invites: room.invites,
                );
              },
            ),
          );
        }
        return const Center(
            child: SpinKitWave(
          color: Colors.blueAccent,
        ));
      }),
    );
  }
}
