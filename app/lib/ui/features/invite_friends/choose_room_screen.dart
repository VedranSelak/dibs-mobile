import 'package:app/blocs/rooms_bloc/rooms_bloc.dart';
import 'package:app/res/text_styles.dart';
import 'package:app/ui/features/rooms/widgets/your_room_list_item.dart';
import 'package:app/ui/widgets/screen_wrappers/simple_screen_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class ChooseRoomScreen extends StatefulWidget {
  const ChooseRoomScreen({Key? key}) : super(key: key);
  static const routeName = '/choose-room';

  @override
  State<ChooseRoomScreen> createState() => _ChooseRoomScreenState();
}

class _ChooseRoomScreenState extends State<ChooseRoomScreen> {
  @override
  void initState() {
    context.read<RoomsBloc>().add(FetchYourRooms());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textStyles = TextStyles.of(context);
    return SimpleScreenWrapper(
      onBackPressed: () {
        Get.back<dynamic>();
      },
      title: 'Choose room',
      shouldGoUnderAppBar: false,
      child: BlocBuilder<RoomsBloc, RoomsState>(builder: (context, state) {
        if (state is FetchingYourRooms) {
          return const Center(
              child: SpinKitWave(
            color: Colors.blueAccent,
          ));
        } else if (state is YourRoomsFetched) {
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
                    isChoose: true,
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
        return Container();
      }),
    );
  }
}
