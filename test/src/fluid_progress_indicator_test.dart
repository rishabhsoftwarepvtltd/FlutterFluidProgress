import 'package:fluid_progress_indicator/fluid_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    "fluidProgressIndicator_whenCalledWithInValidProgress_shallThrowAssertion",
    (WidgetTester widgetTester) async {
      final widgetUnderTest = Builder(builder: (BuildContext context) {
        return FluidProgressIndicator(
          progress: 12,
          maxProgress: 10,
        );
      });
      await widgetTester.pumpWidget(widgetUnderTest);
      expect(widgetTester.takeException(), isA<AssertionError>());
    },
  );

  testWidgets(
    "fluidProgressIndicator_whenCalledWithoutFillColor_shallThrowAssertion",
    (WidgetTester widgetTester) async {
      final widgetUnderTest = Builder(builder: (BuildContext context) {
        return FluidProgressIndicator(
          progress: 9,
          maxProgress: 10,
        );
      });
      await widgetTester.pumpWidget(widgetUnderTest);
      expect(widgetTester.takeException(), isA<AssertionError>());
    },
  );

  testWidgets(
    "fluidProgressIndicator_whenCalledWithBothProgressValuesAsZero_mustBeVisibleInView",
    (WidgetTester widgetTester) async {
      const view = MaterialApp(
        home: Scaffold(
          body: FluidProgressIndicator(
            progress: 0,
            maxProgress: 0,
            fillColor: Colors.red,
          ),
        ),
      );
      await widgetTester.pumpWidget(view);

      expect(find.byType(FluidProgressIndicator), findsOneWidget);
    },
  );

  testWidgets(
    "fluidProgressIndicator_whenCalledWithValidParams_mustBeVisibleInView",
    (WidgetTester widgetTester) async {
      const view = MaterialApp(
        home: Scaffold(
          body: FluidProgressIndicator(
            progress: 12,
            maxProgress: 100,
            fillColor: Colors.red,
          ),
        ),
      );
      await widgetTester.pumpWidget(view);

      expect(find.byType(FluidProgressIndicator), findsOneWidget);
    },
  );

  testWidgets(
    "fluidProgressIndicator_whenCalledWithAnimationChildBuilder_childShallBeAvailableInUI",
    (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: FluidProgressIndicator(
            progress: 12,
            maxProgress: 100,
            fillColor: Colors.red,
            animationChildBuilder: (_, value) {
              return const CircularProgressIndicator();
            },
            heightAnimationDuration: const Duration(seconds: 4),
          ),
        ),
      ));

      expect(find.byType(FluidProgressIndicator), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    },
  );
}
