import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart' show Widget, BuildContext;
import 'package:flutter_firebase/app/ui/pages/splash/splash_page.dart';
import 'package:flutter_firebase/app/ui/routes/routes.dart';
import 'package:flutter_firebase/screens/home_page.dart';
import 'package:flutter_firebase/screens/login_page.dart';
import 'package:flutter_firebase/screens/sign_in_page.dart';

Map<String, Widget Function(BuildContext)> get appRoutes => {
      Routes.SPLASH: (_) => const SplashPage(),
      Routes.LOGIN: (_) =>  const LoginPage(),
      Routes.HOME: (_) => const HomeWidget(),
      Routes.REGISTER: (_) => const Sign_In_Page(),
    };
