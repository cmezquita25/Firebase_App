import 'package:flutter/material.dart';
import 'package:flutter_firebase/app/ui/routes/app_routes.dart';
import 'package:flutter_firebase/app/ui/routes/routes.dart';
import 'package:flutter_meedu/ui.dart';
//import 'package:flutter_meedu/ui.dart' as router; //pendiente

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter FA',
      navigatorKey: router.navigatorKey,
      debugShowCheckedModeBanner: false,
      //home: LoginPage(),
      initialRoute: Routes.SPLASH,
      navigatorObservers: [
        router.observer
        ],
      routes: appRoutes,
    );
  }
}
