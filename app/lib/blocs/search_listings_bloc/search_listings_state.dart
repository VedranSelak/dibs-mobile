part of "search_listings_bloc.dart";

@immutable
abstract class SearchListingsState extends Equatable {
  const SearchListingsState();

  @override
  List<Object?> get props => [];
}

class SearchListingsInitial extends SearchListingsState {}

class SearchListingsLoading extends SearchListingsState {}

class SearchListingsFetchFailed extends SearchListingsState {
  const SearchListingsFetchFailed({this.statusCode = 500, this.message = "Something went wrong"});
  final int? statusCode;
  final String? message;

  @override
  List<Object?> get props => [statusCode, message];
}

class SearchListingsFetchSuccess extends SearchListingsState {
  const SearchListingsFetchSuccess({required this.listings});
  final List<PublicListing> listings;

  @override
  List<Object?> get props => [listings];
}
