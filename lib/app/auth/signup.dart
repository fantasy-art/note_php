import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:note_php/component/crud.dart';
import 'package:note_php/component/custom_button.dart';
import 'package:note_php/component/custom_text_form_field.dart';
import 'package:note_php/component/valid.dart';
import 'package:note_php/constant/url_api.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  GlobalKey<FormState> formstate = GlobalKey();

  bool isLoading = false;

  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  Crud crud = Crud();

  signUp() async {
    if (formstate.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      var response = await crud.postRequest(urlSignUp, {
        "username": username.text,
        "email": email.text,
        "password": password.text
      });
      isLoading = false;
      setState(() {});
      if (response['status'] == 'success') {
        // ignore: use_build_context_synchronously
        Navigator.of(context)
            .pushNamedAndRemoveUntil('Success', (route) => false);
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
                      children: [
                        Image.asset('images/note_logo.png', height: 250),
                        CustomTextForm(
                            valid: (val) => validInput(val!, 3, 20),
                            hintText: 'UserName',
                            textController: username),
                        CustomTextForm(
                            valid: (val) => validInput(val!, 5, 40),
                            hintText: 'Email',
                            textController: email),
                        CustomTextForm(
                            valid: (val) => validInput(val!, 3, 10),
                            hintText: 'Password',
                            textController: password),
                        const SizedBox(height: 20),
                        CustomButton(
                            text: 'SignUp',
                            onPressed: () async {
                              await signUp();
                            }),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Ready have an account"),
                            TextButton(
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                      context, "Login");
                                },
                                child: const Text(
                                  'SignIn',
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
