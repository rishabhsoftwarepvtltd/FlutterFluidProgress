import 'package:fluid_progress_indicator/src/extensions/build_context_extension.dart';
import 'package:flutter/material.dart';

/// Configuration class for customizing the background appearance of a progress indicator.
///
/// This class represents a configuration for the background of an indicator.
/// Configs are prioritized in a linear manner:
///
/// 1. **[image]** - Highest priority. If provided, [gradient] and [color] are ignored.
/// 2. **[gradient]** - Medium priority. If provided (and [image] is null), [color] is ignored.
/// 3. **[color]** - Lowest priority. Only used if both [image] and [gradient] are null.
///
/// The [border] property is independent and can be used with any of the above.
///
/// Example usage:
///
/// ```dart
/// // Simple color background
/// IndicatorBackgroundConfig(
///   color: Colors.grey[200],
/// )
///
/// // Gradient background
/// IndicatorBackgroundConfig(
///   gradient: LinearGradient(
///     colors: [Colors.blue, Colors.purple],
///   ),
/// )
///
/// // Image background
/// IndicatorBackgroundConfig(
///   image: DecorationImage(
///     image: AssetImage('assets/background.png'),
///     fit: BoxFit.cover,
///   ),
/// )
///
/// // Background with border
/// IndicatorBackgroundConfig(
///   color: Colors.white,
///   border: Border.all(color: Colors.blue, width: 2.0),
/// )
/// ```
///
class IndicatorBackgroundConfig {
  /// The background color of the indicator.
  ///
  /// This color is used as the background fill when [image] and [gradient]
  /// are not provided.
  ///
  /// Can be null if no color is specified.
  final Color? color;

  /// The border of the indicator.
  ///
  /// This allows you to add a border around the progress indicator.
  /// The border is independent of other background properties and can be
  /// used with [color], [gradient], or [image].
  ///
  /// Can be null if no border is specified.
  ///
  /// Example:
  ///
  /// ```dart
  /// border: Border.all(
  ///   color: Colors.blue,
  ///   width: 2.0,
  /// )
  /// ```
  final BoxBorder? border;

  /// The decoration image of the indicator.
  ///
  /// This image is displayed as the background. If provided, it takes
  /// precedence over [gradient] and [color].
  ///
  /// Can be null if no image is specified.
  ///
  /// Example:
  ///
  /// ```dart
  /// image: DecorationImage(
  ///   image: AssetImage('assets/background.png'),
  ///   fit: BoxFit.cover,
  /// )
  /// ```
  final DecorationImage? image;

  /// The gradient of the indicator.
  ///
  /// This gradient is used as the background fill when [image] is not provided.
  /// If both [gradient] and [color] are provided, [gradient] takes precedence.
  ///
  /// Can be null if no gradient is specified.
  ///
  /// Example:
  ///
  /// ```dart
  /// gradient: LinearGradient(
  ///   colors: [Colors.blue, Colors.purple],
  ///   begin: Alignment.topLeft,
  ///   end: Alignment.bottomRight,
  /// )
  /// ```
  final Gradient? gradient;

  /// Creates a new [IndicatorBackgroundConfig] instance.
  ///
  /// All parameters are optional. See the class documentation for priority
  /// rules when multiple background properties are provided.
  const IndicatorBackgroundConfig({
    this.color,
    this.border,
    this.image,
    this.gradient,
  });

  /// Creates a default [IndicatorBackgroundConfig] instance using theme values.
  ///
  /// This factory method returns an instance with default values derived from
  /// the provided [BuildContext]. It sets the background color to the theme's
  /// `onSurface` color from the color scheme.
  ///
  /// This method is helpful for creating a default configuration quickly without
  /// manually specifying theme-aware colors.
  ///
  /// Example:
  ///
  /// ```dart
  /// FluidProgressIndicator(
  ///   backgroundConfig: IndicatorBackgroundConfig.defaults(context),
  ///   // ... other properties
  /// )
  /// ```
  ///
  static IndicatorBackgroundConfig defaults(BuildContext context) {
    return IndicatorBackgroundConfig(
      // Setting the default background color of the indicator to the surface color
      // from the theme's color scheme. If not specified, it will be null.
      color: context.theme.colorScheme.onSurface,
    );
  }
}
