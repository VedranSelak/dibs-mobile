part of "listing_bloc.dart";

@immutable
abstract class ListingState extends Equatable {
  const ListingState();

  @override
  List<Object?> get props => [];
}

class ListingsInitial extends ListingState {}

class ListingsLoading extends ListingState {}

class ListingsFetchFailed extends ListingState {
  const ListingsFetchFailed({this.statusCode = 500, this.message = "Something went wrong"});
  final int? statusCode;
  final String? message;

  @override
  List<Object?> get props => [statusCode, message];
}

class ListingsFetchSuccess extends ListingState {
  const ListingsFetchSuccess({required this.listings});
  final List<PublicListing> listings;

  @override
  List<Object?> get props => [listings];
}
