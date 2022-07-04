import 'package:flutter/widgets.dart';
import 'package:flutter_firebase/app/domain/inputs/sign_up.dart';
import 'package:flutter_firebase/app/domain/repositories/sign_up_repository.dart';
import 'package:flutter_firebase/app/ui/global_controllers/session_controller.dart';
import 'package:flutter_firebase/screens/controllers/register/register_state.dart';
import 'package:flutter_meedu/meedu.dart';

class RegisterController extends StateNotifier<RegisterState> {
  final SessionController _sessionController;
  RegisterController(this._sessionController)
      : super(RegisterState.initialState);
  final GlobalKey<FormState> formKey = GlobalKey();

  // ignore: unused_field
  final _signUpRepository = Get.find<SignUpRepository>();

  Future<SignUpResponse> submit() async {
    final response = await _signUpRepository.register(
      SignUpData(
        name: state.name,
        email: state.email,
        password: state.password,
      ),
    );
    if (response.error == null) {
      _sessionController.setUser(response.user!);
    }
    return response;
  }

  void onNameChanged(String text) {
    state = state.copyWith(name: text);
  }

  void onEmailChanged(String text) {
    state = state.copyWith(email: text);
  }

  void onPasswordChanged(String text) {
    state = state.copyWith(password: text);
  }

  void onVPassword(String text) {
    state = state.copyWith(vPassword: text);
  }
}
