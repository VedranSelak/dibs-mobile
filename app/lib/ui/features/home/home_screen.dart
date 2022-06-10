import 'dart:async';

import 'package:app/blocs/listing_bloc/listing_bloc.dart';
import 'package:app/blocs/search_listings_bloc/search_listings_bloc.dart';
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
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;
  bool isSearchActive = false;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      _debounce?.cancel();
      _debounce = Timer(const Duration(milliseconds: 300), () {
        if (_searchController.text.isNotEmpty) {
          context.read<SearchListingsBloc>().add(SearchListings(search: _searchController.text));
        }
      });
    });

    context.read<ListingBloc>().add(FetchListings());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dimensions = Dimensions.of(context);

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
                  height: 10.0,
                ),
                Row(
                  children: [
                    isSearchActive ? const Icon(Icons.search, color: Colors.blueAccent) : Container(),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: isSearchActive
                          ? SizedBox(
                              height: 45.0,
                              child: TextField(
                                controller: _searchController,
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.all(10.0),
                                  hintText: 'Search...',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            )
                          : Container(),
                    ),
                    IconButton(
                      onPressed: () {
                        final listingState = context.read<ListingBloc>().state;
                        if (!isSearchActive && listingState is ListingsFetchSuccess) {
                          context.read<SearchListingsBloc>().add(StartSearchListings(
                                listings: listingState.listings,
                              ));
                        }
                        setState(() {
                          isSearchActive = !isSearchActive;
                        });
                      },
                      icon: Icon(
                        isSearchActive ? Icons.cancel : Icons.search,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),
                _buildContent(state),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildContent(UserTypeState state) {
    final textStyles = TextStyles.of(context);
    if (isSearchActive) {
      return Expanded(
        child: Column(
          children: [
            const SizedBox(
              height: 20.0,
            ),
            BlocBuilder<SearchListingsBloc, SearchListingsState>(
              builder: (context, listingState) {
                if (listingState is SearchListingsFetchSuccess) {
                  final listings = listingState.listings;
                  return Expanded(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                      itemCount: listings.length,
                      itemBuilder: (context, index) {
                        return ListingItem(listing: listings[index]);
                      },
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
    } else {
      return Expanded(
        child: Column(
          children: [
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
    }
  }
}
