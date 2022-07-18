import 'dart:io';

import 'package:app/blocs/create_room_bloc/create_room_bloc.dart';
import 'package:app/res/dimensions.dart';
import 'package:app/res/text_styles.dart';
import 'package:app/ui/features/create_listing/widgets/text_label.dart';
import 'package:app/ui/widgets/avatar_widget.dart';
import 'package:app/ui/widgets/buttons/primary_button.dart';
import 'package:app/ui/widgets/screen_wrappers/simple_screen_wrapper.dart';
import 'package:common/resources/data_state.dart';
import 'package:domain/private_room/entities/search_user.dart';
import 'package:domain/private_room/usecases/search_users_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

class RoomInviteScreen extends StatelessWidget {
  RoomInviteScreen({Key? key}) : super(key: key);
  static const String routeName = "/room-invite";
  final TextEditingController controller = TextEditingController();

  void onBack(BuildContext context) {
    Get.back<dynamic>();
  }

  @override
  Widget build(BuildContext context) {
    final dimensions = Dimensions.of(context);
    final mediaQuery = MediaQuery.of(context);
    final textStyles = TextStyles.of(context);

    return WillPopScope(
      onWillPop: () async {
        onBack(context);
        return false;
      },
      child: Stack(
        children: [
          SimpleScreenWrapper(
            title: "Submit room",
            shouldGoUnderAppBar: false,
            shouldResize: false,
            onBackPressed: () {
              onBack(context);
            },
            child: Container(
              width: dimensions.fullWidth,
              height: dimensions.fullHeight,
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  const SizedBox(height: 30.0),
                  const TextLabel(
                    title: "Invite people:",
                    tooltip: "Search and select people you would like to invite to your private room.",
                  ),
                  const SizedBox(height: 10.0),
                  TypeAheadField(
                    noItemsFoundBuilder: (context) {
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text('No users found', style: textStyles.secondaryLabel),
                      );
                    },
                    textFieldConfiguration: TextFieldConfiguration(
                      autofocus: true,
                      controller: controller,
                      decoration: const InputDecoration(
                        suffixIcon: Icon(CupertinoIcons.search),
                        hintText: 'Search users ...',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    suggestionsCallback: (pattern) async {
                      final usecase = GetIt.I.get<SearchUsersUseCase>();
                      final response = await usecase(params: pattern);
                      if (response is DataFailed) {
                        return <SearchUser>[];
                      } else {
                        return response.data!;
                      }
                    },
                    itemBuilder: (context, SearchUser suggestion) {
                      return ListTile(
                        leading: AvatarWidget(imageUrl: suggestion.imageUrl, size: 40.0),
                        title: Text('${suggestion.firstName} ${suggestion.lastName}'),
                      );
                    },
                    onSuggestionSelected: (SearchUser suggestion) {
                      controller.clear();
                      context.read<CreateRoomBloc>().add(AddUser(user: suggestion));
                    },
                  ),
                  const SizedBox(height: 20.0),
                  BlocBuilder<CreateRoomBloc, CreateRoomState>(
                    buildWhen: (prevState, newState) {
                      if (newState is CreatingRoom) {
                        return false;
                      }
                      return true;
                    },
                    builder: (context, state) {
                      if (state is RoomDataEntering && state.users != null && state.users!.isNotEmpty) {
                        final List<String> usersList = [];
                        final buffer = StringBuffer();
                        final tooltipBuffer = StringBuffer();
                        for (final user in state.users!) {
                          usersList.add('${user.firstName} ${user.lastName}');
                        }
                        buffer.writeAll(usersList, ', ');
                        tooltipBuffer.writeAll(usersList, '\n');
                        return Row(
                          children: [
                            Text(
                              'People invited:',
                              style: textStyles.accentText,
                            ),
                            const SizedBox(width: 5.0),
                            Expanded(
                              child: Tooltip(
                                margin: EdgeInsets.symmetric(horizontal: mediaQuery.size.width * 0.25),
                                padding: const EdgeInsets.all(10.0),
                                triggerMode: TooltipTriggerMode.tap,
                                waitDuration: Duration.zero,
                                showDuration: const Duration(seconds: 3),
                                message: tooltipBuffer.toString(),
                                child: Text(
                                  buffer.toString(),
                                  style: textStyles.secondaryLabel,
                                  softWrap: false,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                      return Center(
                        child: Text('No people invited yet.', style: textStyles.secondaryLabel),
                      );
                    },
                  ),
                  Expanded(child: Container()),
                  const TextLabel(
                    title: "Upload an image:",
                    tooltip: "This is the image that will be displayed to the room participants.",
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(20.0),
                    onTap: () {
                      context.read<CreateRoomBloc>().add(AddRoomImage());
                    },
                    child: Container(
                      width: mediaQuery.size.width,
                      height: mediaQuery.size.height * 0.3,
                      //padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blueAccent, width: 2.0),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: BlocBuilder<CreateRoomBloc, CreateRoomState>(
                        buildWhen: (prevState, newState) {
                          if (newState is CreatingRoom) {
                            return false;
                          }
                          return true;
                        },
                        builder: (context, state) {
                          if (state is RoomDataEntering && state.image != null) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(18.0),
                              child: Image.file(
                                File(state.image!.path),
                                fit: BoxFit.cover,
                              ),
                            );
                          }
                          return Container();
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  BlocBuilder<CreateRoomBloc, CreateRoomState>(
                    buildWhen: (prevState, newState) {
                      if (newState is CreatingRoom) {
                        return false;
                      }
                      return true;
                    },
                    builder: (context, state) {
                      if (state is RoomDataEntering && state.errorMessage != null) {
                        return SizedBox(
                          width: dimensions.fullWidth,
                          child: Text(state.errorMessage!, style: textStyles.errorText),
                        );
                      }
                      return Text('', style: textStyles.errorText);
                    },
                  ),
                  Expanded(child: Container()),
                  const SizedBox(height: 20.0),
                  PrimaryButton(
                    buttonText: "Submit",
                    onPress: () {
                      context.read<CreateRoomBloc>().add(SubmitRoom());
                    },
                    backgroundColor: Colors.blueAccent,
                  ),
                  const SizedBox(height: 20.0),
                ],
              ),
            ),
          ),
          BlocBuilder<CreateRoomBloc, CreateRoomState>(
            builder: (context, state) {
              if (state is CreatingRoom) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: dimensions.fullWidth * 0.15),
                  width: dimensions.fullWidth,
                  height: dimensions.fullHeight,
                  color: Colors.black.withOpacity(0.5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SpinKitWave(
                        color: Colors.lightBlue,
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        "Creating your room. This may take a while...",
                        style: textStyles.buttonText,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }
}
