part of '../fluid_progress_indicator.dart';

/// A widget representing an animated fluid progress view.
///
/// The [_AnimatedFluidProgressView] class is a stateless widget used to display an animated
/// fluid progress view. It takes several parameters to customize the appearance and animation
/// of the fluid progress. The progress is visualized using a [CustomPaint] widget with a custom
/// painter called [FluidWavePainter].
///
/// This widget handles the animated fill portion of the progress indicator, animating both
/// the height (based on progress) and the wave motion (for the fluid effect).
///
/// This is an internal widget used by [FluidProgressIndicator] and should not be instantiated
/// directly.
///
class _AnimatedFluidProgressView extends StatelessWidget {
  /// The fill color for the fluid progress view.
  ///
  /// Used to fill the wave animation. If both [fillColor] and [fillGradient]
  /// are provided, [fillGradient] takes precedence.
  final Color? fillColor;

  /// The fill gradient for the fluid progress view.
  ///
  /// Used to fill the wave animation. If both [fillColor] and [fillGradient]
  /// are provided, [fillGradient] takes precedence.
  final Gradient? fillGradient;

  /// The animation controlling the fluid wave animation.
  ///
  /// This animation drives the horizontal movement of the waves, creating
  /// the continuous fluid motion effect. Typically repeats continuously.
  final Animation<double> fluidAnimation;

  /// The animation controlling the height of the fluid progress view.
  ///
  /// This animation drives the vertical fill of the progress indicator,
  /// animating from 0.0 to 1.0 based on the current progress value.
  final Animation<double> heightAnimation;

  /// The curve used for animating the height of the fluid progress view.
  ///
  /// Controls the easing of the height animation. Applied to [heightAnimation]
  /// to create smooth transitions when progress changes.
  final Curve heightCurve;

  /// The number of waves to display in the fluid progress view.
  ///
  /// Controls how many wave peaks appear in the animation.
  ///
  /// Defaults to 1.
  final int noOfWaves;

  /// The amplitude of the waves in the fluid progress view.
  ///
  /// Controls how high the wave peaks are. Larger values create more
  /// pronounced waves.
  ///
  /// Defaults to 4.0.
  final double waveAmplitude;

  /// The percentage progress calculated as per actual & max progress.
  ///
  /// Represents the progress as a value between 0.0 and 1.0, where
  /// 0.0 is no progress and 1.0 is complete.
  ///
  /// Must be within 0.0 and 1.0 (inclusive).
  final double progress;

  const _AnimatedFluidProgressView({
    required this.fluidAnimation,
    required this.heightAnimation,
    required this.heightCurve,
    required this.progress,
    this.noOfWaves = 1,
    this.waveAmplitude = 4.0,
    this.fillColor,
    this.fillGradient,
  })  : assert(
          (fillColor != null) || (fillGradient != null),
          "Both fill-color and fill-gradient shall not be null",
        ),
        assert(
          (progress >= 0 && progress <= 1),
          "Progress shall be between 0 & 1",
        );

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        final progressHeight = (progress * constraints.maxHeight);
        return AnimatedBuilder(
          animation: CurvedAnimation(
            curve: heightCurve,
            parent: heightAnimation,
          ),
          builder: (ctx, child) => Container(
            clipBehavior: Clip.hardEdge,
            height: (heightAnimation.value * progressHeight),
            width: constraints.maxWidth,
            decoration: const BoxDecoration(),
            child: AnimatedBuilder(
              animation: fluidAnimation,
              builder: (ctx, child) => CustomPaint(
                painter: FluidWavePainter(
                  controller: fluidAnimation,
                  waves: noOfWaves,
                  waveAmplitude: waveAmplitude,
                  fillColor: fillColor,
                  fillGradient: fillGradient,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
