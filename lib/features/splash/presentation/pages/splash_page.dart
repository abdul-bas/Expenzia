import 'package:flutter/material.dart';
import 'package:expenzia/features/splash/presentation/controllers/splash_controller.dart';
import 'package:expenzia/features/splash/presentation/widgets/splash_background.dart';
import 'package:expenzia/features/splash/presentation/widgets/splash_title.dart';

class SplashPage extends StatelessWidget {
  SplashPage({
    super.key,
    SplashController? controller,
  }) : controller = controller ?? SplashController();

  final SplashController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListenableBuilder(
        listenable: controller,
        builder: (context, _) {
          return Stack(
            fit: StackFit.expand,
            children: [
              const SplashBackground(),
              SplashTitle(opacity: controller.isLoaded ? 1.0 : 0.0),
            ],
          );
        },
      ),
    );
  }
}
