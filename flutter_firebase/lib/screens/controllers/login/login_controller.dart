import 'package:flutter/cupertino.dart';
import 'package:flutter_firebase/app/domain/repositories/authentication_repository.dart';
import 'package:flutter_firebase/app/ui/global_controllers/session_controller.dart';
import 'package:flutter_meedu/meedu.dart';

class LoginController extends SimpleNotifier {
  // ignore: unused_field
  final SessionController _sessionController;
  String _email = '', _password = '';
  final _authenticationRepository = Get.find<AuthenticationRepository>();

  final GlobalKey<FormState> formKey = GlobalKey();

  LoginController(this._sessionController);

  void onEmailChanged(String text) {
    _email = text;
  }

  void onPasswordChanged(String text) {
    _password = text;
  }

  Future<SignInResponse> submit() async {
    final response = await _authenticationRepository.SignInWithEmailAndPassword(
      _email,
      _password,
    );

    if (response.error == null) {
      _sessionController.setUser(response.user!);
    }

    return response;
  }
}
