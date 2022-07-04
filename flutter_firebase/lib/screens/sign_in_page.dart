// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:flutter_firebase/app/ui/global_controllers/session_controller.dart';
import 'package:flutter_firebase/app/ui/global_widgets/custom_input_field.dart';
import 'package:flutter_firebase/app/utils/email_validator.dart';
import 'package:flutter_firebase/app/utils/name_validator.dart';
import 'package:flutter_firebase/screens/controllers/register/register_controller.dart';
import 'package:flutter_firebase/screens/controllers/register/register_state.dart';
import 'package:flutter_firebase/screens/controllers/register/utils/send_register_form.dart';
import 'package:flutter_firebase/screens/login_page.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:flutter_meedu/ui.dart';

final registerProvider = StateProvider<RegisterController, RegisterState>(
  (_) => RegisterController(sessionProvider.read),
);

class Sign_In_Page extends StatefulWidget {
  const Sign_In_Page({Key? key}) : super(key: key);

  @override
  State<Sign_In_Page> createState() => _Sign_In_Page();
}

class _Sign_In_Page extends State<Sign_In_Page> {
  late double width, height;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return ProviderListener<RegisterController>(
      provider: registerProvider,
      builder: (_, controller) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            leading: (const BackButton(
              color: Colors.grey,
            )),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          backgroundColor: Colors.white,
          body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SafeArea(
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: SingleChildScrollView(
                  child: SizedBox(
                    height: height,
                    child: Form(
                      key: controller.formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          imagenSignIn(),

                          const Padding(
                            padding: EdgeInsets.only(right: 240),
                            child: Center(
                              child: Text(
                                'Sign In',
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
                              validator: (text) {
                                return isValidEmail(text!)
                                    ? null
                                    : "Invalid Email ID";
                              },
                            ),
                          ),

                          const SizedBox(height: 10),

                          //Textfield Full name
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 35.0),
                            child: CustomInputField(
                              label: "Full Name",
                              prefixIcon: const Icon(Icons.person_outline),
                              onChanged: controller.onNameChanged,
                              validator: (text) {
                                return isValidName(text!)
                                    ? null
                                    : "Invalid Name";
                              },
                            ),
                          ),
                          //Textfield Full name

                          const SizedBox(height: 10), //Separación

                          //Textfield Passwrod
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 35.0),
                            child: CustomInputField(
                              label: "Password",
                              prefixIcon: const Icon(Icons.lock_outline),
                              onChanged: controller.onPasswordChanged,
                              isPassword: true,
                              validator: (text) {
                                if (text!.trim().length >= 6) {
                                  return null;
                                }
                                return "Invalid Password - Min. 6 characters";
                              },
                            ),
                          ),
                          //Textfield Password

                          const SizedBox(height: 10), //Separación

                          //Textfield Passwrod
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 35.0),
                            child: CustomInputField(
                              label: "Confirm Password",
                              prefixIcon: const Icon(Icons.lock_outline),
                              onChanged: controller.onVPassword,
                              isPassword: true,
                              validator: (text) {
                                if (controller.state.password != text) {
                                  return "password don't match";
                                }
                                if (text!.trim().length >= 6) {
                                  return null;
                                }
                                return "Invalid Password";
                              },
                            ),
                          ),
                          //Textfield Password

                          const SizedBox(height: 20), //Separación

                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 35.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: const [
                                Text(
                                  "By signing up, you're agree to our",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  ' Terms & Conditions',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff3C6DA5),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 5),

                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 35.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: const [
                                Text(
                                  "and",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  ' Privacy Policy',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff3C6DA5),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 15), //Separación

                          ElevatedButton(
                              onPressed: () => sendRegisterForm(context),
                              style: ElevatedButton.styleFrom(
                                primary: const Color(0xff0166FF),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 150, vertical: 15),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                              ),
                              child: const Text('Continue')),

                          const SizedBox(height: 5), //Separación

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(),
                                child: Row(
                                  children: [
                                    const Text(
                                      "Joined us before? ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const LoginPage()),
                                        );
                                      },
                                      child: const Text(
                                        "Login",
                                        style: TextStyle(
                                          color: Color(0xff3C6DA5),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
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
        );
      },
    );
  }

  Widget imagenSignIn() {
    return Image.asset("assets/images/imagen2.jpeg",
        height: height * 0.25, fit: BoxFit.fitHeight);
  }
}
