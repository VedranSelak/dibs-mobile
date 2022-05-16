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
    required this.type,
    this.images,
  });
  final String name;
  final String shortDesc;
  final String detailedDesc;
  final String type;
  final List<XFile>? images;

  @override
  List<Object?> get props => [name, shortDesc, detailedDesc, type, images];
}

class AddListingImages extends CreateListingEvent {}

class RemoveListingImage extends CreateListingEvent {
  const RemoveListingImage({required this.index});
  final int index;

  @override
  List<Object?> get props => [index];
}

class SubmitListing extends CreateListingEvent {}
