part of "create_listing_bloc.dart";

@immutable
abstract class CreateListingState extends Equatable {
  const CreateListingState();

  @override
  List<Object?> get props => [];
}

class CreateListingInitial extends CreateListingState {}

class ListingDataEntered extends CreateListingState {
  const ListingDataEntered({
    required this.name,
    required this.shortDesc,
    required this.detailedDesc,
  });
  final String name;
  final String shortDesc;
  final String detailedDesc;

  @override
  List<Object> get props => [name, shortDesc, detailedDesc];
}

class ListingSpotsEntered extends CreateListingState {
  const ListingSpotsEntered(
      {required this.name,
      required this.shortDesc,
      required this.detailedDesc,
      required this.type,
      required this.spots});
  final String name;
  final String shortDesc;
  final String detailedDesc;
  final ListingType type;
  final List<Spot> spots;

  @override
  List<Object> get props => [name, shortDesc, detailedDesc, type, spots];
}

class ListingImagesEntered extends CreateListingState {
  const ListingImagesEntered({
    required this.name,
    required this.shortDesc,
    required this.detailedDesc,
    required this.type,
    required this.images,
    required this.spots,
  });
  final String name;
  final String shortDesc;
  final String detailedDesc;
  final ListingType type;
  final List<XFile> images;
  final List<Spot> spots;

  @override
  List<Object> get props => [name, shortDesc, detailedDesc, type, images, spots];
}

class CreateListingSuccess extends CreateListingState {}

class CreateListingFailure extends CreateListingState {}

class CreateListingInProgress extends CreateListingState {}
