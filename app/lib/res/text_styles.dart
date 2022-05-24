import 'package:flutter/material.dart';

class TextStyles {
  TextStyles._(this._context);

  factory TextStyles.of(BuildContext context) {
    return TextStyles._(context);
  }

  final BuildContext _context;

  TextTheme get _theme => Theme.of(_context).textTheme;

  TextStyle get headerText => _theme.bodyText1!.copyWith(
        color: Colors.blueAccent,
        fontSize: 30.0,
        fontFamily: "WorkSans",
        fontWeight: FontWeight.w600,
      );

  TextStyle get labelHeaderText => _theme.bodyText1!.copyWith(
        color: Colors.black,
        fontSize: 30.0,
        fontFamily: "WorkSans",
        fontWeight: FontWeight.w600,
      );

  TextStyle get subheaderText => _theme.bodyText1!.copyWith(
        color: Colors.blueAccent,
        fontSize: 20.0,
        fontFamily: "WorkSans",
        fontWeight: FontWeight.w600,
      );

  TextStyle get buttonText => _theme.bodyText1!.copyWith(
        color: Colors.white,
        fontSize: 18.0,
        fontFamily: "WorkSans",
        fontWeight: FontWeight.w500,
        letterSpacing: 1,
      );

  TextStyle get errorText => _theme.bodyText1!.copyWith(
        color: Colors.redAccent,
        fontSize: 14.0,
        fontFamily: "WorkSans",
        fontWeight: FontWeight.w500,
      );

  TextStyle get accentText => _theme.bodyText1!.copyWith(
        color: Colors.blueAccent,
        fontSize: 15.0,
        fontFamily: "WorkSans",
        fontWeight: FontWeight.w500,
      );

  TextStyle get whiteText => _theme.bodyText1!.copyWith(
        color: Colors.white,
        fontSize: 15.0,
        fontFamily: "WorkSans",
        fontWeight: FontWeight.w500,
      );

  TextStyle get labelText => _theme.bodyText1!.copyWith(
        color: Colors.black,
        fontSize: 17.0,
        fontFamily: "WorkSans",
        fontWeight: FontWeight.w600,
      );

  TextStyle get regularText => _theme.bodyText1!.copyWith(
        color: Colors.black,
        fontSize: 17.0,
        fontFamily: "WorkSans",
        fontWeight: FontWeight.w500,
      );

  TextStyle get secondaryLabel => _theme.bodyText1!.copyWith(
        color: Colors.grey,
        fontSize: 15.0,
        fontFamily: "WorkSans",
        fontWeight: FontWeight.w500,
      );

  TextStyle get secondaryLabelSmall => _theme.bodyText1!.copyWith(
        color: Colors.grey,
        fontSize: 13.0,
        fontFamily: "WorkSans",
        fontWeight: FontWeight.w500,
      );

  TextStyle get secondaryLabelAccent => _theme.bodyText1!.copyWith(
        color: Colors.grey,
        fontSize: 15.0,
        fontFamily: "WorkSans",
        fontWeight: FontWeight.w600,
      );

  TextStyle get descriptiveText => _theme.bodyText1!.copyWith(
        color: Colors.grey,
        fontSize: 17.0,
        fontFamily: "WorkSans",
        fontWeight: FontWeight.w500,
      );
}
