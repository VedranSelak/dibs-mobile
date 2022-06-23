part of "listing_bloc.dart";

abstract class ListingEvent extends Equatable {
  const ListingEvent();

  @override
  List<Object> get props => [];
}

class FetchListings extends ListingEvent {
  const FetchListings({required this.filters, required this.sort});
  final List<String> filters;
  final String sort;

  @override
  List<Object> get props => [filters, sort];
}
