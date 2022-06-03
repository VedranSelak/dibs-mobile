import 'package:app/blocs/rooms_bloc/rooms_bloc.dart';
import 'package:app/ui/features/rooms/widgets/invite_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class InvitesListScreen extends StatefulWidget {
  const InvitesListScreen({Key? key}) : super(key: key);

  @override
  State<InvitesListScreen> createState() => _InvitesListScreenState();
}

class _InvitesListScreenState extends State<InvitesListScreen> {
  @override
  void initState() {
    super.initState();
    context.read<RoomsBloc>().add(FetchInvites());
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: BlocBuilder<RoomsBloc, RoomsState>(builder: (context, state) {
        if (state is InvitesFetched) {
          return RefreshIndicator(
            onRefresh: () async {
              context.read<RoomsBloc>().add(FetchInvites());
              const Duration(seconds: 1);
            },
            child: ListView.builder(
              physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              itemCount: state.invites.length,
              itemBuilder: (context, index) {
                final invite = state.invites[index];

                return InviteListItem(
                  id: invite.id,
                  roomId: invite.roomId,
                  name: invite.name,
                  firstName: invite.firstName,
                  lastName: invite.lastName,
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
