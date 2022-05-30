import 'package:app/blocs/user_type_bloc/user_type_bloc.dart';
import 'package:app/res/dimensions.dart';
import 'package:app/res/text_styles.dart';
import 'package:app/ui/features/create_listing/create_listing_screen.dart';
import 'package:app/ui/features/create_room/create_room_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class MainScreenOverlay extends StatelessWidget {
  const MainScreenOverlay({required this.entry, Key? key}) : super(key: key);
  final OverlayEntry entry;

  @override
  Widget build(BuildContext context) {
    final dimensions = Dimensions.of(context);
    final textStyles = TextStyles.of(context);
    return GestureDetector(
      onTap: entry.remove,
      child: Scaffold(
        backgroundColor: Colors.black.withOpacity(0.8),
        body: Center(
          child: SizedBox(
            width: dimensions.fullWidth,
            height: dimensions.fullHeight * 0.2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text("Create", style: textStyles.buttonText),
                    Text("Room", style: textStyles.buttonText),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 2.0),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.meeting_room_outlined,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          entry.remove();
                          Get.toNamed<dynamic>(CreateRoomScreen.routeName);
                        },
                      ),
                    )
                  ],
                ),
                if (context.read<UserTypeBloc>().state is OwnerType)
                  Column(
                    children: [
                      Text("Create", style: textStyles.buttonText),
                      Text("Listing", style: textStyles.buttonText),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 2.0),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.add_location_outlined,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            entry.remove();
                            Get.toNamed<dynamic>(CreateListingScreen.routeName);
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                    ],
                  ),
                Column(
                  children: [
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text("Invite", style: textStyles.buttonText),
                    Text("Friend", style: textStyles.buttonText),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 2.0),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.person_add_alt_outlined,
                          color: Colors.white,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
