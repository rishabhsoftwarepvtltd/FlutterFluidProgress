import 'package:fluid_progress_indicator/src/models/indicator_background_config.dart';
import 'package:flutter/material.dart';

import 'painter/fluid_wave_painter.dart';

part 'widgets/progress_background_view.dart';

part 'widgets/animated_fluid_progress_view.dart';

/// The default border radius for the [FluidProgressIndicator].
///
/// The `_kDefaultBorderRadius` constant represents the default border radius
/// used for the `FluidProgressIndicator` when the `borderRadius` parameter is
/// not provided. It is set to 8.0, giving the progress indicator a slightly
/// rounded appearance.
///
const double _kDefaultBorderRadius = 8.0;

/// Height animation duration
const Duration _kFillingViewAnimationDuration = Duration(
  milliseconds: 2000,
);

/// A typedef representing a builder function for animating a child widget's height.
///
/// The [HeightAnimatedChildBuilder] is a typedef used to define a builder function
/// that animates a child widget's height based on the provided animation [value].
/// The builder function takes a [BuildContext] and a [double] value as parameters
/// and should return a widget that displays the animated child.
///
/// The [BuildContext] provides access to the current build context, which can be
/// used to obtain information about the widget tree, media, and localizations.
///
/// The [value] parameter represents the current animation value, which can be used
/// to animate the child widget based on this value. The range of the value is typically
/// between 0.0 and 1.0, where 0.0 represents the starting point of the animation, and
/// 1.0 represents the end point of the animation.
///
/// This builder is used by [FluidProgressIndicator.animationChildBuilder] to create
/// custom animated content that appears inside the progress indicator. The animation
/// value corresponds to the progress fill animation, allowing you to synchronize
/// child widget animations with the progress indicator's fill animation.
///
/// Example usage:
///
/// ```dart
/// FluidProgressIndicator(
///   maxProgress: 100,
///   progress: 75,
///   animationChildBuilder: (context, value) {
///     return Text(
///       "${(value * 75).toInt()}%",
///       style: TextStyle(color: Colors.white),
///     );
///   },
///   fillColor: Colors.blue,
/// )
/// ```
///
typedef HeightAnimatedChildBuilder = Widget Function(
  BuildContext context,
  double value,
);

/// A custom fluid progress indicator widget with animated wave effects.
///
/// The [FluidProgressIndicator] class is a stateful widget used to display a custom fluid
/// progress indicator. It visualizes the progress as a fluid wave animation with optional
/// child animations and customizable background and fill colors.
///
/// The widget displays progress using an animated wave effect that fills from bottom to top
/// based on the ratio of [progress] to [maxProgress]. The wave animation continuously loops,
/// creating a fluid, dynamic appearance.
///
/// Example usage:
///
/// ```dart
/// FluidProgressIndicator(
///   maxProgress: 100,
///   progress: 75,
///   fillColor: Colors.blue,
///   borderRadius: 12.0,
/// )
/// ```
///
/// With custom background and animated child:
///
/// ```dart
/// FluidProgressIndicator(
///   maxProgress: 100,
///   progress: 60,
///   fillGradient: LinearGradient(
///     colors: [Colors.blue, Colors.purple],
///   ),
///   backgroundConfig: IndicatorBackgroundConfig(
///     color: Colors.grey[200],
///   ),
///   animationChildBuilder: (context, value) {
///     return Text(
///       "${(value * 60).toInt()}%",
///       style: TextStyle(color: Colors.white),
///     );
///   },
/// )
/// ```
///
class FluidProgressIndicator extends StatefulWidget {
  /// The maximum value of the progress indicator.
  ///
  /// This represents the total or maximum value that the progress can reach.
  /// The actual progress displayed is calculated as `progress / maxProgress`.
  ///
  /// Must be greater than 0 and greater than or equal to [progress].
  final int maxProgress;

  /// The current progress value.
  ///
  /// This represents the current progress value. The widget will display
  /// progress as a percentage calculated from [progress] / [maxProgress].
  ///
  /// Must be between 0 and [maxProgress] (inclusive).
  final int progress;

  /// The border radius of the fluid progress indicator.
  ///
  /// Controls the roundness of the corners of the progress indicator.
  /// A value of 0 creates sharp corners, while larger values create more
  /// rounded corners.
  ///
  /// Defaults to 8.0.
  final double borderRadius;

  /// The fill color for the fluid wave animation.
  ///
  /// This color is used to fill the animated wave that represents the progress.
  /// If both [fillColor] and [fillGradient] are provided, [fillGradient] takes
  /// precedence.
  ///
  /// Either [fillColor] or [fillGradient] must be provided (not null).
  final Color? fillColor;

  /// The fill gradient for the fluid wave animation.
  ///
  /// This gradient is used to fill the animated wave that represents the progress.
  /// If both [fillColor] and [fillGradient] are provided, [fillGradient] takes
  /// precedence and will be used as the fill.
  ///
  /// Either [fillColor] or [fillGradient] must be provided (not null).
  ///
  /// Example:
  ///
  /// ```dart
  /// fillGradient: LinearGradient(
  ///   colors: [Colors.blue, Colors.purple],
  ///   begin: Alignment.topLeft,
  ///   end: Alignment.bottomRight,
  /// )
  /// ```
  final Gradient? fillGradient;

  /// The configuration for the background view of the fluid progress indicator.
  ///
  /// This allows customization of the background appearance behind the progress
  /// fill. You can set colors, gradients, images, or borders.
  ///
  /// If null, defaults to [IndicatorBackgroundConfig.defaults] which uses
  /// the theme's `onSurface` color.
  ///
  /// See [IndicatorBackgroundConfig] for more details on configuration options.
  final IndicatorBackgroundConfig? backgroundConfig;

  /// A builder function to animate the child inside the fluid progress indicator.
  ///
  /// This optional builder allows you to display custom content (like text, icons,
  /// or other widgets) inside the progress indicator that animates in sync with
  /// the progress fill animation.
  ///
  /// The [value] parameter ranges from 0.0 to 1.0, representing the animation
  /// progress. You can use this to create synchronized animations, display
  /// percentage values, or show other progress-related content.
  ///
  /// The child is centered within the progress indicator.
  ///
  /// Example:
  ///
  /// ```dart
  /// animationChildBuilder: (context, value) {
  ///   return Text(
  ///     "${(value * progress).toInt()}%",
  ///     style: TextStyle(color: Colors.white),
  ///   );
  /// }
  /// ```
  ///
  /// See [HeightAnimatedChildBuilder] for the function signature.
  final HeightAnimatedChildBuilder? animationChildBuilder;

  /// The curve used for animating the height of the fluid progress indicator.
  ///
  /// This curve controls the easing animation when the progress value changes.
  /// Common curves include [Curves.easeInOut], [Curves.easeOut], [Curves.bounceOut], etc.
  ///
  /// Defaults to [Curves.easeInOut].
  final Curve heightCurve;

  /// The duration for animating the height progress for the view.
  ///
  /// This controls how long it takes for the progress fill to animate from its
  /// previous value to the new value when [progress] changes.
  ///
  /// Defaults to 2000 milliseconds (2 seconds).
  final Duration heightAnimationDuration;

  /// The number of waves to display in the fluid progress view.
  ///
  /// Controls how many wave peaks appear in the fluid animation. More waves
  /// create a more complex, dynamic appearance, while fewer waves create a
  /// simpler, smoother look.
  ///
  /// Must be greater than 0.
  ///
  /// Defaults to 1.
  final int noOfWaves;

  /// The amplitude of the waves in the fluid progress view.
  ///
  /// Controls how high the wave peaks are. Larger values create more pronounced
  /// waves, while smaller values create subtler, flatter waves.
  ///
  /// Must be greater than 0.
  ///
  /// Defaults to 8.0.
  final double waveAmplitude;

  const FluidProgressIndicator({
    super.key,
    required this.maxProgress,
    required this.progress,
    this.animationChildBuilder,
    this.borderRadius = _kDefaultBorderRadius,
    this.fillColor,
    this.fillGradient,
    this.backgroundConfig,
    this.heightCurve = Curves.easeInOut,
    this.heightAnimationDuration = _kFillingViewAnimationDuration,
    this.noOfWaves = 1,
    this.waveAmplitude = 8.0,
  })  : assert(
          progress <= maxProgress,
          "Progress can't be more than max progress",
        ),
        assert(
          (fillColor != null) || (fillGradient != null),
          "Both fill-color and fill-gradient shall not be null",
        );

  @override
  State<FluidProgressIndicator> createState() => _FluidProgressIndicatorState();
}

class _FluidProgressIndicatorState extends State<FluidProgressIndicator> with TickerProviderStateMixin {
  // Fluid animation duration in milliseconds
  final Duration _kFluidAnimationDuration = const Duration(
    milliseconds: 4000,
  );

  // Animation controller to handle fluidity of the progress indicator
  late AnimationController _fluidAnimationController;

  // Animation controller to handle height updates for the progress
  late AnimationController _heightAnimationController;

  IndicatorBackgroundConfig _bgConfig(BuildContext context) =>
      widget.backgroundConfig ?? IndicatorBackgroundConfig.defaults(context);

  @override
  void initState() {
    super.initState();
    // initialising the controllers
    _fluidAnimationController = AnimationController(
      duration: _kFluidAnimationDuration,
      vsync: this,
    );
    _heightAnimationController = AnimationController(
      duration: widget.heightAnimationDuration,
      vsync: this,
    );

    // asking controllers to repeat and move forward as per their nature
    _fluidAnimationController.repeat();
    _heightAnimationController.forward();
  }

  @override
  void didUpdateWidget(FluidProgressIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.progress != widget.progress) {
      _heightAnimationController.forward(from: 0);
    }
  }

  @override
  void dispose() {
    // disposing the controllers
    _fluidAnimationController.dispose();
    _heightAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.borderRadius),
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          _ProgressBackgroundView(
            borderRadius: widget.borderRadius,
            bgConfig: _bgConfig(context),
          ),
          _AnimatedFluidProgressView(
            fillColor: widget.fillColor,
            fillGradient: widget.fillGradient,
            fluidAnimation: _fluidAnimationController.view,
            heightAnimation: _heightAnimationController.view,
            heightCurve: widget.heightCurve,
            waveAmplitude: widget.waveAmplitude,
            noOfWaves: widget.noOfWaves,
            progress: (widget.maxProgress == 0) ? 0 : (widget.progress / widget.maxProgress),
          ),
          if (widget.animationChildBuilder != null) ...[
            Center(
              child: AnimatedBuilder(
                animation: _heightAnimationController,
                builder: (ctx, child) => widget.animationChildBuilder!(
                  ctx,
                  _heightAnimationController.value,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
