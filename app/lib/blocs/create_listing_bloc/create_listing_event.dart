part of "create_listing_bloc.dart";

abstract class CreateListingEvent extends Equatable {
  const CreateListingEvent();

  @override
  List<Object?> get props => [];
}

class EnterListingData extends CreateListingEvent {
  const EnterListingData({
    required this.name,
    required this.shortDesc,
    required this.detailedDesc,
  });
  final String name;
  final String shortDesc;
  final String detailedDesc;

  @override
  List<Object?> get props => [name, shortDesc, detailedDesc];
}

class SelectListingType extends CreateListingEvent {
  const SelectListingType({
    required this.type,
  });
  final ListingType type;

  @override
  List<Object> get props => [type];
}

class AddListingSpot extends CreateListingEvent {
  const AddListingSpot({required this.spot});
  final Spot spot;

  @override
  List<Object?> get props => [spot];
}

class RemoveListingSpot extends CreateListingEvent {
  const RemoveListingSpot({required this.index, this.rowName});
  final int index;
  final String? rowName;

  @override
  List<Object?> get props => [index, rowName];
}

class EditListingSpot extends CreateListingEvent {
  const EditListingSpot({required this.index, required this.availableSpots, this.rowName, this.prevRowName});
  final int index;
  final int availableSpots;
  final String? rowName;
  final String? prevRowName;

  @override
  List<Object?> get props => [index, availableSpots, rowName, prevRowName];
}

class AddListingImages extends CreateListingEvent {}

class RemoveListingImage extends CreateListingEvent {
  const RemoveListingImage({required this.index});
  final int index;

  @override
  List<Object?> get props => [index];
}

class SubmitListing extends CreateListingEvent {}

class ResetCreateListingBloc extends CreateListingEvent {}
