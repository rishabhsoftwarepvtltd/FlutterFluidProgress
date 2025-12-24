import 'package:flutter/material.dart';

// coverage:ignore-file
/// A custom painter to draw a fluid wave animation.
///
/// The [FluidWavePainter] class is a custom painter used to draw a fluid wave animation
/// based on the provided [controller] animation. It animates the wave using the [_position]
/// animation and fills it with the specified [fillColor] or [fillGradient].
///
/// The painter creates smooth, continuous wave patterns that animate horizontally to create
/// a fluid, dynamic appearance. The waves are drawn using quadratic Bezier curves, allowing
/// for smooth, organic-looking animations.
///
/// This painter is used internally by [FluidProgressIndicator] to render the animated
/// wave fill effect.
///
class FluidWavePainter extends CustomPainter {
  /// The animation controller used for the wave animation.
  ///
  /// This controller drives the horizontal movement of the waves. The animation
  /// typically repeats continuously to create a seamless looping effect.
  final Animation<double> controller;

  /// The fill color for the wave.
  ///
  /// This color is used to fill the wave shape. If both [fillColor] and
  /// [fillGradient] are provided, [fillGradient] takes precedence.
  ///
  /// Either [fillColor] or [fillGradient] must be provided (not null).
  final Color? fillColor;

  /// Number of waves to paint.
  ///
  /// Controls how many wave peaks appear in the animation. More waves create
  /// a more complex pattern, while fewer waves create a simpler appearance.
  ///
  /// Must be greater than 0.
  final int waves;

  /// The amplitude of the waves.
  ///
  /// Controls how high the wave peaks are. Larger values create more pronounced
  /// waves with greater vertical variation, while smaller values create subtler,
  /// flatter waves.
  ///
  /// Must be greater than 0.
  final double waveAmplitude;

  /// The fill gradient for the wave.
  ///
  /// This gradient is used to fill the wave shape. If both [fillColor] and
  /// [fillGradient] are provided, [fillGradient] takes precedence.
  ///
  /// Either [fillColor] or [fillGradient] must be provided (not null).
  final Gradient? fillGradient;

  // The animation controlling the wave position.
  late final Animation<double> _position;

  // How many segments to prepare as per waves count
  int get _waveSegments => (2 * waves) - 1;

  FluidWavePainter({
    required this.controller,
    required this.waves,
    required this.waveAmplitude,
    this.fillColor,
    this.fillGradient,
  }) {
    assert(
      (fillColor != null) || (fillGradient != null),
      "Both fill-color and fill-gradient shall not be null",
    );
    _position = Tween(begin: 0.0, end: 1.0)
        .chain(CurveTween(curve: Curves.linear))
        .animate(controller);
  }

  void prepareWave({
    required Path path,
    required int wave,
    required Size size,
  }) {
    /// All examples shown with following data
    /// Width => 100
    /// Height => 200
    /// noOfWave => 1
    /// waveSegments =? (2 *{1})-1 => 1
    /// waveAmplitude => 12

    // getting wave width from width and segments calculated upon wave count
    // (100 / 1) => 100
    double waveWidth = (size.width / _waveSegments);

    // calculating wave min height as per amplitude.
    // if amplitude is 12, then minHeight will be 6 (this will show the waviness from -6 to +6)
    double waveMinHeight = (waveAmplitude / 2);

    /// calculating stretch point of the bezier curve
    // (0 * 100 + 100/2) => 50.0 [NOTE : This is first time's wave calculation]
    double x1 = (wave * waveWidth + waveWidth / 2);

    // Minimum and maximum height points of the waves.
    // (6 + (-12)) => -6.0 [NOTE : This is first time's wave calculation]
    double y1 = (waveMinHeight + (wave.isOdd ? waveAmplitude : -waveAmplitude));

    /// calculating the end points of the bezier curve
    // (50 + (100/2)) => 100.0
    double x2 = (x1 + (waveWidth / 2));

    // => 6.0
    double y2 = waveMinHeight;

    // to draw the quadratic curve with above calculated values
    path.quadraticBezierTo(x1, y1, x2, y2);

    // if condition satisfies, then will prepare another wave
    if (wave <= (_waveSegments + 2)) {
      prepareWave(path: path, wave: wave + 1, size: size);
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..style = PaintingStyle.fill;

    if (fillGradient != null) {
      paint.shader = fillGradient!.createShader(Rect.fromPoints(
        size.topLeft(Offset.zero),
        size.bottomRight(Offset.zero),
      ));
    } else {
      paint.color = fillColor!;
    }

    // Moving the path to half of the wave amplitude
    // it is from where, the wave will start
    Path path = Path()..moveTo(0, (waveAmplitude / 2));

    // Adding bezier curve (wave) - to prepare a wave to the path reference
    prepareWave(path: path, wave: 0, size: size);

    // Draw lines to the bottom corners of the
    // size/screen with account for one extra wave.
    double waveWidth = ((size.width / _waveSegments) * 4);

    // to fill the remaining bottom from the wave end point.
    path
      ..lineTo((size.width + (waveWidth * 2)), size.height)
      ..lineTo(0, size.height)
      ..close();

    // Animate sideways one wave length, so it repeats cleanly.
    Path shiftedPath = path.shift(
      Offset(-(_position.value) * waveWidth, 0),
    );

    // drawing the whole path on the canvas to feel like animation
    canvas.drawPath(shiftedPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
