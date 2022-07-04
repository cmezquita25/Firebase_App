import 'package:flutter/material.dart';
import 'package:flutter_firebase/app/ui/global_controllers/session_controller.dart';
import 'package:flutter_firebase/app/ui/global_widgets/custom_input_field.dart';
import 'package:flutter_firebase/app/ui/routes/routes.dart';
import 'package:flutter_firebase/app/utils/email_validator.dart';
import 'package:flutter_firebase/screens/controllers/login/utils/send_login_form.dart';
import 'package:flutter_meedu/ui.dart';
import 'package:text_divider/text_divider.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

import 'package:flutter_meedu/meedu.dart';

import 'controllers/login/login_controller.dart';

// ignore: non_constant_identifier_names
final LoginProvider = SimpleProvider(
  (_) => LoginController(sessionProvider.read),
);

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late double width, height;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return ProviderListener<LoginController>(
      provider: LoginProvider,
      builder: (_, controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  child: GestureDetector(
                    child: SizedBox(
                      height: height,
                      child: Form(
                        key: controller.formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            imagenLogin(),

                            const Padding(
                              padding: EdgeInsets.only(right: 270),
                              child: Center(
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff1B2F50),
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 5), //Separación

                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 35.0),
                              child: CustomInputField(
                                label: "Email ID",
                                prefixIcon: const Icon(Icons.email_outlined),
                                inputType: TextInputType.emailAddress,
                                onChanged: controller.onEmailChanged,
                                // ignore: body_might_complete_normally_nullable
                                validator: (text) {
                                  if (isValidEmail(text!)) {
                                    return null;
                                  }
                                  return "Invalid email";
                                },
                              ),
                            ),

                            const SizedBox(height: 10), //Separación

                            //Textfield Contraseña
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 35.0),
                              child: CustomInputField(
                                  label: "Password",
                                  prefixIcon: const Icon(Icons.lock_outline),
                                  isPassword: true,
                                  onChanged: controller.onPasswordChanged,
                                  // ignore: body_might_complete_normally_nullable
                                  validator: (text) {
                                    if (text!.trim().length >= 6) {
                                      return null;
                                    }
                                    return "Invalidad password";
                                  }),
                            ),
                            //Textfield Contraseña

                            const SizedBox(height: 10), //Separación

                            //Botón de Olvidar contraseña
                            const Padding(
                              padding: EdgeInsets.only(left: 225),
                              child: Center(
                                child: Text(
                                  'Forgot Password?',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff3C6DA5),
                                  ),
                                ),
                              ),
                            ),
                            //Botón de Olvidar contraseña

                            const SizedBox(height: 10), //Separación

                            ElevatedButton(
                                onPressed: () => sendLoginForm(context),
                                style: ElevatedButton.styleFrom(
                                  primary: const Color(0xff0166FF),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 150, vertical: 15),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                ),
                                child: const Text('Login')),

                            const SizedBox(height: 10), //Separación

                            TextDivider.horizontal(
                                text: const Text(
                                  'OR',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                ),
                                color: const Color.fromARGB(
                                  115,
                                  212,
                                  212,
                                  212,
                                ),
                                thickness: 3.0),

                            const SizedBox(height: 10), //Separación

                            //Botón Login Google
                            SizedBox(
                              width: 330,
                              child: SignInButton(
                                Buttons.Google,
                                text: 'Login with Google',
                                onPressed: () {},
                              ),
                            ),
                            //Botón Login Google

                            const SizedBox(height: 10), //Separación

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'New to logistics?',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () => router.pushNamed(
                                    Routes.REGISTER,
                                  ),
                                  child: const Text(
                                    "Register",
                                    style: TextStyle(
                                      color: Color(0xff3C6DA5),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget imagenLogin() {
    return Image.asset("assets/images/imagen1.jpeg",
        height: height * 0.25, fit: BoxFit.fitHeight);
  }
}
