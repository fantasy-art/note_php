import 'package:flutter/material.dart';
import 'package:note_php/app/notes/add.dart';
import 'package:note_php/app/notes/edit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:note_php/app/auth/signup.dart';
import 'package:note_php/app/auth/success.dart';
import 'package:note_php/app/home.dart';
import 'app/auth/login.dart';

late SharedPreferences sharedPref;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPref = await SharedPreferences.getInstance();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      darkTheme: ThemeData(
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: Color.fromARGB(255, 145, 201, 195),
              foregroundColor: Colors.black),
          canvasColor: const Color.fromARGB(255, 20, 53, 100),
          cardColor: const Color.fromARGB(255, 145, 201, 195),
          appBarTheme: const AppBarTheme(
              color: Color.fromARGB(255, 145, 201, 195),
              foregroundColor: Colors.black)),
      debugShowCheckedModeBanner: false,
      title: 'Course PHP Rest Api',
      initialRoute: sharedPref.getString('id') == null ? "Login" : "Home",
      routes: {
        'Login': (context) => const Login(),
        'Signup': (context) => const SignUp(),
        'Home': (context) => const Home(),
        'Success': (context) => const Success(),
        'AddNote': (context) => const AddNote(),
        'EditNote': (context) => const EditNote(
              notes: "",
            ),
      },
    );
  }
}
