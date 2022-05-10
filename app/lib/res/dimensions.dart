import 'dart:io';

import 'package:flutter/widgets.dart';

class Dimensions {
  Dimensions._(this._context);

  factory Dimensions.of(BuildContext context) {
    return Dimensions._(context);
  }

  final BuildContext _context;

  Size get _mediaQuerySize => MediaQuery.of(_context).size;
  double get fullHeight => _mediaQuerySize.height;
  double get fullWidth => _mediaQuerySize.width;

  final bottomNavBarHeight = Platform.isIOS ? 90.0 : 70.0;

  double get mainContentHeight => _mediaQuerySize.height - bottomNavBarHeight;
}
