import 'package:flutter/material.dart';
import 'package:fluid_progress_indicator/fluid_progress_indicator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fluid progress demo"),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 16.0),
            Expanded(
              child: Row(
                children: [
                  const SizedBox(width: 16.0),
                  const Expanded(
                    child: FluidProgressIndicator(
                      maxProgress: 100,
                      progress: 40,
                      backgroundConfig: IndicatorBackgroundConfig(
                        image: DecorationImage(
                          image: AssetImage("assets/bg-image.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      fillColor: Color(0xFF29ED74),
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: FluidProgressIndicator(
                      maxProgress: 100,
                      progress: 67,
                      animationChildBuilder: (context, value) {
                        return Text(
                          "${(value * 67).toInt().toString()} %",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                color: Colors.white,
                              ),
                        );
                      },
                      backgroundConfig: const IndicatorBackgroundConfig(
                        gradient: LinearGradient(
                          colors: [
                            Colors.lightBlueAccent,
                            Colors.blueAccent,
                          ],
                        ),
                      ),
                      fillColor: Theme.of(context).colorScheme.error.withValues(
                            alpha: 0.69,
                          ),
                    ),
                  ),
                  const SizedBox(width: 16.0),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: Row(
                children: [
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: FluidProgressIndicator(
                      maxProgress: 100,
                      progress: 100,
                      borderRadius: 24,
                      animationChildBuilder: (context, value) {
                        return Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                              width: 72.0,
                              height: 72.0,
                              child: CircularProgressIndicator(
                                value: value,
                                color: Colors.red,
                                strokeWidth: 8.0,
                              ),
                            ),
                            Text(
                              "${(value * 100).toInt().toString()} %",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    color: Colors.red,
                                  ),
                            )
                          ],
                        );
                      },
                      backgroundConfig: IndicatorBackgroundConfig(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                      fillColor: Theme.of(context).colorScheme.primaryContainer,
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: FluidProgressIndicator(
                      maxProgress: 100,
                      progress: 80,
                      heightAnimationDuration: const Duration(
                        seconds: 5,
                      ),
                      animationChildBuilder: (context, value) {
                        const totalProgress = 100;
                        return Text(
                          "${(value * 80).toInt().toString()} / $totalProgress",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                color: Colors.white,
                              ),
                        );
                      },
                      fillGradient: const LinearGradient(
                        colors: [
                          Colors.teal,
                          Colors.tealAccent,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16.0),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}
