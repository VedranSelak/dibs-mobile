import 'package:app/blocs/your_room_bloc/your_room_bloc.dart';
import 'package:app/res/dimensions.dart';
import 'package:app/res/text_styles.dart';
import 'package:app/ui/features/rooms/widgets/invite_list_item.dart';
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

class InviteFriendsScreen extends StatefulWidget {
  const InviteFriendsScreen({required this.id, Key? key}) : super(key: key);
  final int id;

  @override
  State<InviteFriendsScreen> createState() => _InviteFriendsScreenState();
}

class _InviteFriendsScreenState extends State<InviteFriendsScreen> {
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    context.read<YourRoomBloc>().add(FetchYourRoomDetails(id: widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textStyles = TextStyles.of(context);
    final dimensions = Dimensions.of(context);
    return SimpleScreenWrapper(
      shouldResize: false,
      onBackPressed: () {
        Get.back<dynamic>();
      },
      title: 'Invite',
      shouldGoUnderAppBar: false,
      child: SizedBox(
        width: dimensions.fullWidth,
        height: dimensions.fullHeight,
        child: BlocBuilder<YourRoomBloc, YourRoomState>(
          builder: (context, state) {
            if (state is YourRoomFetchSuccess) {
              return Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    width: dimensions.fullWidth,
                    child: Text(state.room.name, style: textStyles.labelHeaderText),
                  ),
                  const SizedBox(height: 20.0),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    width: dimensions.fullWidth,
                    child: Text('Description:', style: textStyles.labelText),
                  ),
                  const SizedBox(height: 10.0),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    width: dimensions.fullWidth,
                    child: Text(
                      state.room.description,
                      style: textStyles.secondaryLabel,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Container(
                    width: dimensions.fullWidth,
                    height: 1.0,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 20.0),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    width: dimensions.fullWidth,
                    child: TypeAheadField(
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
                        context.read<YourRoomBloc>().add(AddInvite(user: suggestion));
                      },
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Expanded(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: state.users != null ? state.users!.length : 0,
                      itemBuilder: (context, index) {
                        final user = state.users![index];
                        return InviteListItem(
                            id: index,
                            roomId: widget.id,
                            name: state.room.name,
                            firstName: user.firstName,
                            lastName: user.lastName,
                            imageUrl: user.imageUrl,
                            isPending: true);
                      },
                    ),
                  ),
                  state.users != null && state.users!.isNotEmpty
                      ? PrimaryButton(
                          buttonText: 'Invite',
                          onPress: () {
                            context.read<YourRoomBloc>().add(SendInvites());
                          },
                          backgroundColor: Colors.blueAccent,
                        )
                      : Container(),
                  const SizedBox(height: 10.0),
                ],
              );
            }
            return const Center(
                child: SpinKitWave(
              color: Colors.blueAccent,
            ));
          },
        ),
      ),
    );
  }
}
