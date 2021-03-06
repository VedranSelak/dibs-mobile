import 'dart:async';

import 'package:app/blocs/filters_bloc/filters_bloc.dart';
import 'package:app/blocs/listing_bloc/listing_bloc.dart';
import 'package:app/blocs/listing_created_cubit/listing_created_cubit.dart';
import 'package:app/blocs/search_listings_bloc/search_listings_bloc.dart';
import 'package:app/blocs/user_type_bloc/user_type_bloc.dart';
import 'package:app/res/dimensions.dart';
import 'package:app/ui/features/home/widgets/create_public_listing_card.dart';
import 'package:app/ui/features/home/widgets/custom_dropdown.dart';
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

    final filterState = context.read<FiltersBloc>().state as FiltersApplied;
    context.read<ListingBloc>().add(FetchListings(
          filters: filterState.filters,
          sort: filterState.sort,
        ));
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
                        } else if (isSearchActive) {
                          _searchController.clear();
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
    final dimensions = Dimensions.of(context);
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
                      child: SpinKitRing(
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
            SizedBox(
              width: dimensions.fullWidth,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blueAccent, width: 1.0),
                        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                      ),
                      height: 50.0,
                      child: CustDropDown(
                        isMultiSelect: true,
                        borderRadius: 8.0,
                        hintIcon: Icons.filter_list,
                        hintText: 'Filter',
                        items: const [
                          CustDropdownMenuItem<String>(
                            value: 'restaurant',
                            child: Text('Restaurnt'),
                          ),
                          CustDropdownMenuItem<String>(
                            value: 'sportcenter',
                            child: Text('Sport center'),
                          ),
                          CustDropdownMenuItem<String>(
                            value: 'club',
                            child: Text('Club'),
                          ),
                          CustDropdownMenuItem<String>(
                            value: 'bar',
                            child: Text('Bar'),
                          ),
                        ],
                        onChanged: (String value) {},
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.transparent,
                    width: 10.0,
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blueAccent, width: 1.0),
                        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                      ),
                      height: 50.0,
                      child: CustDropDown(
                        borderRadius: 8.0,
                        hintIcon: Icons.sort,
                        hintText: 'Sort',
                        items: const [
                          CustDropdownMenuItem<String>(
                            value: 'DESC',
                            child: Text('Newest'),
                          ),
                          CustDropdownMenuItem<String>(
                            value: 'ASC',
                            child: Text('Oldest'),
                          ),
                        ],
                        onChanged: (String value) {},
                      ),
                    ),
                  ),
                ],
              ),
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
                        final filterState = context.read<FiltersBloc>().state as FiltersApplied;
                        context.read<ListingBloc>().add(FetchListings(
                              filters: filterState.filters,
                              sort: filterState.sort,
                            ));
                      },
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                        itemCount: listings.length,
                        itemBuilder: (context, index) {
                          if (state is OwnerType && index == 0) {
                            return BlocBuilder<ListingCreatedCubit, bool>(
                              builder: (context, state) {
                                if (!state) {
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
                      child: SpinKitRing(
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
