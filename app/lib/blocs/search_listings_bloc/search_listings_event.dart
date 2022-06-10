part of "search_listings_bloc.dart";

abstract class SearchListingsEvent extends Equatable {
  const SearchListingsEvent();

  @override
  List<Object> get props => [];
}

class StartSearchListings extends SearchListingsEvent {
  const StartSearchListings({required this.listings});
  final List<PublicListing> listings;

  @override
  List<Object> get props => [listings];
}

class SearchListings extends SearchListingsEvent {
  const SearchListings({required this.search});
  final String search;

  @override
  List<Object> get props => [search];
}
