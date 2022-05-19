part of "listing_details_bloc.dart";

@immutable
abstract class ListingDetailsState extends Equatable {
  const ListingDetailsState();

  @override
  List<Object?> get props => [];
}

class ListingDetailsInitial extends ListingDetailsState {}

class ListingDetailsLoading extends ListingDetailsState {}

class DetailsFetchFailed extends ListingDetailsState {
  const DetailsFetchFailed({this.statusCode = 500, this.message = "Something went wrong"});
  final int? statusCode;
  final String? message;

  @override
  List<Object?> get props => [statusCode, message];
}

class DetailsFetchSuccess extends ListingDetailsState {
  const DetailsFetchSuccess({required this.listings});
  final List<PublicListing> listings;

  @override
  List<Object?> get props => [listings];
}
