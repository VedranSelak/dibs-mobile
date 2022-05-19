part of "create_listing_bloc.dart";

@immutable
abstract class CreateListingState extends Equatable {
  const CreateListingState();

  @override
  List<Object?> get props => [];
}

class CreateListingInitial extends CreateListingState {}

class ListingDataEntering extends CreateListingState {
  const ListingDataEntering({
    required this.name,
    required this.shortDesc,
    required this.detailedDesc,
    required this.type,
    required this.images,
    required this.spots,
    this.errorMessage,
  });
  final String name;
  final String shortDesc;
  final String detailedDesc;
  final ListingType? type;
  final List<XFile>? images;
  final List<Spot>? spots;
  final String? errorMessage;

  @override
  List<Object?> get props => [name, shortDesc, detailedDesc, type, images, spots, errorMessage];
}

class CreateListingInProgress extends CreateListingState {
  const CreateListingInProgress({
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
