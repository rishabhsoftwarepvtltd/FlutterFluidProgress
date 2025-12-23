import 'package:flutter/material.dart';

// coverage:ignore-file
extension BuildContextExtension on BuildContext {
  /// Getter for [ThemeData] on context by which user can easily access current theme.
  ///
  /// Usage: context.theme.colorScheme.primary, context.theme.canvasColor etc.
  ThemeData get theme => Theme.of(this);
}
