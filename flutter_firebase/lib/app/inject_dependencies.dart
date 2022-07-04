import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase/app/data/repositories_impl/authentication_repository_impl.dart';
import 'package:flutter_firebase/app/data/repositories_impl/sign_up_repository_impl.dart.dart';
import 'package:flutter_firebase/app/domain/repositories/authentication_repository.dart';
import 'package:flutter_firebase/app/domain/repositories/sign_up_repository.dart';
import 'package:flutter_meedu/meedu.dart';

void injectDependencies() {
  Get.lazyPut<AuthenticationRepository>(
    () => AuthenticationRepositoryImpl(FirebaseAuth.instance),
  );
  Get.lazyPut<SignUpRepository>(
    () => SignUpRepositoryImpl(FirebaseAuth.instance),
  );
}
