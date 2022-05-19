part of "listing_details_bloc.dart";

abstract class ListingDetailsEvent extends Equatable {
  const ListingDetailsEvent();

  @override
  List<Object> get props => [];
}

class FetchListingDetails extends ListingDetailsEvent {
  const FetchListingDetails({required this.id});
  final int id;

  @override
  List<Object> get props => [id];
}
