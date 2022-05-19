extension StringExtension on String {
  String capitalizeMe() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
