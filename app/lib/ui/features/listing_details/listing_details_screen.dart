import 'package:app/blocs/listing_details_bloc/listing_details_bloc.dart';
import 'package:app/res/assets.dart';
import 'package:app/res/dimensions.dart';
import 'package:app/res/text_styles.dart';
import 'package:app/ui/widgets/screen_wrappers/simple_screen_wrapper.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  void initState() {
    super.initState();

    context.read<ListingDetailsBloc>().add(FetchListingDetails(id: widget.id));
  }

  @override
  Widget build(BuildContext context) {
    final dimensions = Dimensions.of(context);
    final textStyles = TextStyles.of(context);

    return SimpleScreenWrapper(
      title: 'Details',
      onBackPressed: () {
        Get.back<dynamic>();
      },
      shouldGoUnderAppBar: false,
      child: SizedBox(
        width: dimensions.fullWidth,
        height: dimensions.fullHeight,
        child: BlocBuilder<ListingDetailsBloc, ListingDetailsState>(
          builder: (context, state) {
            if (state is DetailsFetchSuccess) {
              final List<Widget> imageSliders = state.listing.imageUrls.map<Widget>((String item) {
                return Container(
                  margin: const EdgeInsets.all(5.0),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                    child: Stack(
                      children: [
                        const Center(
                          child: SpinKitWave(
                            color: Colors.blueAccent,
                          ),
                        ),
                        FadeInImage.assetNetwork(
                          fit: BoxFit.cover,
                          width: 1000.0,
                          image: item,
                          placeholder: Assets.transparentImage,
                        ),
                      ],
                    ),
                  ),
                );
              }).toList();
              return Column(
                children: [
                  SizedBox(
                    height: dimensions.fullHeight * 0.4,
                    child: CarouselSlider(
                      items: imageSliders,
                      carouselController: _controller,
                      options: CarouselOptions(
                          height: dimensions.fullHeight * 0.35,
                          autoPlay: false,
                          enlargeCenterPage: true,
                          aspectRatio: 2.0,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _current = index;
                            });
                          }),
                    ),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: state.listing.imageUrls.asMap().entries.map((entry) {
                        return GestureDetector(
                          onTap: () => _controller.animateToPage(entry.key),
                          child: Container(
                            width: 12.0,
                            height: 12.0,
                            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black.withOpacity(_current == entry.key ? 0.9 : 0.4)),
                          ),
                        );
                      }).toList()),
                  const SizedBox(height: 20.0),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    width: dimensions.fullWidth,
                    child: Text(state.listing.name, style: textStyles.labelHeaderText),
                  ),
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