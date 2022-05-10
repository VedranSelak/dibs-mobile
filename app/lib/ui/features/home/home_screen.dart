import 'package:app/blocs/listing_bloc/listing_bloc.dart';
import 'package:app/ui/features/home/widgets/listing_item.dart';
import 'package:app/ui/widgets/screen_wrappers/main_screen_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return MainScreenWrapper(
      child: SizedBox(
          width: mediaQuery.size.width,
          height: mediaQuery.size.height - 80.0,
          child: BlocBuilder<ListingBloc, ListingState>(builder: (context, state) {
            if (state is ListingsFetchSuccess) {
              final listings = state.listings;
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: listings.length,
                itemBuilder: (context, index) {
                  return ListingItem(listing: listings[index]);
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          })),
    );
  }
}
