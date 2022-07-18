import 'package:flutter/material.dart';

enum ListingType { restaurant, sportcenter, club, bar }

extension ListingTypeExtension on ListingType {
  String get rawValue {
    switch (this) {
      case ListingType.restaurant:
        return 'restaurant';
      case ListingType.sportcenter:
        return 'sportcenter';
      case ListingType.club:
        return 'club';
      case ListingType.bar:
        return 'bar';
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
      case ListingType.club:
        return 'Tables:';
      case ListingType.bar:
        return 'Tables:';
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
      case ListingType.club:
        return 'Create a table';
      case ListingType.bar:
        return 'Create a table';
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
      case ListingType.club:
        return 'Capacity of table';
      case ListingType.bar:
        return 'Capacity of table';
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
      case ListingType.club:
        return 'Table';
      case ListingType.bar:
        return 'Table';
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
      case ListingType.club:
        return Icons.local_bar;
      case ListingType.bar:
        return Icons.wine_bar;
      default:
        return Icons.local_restaurant;
    }
  }

  String get textValue {
    switch (this) {
      case ListingType.restaurant:
        return 'restaurant';
      case ListingType.sportcenter:
        return 'sport center';
      case ListingType.club:
        return 'club';
      case ListingType.bar:
        return 'bar';
      default:
        return 'unknown';
    }
  }
}

class ListingHelper {
  static ListingType mapValueToType(String value) {
    switch (value) {
      case 'restaurant':
        return ListingType.restaurant;
      case 'sportcenter':
        return ListingType.sportcenter;
      case 'club':
        return ListingType.club;
      default:
        return ListingType.restaurant;
    }
  }
}
