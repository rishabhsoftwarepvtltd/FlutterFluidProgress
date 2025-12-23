import 'package:fluid_progress_indicator/fluid_progress_indicator.dart';
import 'package:fluid_progress_indicator/src/extensions/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../package_mocks.dart';

void main() {
  test(
    "IndicatorBackgroundConfig_whenInitiatedWithNoData_shallReturnInstanceWithNullValues",
    () {
      const config = IndicatorBackgroundConfig();
      expect(config, isA<IndicatorBackgroundConfig>());
      expect(config, isNotNull);
      expect(config.border, isNull);
      expect(config.gradient, isNull);
      expect(config.image, isNull);
      expect(config.color, isNull);
    },
  );

  test(
    "IndicatorBackgroundConfig_whenInitiatedWithSomeData_shallReturnInstanceWithProvidedValuesInIt",
    () {
      const config = IndicatorBackgroundConfig(
        color: Colors.red,
        gradient: LinearGradient(colors: []),
      );
      expect(config, isA<IndicatorBackgroundConfig>());
      expect(config, isNotNull);
      expect(config.border, isNull);
      expect(config.gradient, isA<Gradient?>());
      expect(config.gradient, isNotNull);
      expect(config.gradient?.colors, isEmpty);
      expect(config.image, isNull);
      expect(config.color, isNotNull);
      expect(config.color, same(Colors.red));
    },
  );

  test(
    "IndicatorBackgroundConfig_whenInitiatedWithAllData_shallReturnInstanceWithValues",
    () {
      final config = IndicatorBackgroundConfig(
        color: Colors.red,
        gradient: const LinearGradient(colors: []),
        image: const DecorationImage(image: AssetImage("assetName")),
        border: Border.all(color: Colors.black),
      );
      expect(config, isA<IndicatorBackgroundConfig>());
      expect(config, isNotNull);
      expect(config.border, isA<BoxBorder?>());
      expect(config.border, isNotNull);
      expect(config.gradient, isA<Gradient?>());
      expect(config.gradient, isNotNull);
      expect(config.gradient?.colors, isEmpty);
      expect(config.image, isA<DecorationImage?>());
      expect(config.image, isNotNull);
      expect(config.image?.image, isA<AssetImage?>());
      expect(config.color, isNotNull);
      expect(config.color, same(Colors.red));
    },
  );

  test(
    "IndicatorBackgroundConfig_whenInitiatedWithDefaultData_onlyColorShallBePresent",
    () {
      final context = MockBuildContext();
      final config = IndicatorBackgroundConfig.defaults(context);
      expect(config, isA<IndicatorBackgroundConfig>());
      expect(config, isNotNull);
      expect(config.border, isNull);
      expect(config.gradient, isA<Gradient?>());
      expect(config.gradient, isNull);
      expect(config.image, isNull);
      expect(config.color, isNotNull);
      expect(config.color, same(context.theme.colorScheme.onSurface));
    },
  );
}
