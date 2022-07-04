import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/app/inject_dependencies.dart';
import 'package:flutter_firebase/app/my_app.dart';
import 'package:flutter_firebase/services/push_notifications_services.dart';

//Proyecto FireBase-Test
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  PushNotificationService.initializeApp();
  await Firebase.initializeApp();
  injectDependencies();
  runApp(const MyApp());
}
