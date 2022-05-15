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
    required this.type,
  });
  final String name;
  final String shortDesc;
  final String detailedDesc;
  final String type;

  @override
  List<Object> get props => [name, shortDesc, detailedDesc, type];
}

class ListingImagesEntered extends CreateListingState {
  const ListingImagesEntered({
    required this.name,
    required this.shortDesc,
    required this.detailedDesc,
    required this.type,
    required this.images,
  });
  final String name;
  final String shortDesc;
  final String detailedDesc;
  final String type;
  final List<XFile> images;

  @override
  List<Object> get props => [name, shortDesc, detailedDesc, type, images];
}
