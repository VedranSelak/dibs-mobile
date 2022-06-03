import 'package:app/blocs/listing_bloc/listing_bloc.dart';
import 'package:app/blocs/user_type_bloc/user_type_bloc.dart';
import 'package:app/res/dimensions.dart';
import 'package:app/res/text_styles.dart';
import 'package:app/ui/features/home/widgets/create_public_listing_card.dart';
import 'package:app/ui/features/home/widgets/listing_item.dart';
import 'package:app/ui/widgets/screen_wrappers/main_screen_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ListingBloc>().add(FetchListings());
    context.read<UserTypeBloc>().add(GetUserType());
  }

  @override
  Widget build(BuildContext context) {
    final dimensions = Dimensions.of(context);
    final textStyles = TextStyles.of(context);

    return MainScreenWrapper(
      child: BlocBuilder<UserTypeBloc, UserTypeState>(
        builder: (context, state) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 20.0),
            width: dimensions.fullWidth,
            height: dimensions.mainContentHeight,
            child: Column(
              children: [
                const SizedBox(
                  height: 20.0,
                ),
                Text(
                  'Listings',
                  style: textStyles.headerText,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                BlocBuilder<ListingBloc, ListingState>(
                  builder: (context, listingState) {
                    if (listingState is ListingsFetchSuccess) {
                      final listings = listingState.listings;
                      return Expanded(
                        child: RefreshIndicator(
                          onRefresh: () async {
                            context.read<ListingBloc>().add(FetchListings());
                          },
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                            itemCount: listings.length,
                            itemBuilder: (context, index) {
                              if (state is OwnerType && index == 0) {
                                return Column(
                                  children: [
                                    const CreatePublicListingCard(),
                                    const SizedBox(
                                      height: 20.0,
                                    ),
                                    ListingItem(listing: listings[index]),
                                  ],
                                );
                              }
                              return ListingItem(listing: listings[index]);
                            },
                          ),
                        ),
                      );
                    } else {
                      return const Expanded(
                        child: Center(
                          child: SpinKitWave(
                            color: Colors.blueAccent,
                          ),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
