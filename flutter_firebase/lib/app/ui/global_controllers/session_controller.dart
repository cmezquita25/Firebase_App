import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase/app/domain/repositories/authentication_repository.dart';
import 'package:flutter_meedu/meedu.dart';

class SessionController extends SimpleNotifier {
  User? _user;
  User? get user => _user;

  final _auth = Get.find<AuthenticationRepository>();

  void setUser(User user) {
    _user = user;
    notify();
  }

  Future<void> signOut() async {
    await _auth.signOut();
    _user = null;
  }
}

final sessionProvider = SimpleProvider(
  (_) => SessionController(),
);
