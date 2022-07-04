import 'package:flutter/cupertino.dart';
import 'package:flutter_firebase/app/domain/inputs/sign_up.dart';
import 'package:flutter_firebase/app/ui/global_widgets/dialogs/dialogs.dart';
import 'package:flutter_firebase/app/ui/global_widgets/dialogs/progress_dialog.dart';
import 'package:flutter_firebase/app/ui/routes/routes.dart';
import 'package:flutter_firebase/screens/sign_in_page.dart'
    show registerProvider;
import 'package:flutter_meedu/ui.dart';

Future<void> sendRegisterForm(BuildContext context) async {
  final controller = registerProvider.read;
  final isValidForm = controller.formKey.currentState!.validate();

  if (isValidForm) {
    ProgressDialog.show(context);
    final response = await controller.submit();
    router.pop();

    if (response.error != null) {
      late String content;
      switch (response.error) {
        case SignUpError.emailAlreadyInUse:
          content = "Email already in use!";
          break;
        case SignUpError.werakPassword:
          content = "Weak password";
          break;
        case SignUpError.networkRequestFailed:
          content = "Network Request Failed";
          break;
        case SignUpError.unKnown:
        default:
          content = "Unknow error";
          break;
      }
      // ignore: use_build_context_synchronously
      Dialogs.alert(
        context,
        title: "ERROR",
        content: content,
      );
    } else {
      router.pushNamedAndRemoveUntil(
        Routes.HOME,
      );
    }
  } else {
    Dialogs.alert(
      context,
      title: "ERROR",
      content: "Invalid Fields",
    );
  }
}
