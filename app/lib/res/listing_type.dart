import 'package:flutter/material.dart';

enum ListingType { restaurant, sportcenter, theatre, cinema }

extension ListingTypeExtension on ListingType {
  String get rawValue {
    switch (this) {
      case ListingType.restaurant:
        return 'Restaurant';
      case ListingType.sportcenter:
        return 'Sport Center';
      case ListingType.theatre:
        return 'Theatre';
      case ListingType.cinema:
        return 'Cinema';
      default:
        return 'Unknown';
    }
  }

  IconData get icon {
    switch (this) {
      case ListingType.restaurant:
        return Icons.local_restaurant;
      case ListingType.sportcenter:
        return Icons.sports_baseball;
      case ListingType.theatre:
        return Icons.theater_comedy;
      case ListingType.cinema:
        return Icons.local_movies;
      default:
        return Icons.local_restaurant;
    }
  }
}
