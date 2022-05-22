import 'package:flutter/material.dart';

enum ListingType { restaurant, sportcenter, theatre, cinema }

extension ListingTypeExtension on ListingType {
  String get rawValue {
    switch (this) {
      case ListingType.restaurant:
        return 'restaurant';
      case ListingType.sportcenter:
        return 'sportcenter';
      case ListingType.theatre:
        return 'theatre';
      case ListingType.cinema:
        return 'cinema';
      default:
        return 'unknown';
    }
  }

  String get title {
    switch (this) {
      case ListingType.restaurant:
        return 'Tables:';
      case ListingType.sportcenter:
        return 'Playing grounds:';
      case ListingType.theatre:
        return 'Rows:';
      case ListingType.cinema:
        return 'Rows:';
      default:
        return 'Unknown';
    }
  }

  String get popupTitle {
    switch (this) {
      case ListingType.restaurant:
        return 'Create a table';
      case ListingType.sportcenter:
        return 'Create a playing ground';
      case ListingType.theatre:
        return 'Create a row';
      case ListingType.cinema:
        return 'Create a row';
      default:
        return 'Unknown';
    }
  }

  String get textLabelText {
    switch (this) {
      case ListingType.restaurant:
        return 'Number of seats';
      case ListingType.sportcenter:
        return 'Number of players';
      case ListingType.theatre:
        return 'Number of seats';
      case ListingType.cinema:
        return 'Number of seats';
      default:
        return 'Unknown';
    }
  }

  String get itemTitle {
    switch (this) {
      case ListingType.restaurant:
        return 'Table';
      case ListingType.sportcenter:
        return 'Playing ground';
      case ListingType.theatre:
        return 'Row';
      case ListingType.cinema:
        return 'Row';
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

  ListingType mapValueToType(String value) {
    switch (value) {
      case 'restaurant':
        return ListingType.restaurant;
      case 'sportcenter':
        return ListingType.sportcenter;
      case 'theatre':
        return ListingType.theatre;
      case 'cinema':
        return ListingType.cinema;
      default:
        return ListingType.restaurant;
    }
  }
}
