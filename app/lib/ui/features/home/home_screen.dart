import 'package:app/blocs/listing_bloc/listing_bloc.dart';
import 'package:app/res/dimensions.dart';
import 'package:app/res/text_styles.dart';
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
    final dimensions = Dimensions.of(context);
    final textStyles = TextStyles.of(context);

    return MainScreenWrapper(
      child: Container(
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
              BlocBuilder<ListingBloc, ListingState>(builder: (context, state) {
                if (state is ListingsFetchSuccess) {
                  final listings = state.listings;
                  return Expanded(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: listings.length,
                      itemBuilder: (context, index) {
                        return ListingItem(listing: listings[index]);
                      },
                    ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
            ],
          )),
    );
  }
}
