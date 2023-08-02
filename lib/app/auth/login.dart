import 'package:flutter/material.dart';
import 'package:note_php/component/custom_button.dart';
import 'package:note_php/component/custom_text_form_field.dart';
import 'package:note_php/constant/url_api.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:note_php/main.dart';

import '../../component/crud.dart';
import '../../component/custom_text_pass_field.dart';
import '../../component/valid.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> formstate = GlobalKey();

  bool isLoading = false;

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  Crud crud = Crud();

  logIn() async {
    if (formstate.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      var response = await crud.postRequest(urlLogIn, {
        "email": email.text,
        "password": password.text,
      });
      isLoading = false;
      setState(() {});
      if (response['status'] == 'success') {
        sharedPref.setString('id', response['data']['id'].toString());
        sharedPref.setString('username', response['data']['username']);
        sharedPref.setString('email', response['data']['email']);

        // ignore: use_build_context_synchronously
        Navigator.of(context).pushNamedAndRemoveUntil('Home', (route) => false);
      } else {
        // ignore: use_build_context_synchronously
        AwesomeDialog(
                context: context,
                title: 'Warning',
                body: const Text('Check Email Or Password'))
            .show();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading == true
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              children: [
                Form(
                    key: formstate,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Image.asset('images/note_logo.png', height: 250),
                        CustomTextForm(
                            valid: (val) => validInput(val!, 5, 40),
                            hintText: 'Email',
                            textController: email),
                        CustomTextPassForm(
                            valid: (val) => validInput(val!, 3, 10),
                            hintText: 'Password',
                            textController: password),
                        const SizedBox(height: 20),
                        CustomButton(
                          text: 'Login',
                          onPressed: () async {
                            await logIn();
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don't have an account",
                              style: TextStyle(color: Colors.white),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                      context, "Signup");
                                },
                                child: const Text(
                                  'SignUp',
                                  style: TextStyle(color: Colors.amber),
                                ))
                          ],
                        )
                      ],
                    ))
              ],
            ),
    );
  }
}
