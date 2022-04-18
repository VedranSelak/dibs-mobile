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

  TextStyle get buttonText => _theme.bodyText1!.copyWith(
        color: Colors.white,
        fontSize: 18.0,
        fontFamily: "WorkSans",
        fontWeight: FontWeight.w500,
        letterSpacing: 1,
      );
}
