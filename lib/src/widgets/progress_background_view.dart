part of '../fluid_progress_indicator.dart';

/// A widget representing the background view for a progress indicator.
///
/// The [_ProgressBackgroundView] class is a stateless widget used to display the background
/// view for a progress indicator. It takes an [IndicatorBackgroundConfig] object as [bgConfig]
/// and a [borderRadius] value as parameters to customize the appearance of the background.
///
/// This widget renders the background layer that appears behind the animated progress fill.
/// It supports colors, gradients, images, and borders as configured in [bgConfig].
///
/// This is an internal widget used by [FluidProgressIndicator] and should not be instantiated
/// directly.
///
class _ProgressBackgroundView extends StatelessWidget {
  /// The configuration for the background view.
  ///
  /// Contains all the styling information for the background, including color,
  /// gradient, image, and border settings.
  ///
  /// See [IndicatorBackgroundConfig] for details on available configuration options.
  final IndicatorBackgroundConfig bgConfig;

  /// The border radius for the background view.
  ///
  /// Controls the roundness of the corners. Should match the border radius
  /// of the parent [FluidProgressIndicator] for consistent appearance.
  final double borderRadius;

  /// Creates a new [_ProgressBackgroundView] instance.
  ///
  /// The [bgConfig] parameter is required and represents the configuration for the
  /// background view of the progress indicator. It should be an instance of [IndicatorBackgroundConfig].
  ///
  /// The [borderRadius] parameter is required and represents the border radius of the background.
  ///
  /// Example usage:
  ///
  /// ```dart
  /// _ProgressBackgroundView(
  ///   bgConfig: IndicatorBackgroundConfig(
  ///     color: Colors.grey[200],
  ///     border: Border.all(color: Colors.blue),
  ///   ),
  ///   borderRadius: 20.0,
  /// )
  /// ```
  ///
  const _ProgressBackgroundView({
    required this.bgConfig,
    required this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: bgConfig.border,
        borderRadius: BorderRadius.circular(borderRadius),
        color: bgConfig.color,
        gradient: bgConfig.gradient,
        image: bgConfig.image,
      ),
    );
  }
}
