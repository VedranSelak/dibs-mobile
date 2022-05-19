import 'package:app/blocs/listing_details_bloc/listing_details_bloc.dart';
import 'package:app/res/dimensions.dart';
import 'package:app/ui/widgets/screen_wrappers/simple_screen_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class ListingDeatilsScreen extends StatefulWidget {
  const ListingDeatilsScreen({required this.title, required this.id, Key? key}) : super(key: key);
  static const String routeName = '/listing-details';
  final String title;
  final int id;

  @override
  State<ListingDeatilsScreen> createState() => _ListingDeatilsScreenState();
}

class _ListingDeatilsScreenState extends State<ListingDeatilsScreen> {
  @override
  void initState() {
    super.initState();

    context.read<ListingDetailsBloc>().add(FetchListingDetails(id: widget.id));
  }

  @override
  Widget build(BuildContext context) {
    final dimensions = Dimensions.of(context);

    return SimpleScreenWrapper(
      onBackPressed: () {
        Get.back<dynamic>();
      },
      shouldGoUnderAppBar: false,
      child: SizedBox(
          width: dimensions.fullWidth,
          height: dimensions.fullHeight,
          child: Column(
            children: const [
              Text("DETAILS"),
            ],
          )),
    );
  }
}
