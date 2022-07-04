import 'package:flutter/cupertino.dart';
import 'package:flutter_firebase/app/domain/repositories/authentication_repository.dart';
import 'package:flutter_firebase/app/ui/global_widgets/dialogs/dialogs.dart';
import 'package:flutter_firebase/app/ui/global_widgets/dialogs/progress_dialog.dart';
import 'package:flutter_firebase/app/ui/routes/routes.dart';
import 'package:flutter_firebase/screens/login_page.dart';
import 'package:flutter_meedu/ui.dart';

Future<void> sendLoginForm(BuildContext context) async {
  final controller = LoginProvider.read;
  final isValidform = controller.formKey.currentState!.validate();
  if (isValidform) {
    ProgressDialog.show(context);
    final response = await controller.submit();
    router.pop();
    if (response.error != null) {
      String errorMessage = "";

      switch (response.error) {
        case SignInError.networkRequestFailed:
          errorMessage = "Network Request Failed";
          break;
        case SignInError.userDisabled:
          errorMessage = "User Disable";
          break;
        case SignInError.userNotFound:
          errorMessage = "User not found";
          break;
        case SignInError.wrongPassword:
          errorMessage = "Wrong Password";
          break;
        case SignInError.unKnown:
        default:
          errorMessage = "Unknown error";
          break;
      }

      // ignore: use_build_context_synchronously
      Dialogs.alert(
        context,
        title: "ERROR",
        content: errorMessage,
      );
    } else {
      router.pushReplacementNamed(
        Routes.HOME,
      );
    }
  }
}
