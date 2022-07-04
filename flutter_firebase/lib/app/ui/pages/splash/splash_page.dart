import 'package:flutter/material.dart';
import 'package:flutter_firebase/app/ui/global_controllers/session_controller.dart';
import 'package:flutter_firebase/app/ui/pages/splash/splash_controller.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:flutter_meedu/ui.dart';

final splashProvider = SimpleProvider(
  (_) => SplashController(sessionProvider.read),
);

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderListener<SplashController>(
        provider: splashProvider,
        onChange: (_, controller) {
          //print("${controller.routeName}");
          final routeName = controller.routeName;
          if (routeName != null) {
            router.pushReplacementNamed(routeName);
          }
        },
        builder: (_, __) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
