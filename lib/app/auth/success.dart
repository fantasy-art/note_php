import 'package:flutter/material.dart';

class Success extends StatelessWidget {
  const Success({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 20, 53, 100),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/succes.png'),
            const SizedBox(height: 30),
            const Text('Account Registered', style: TextStyle(fontSize: 30)),
            const SizedBox(height: 10),
            const Text('You can now login your account',
                style: TextStyle(fontSize: 18)),
            const SizedBox(height: 30),
            TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('Login', (route) => false);
                },
                child: const Text(
                  'Login',
                  style: TextStyle(color: Colors.amber, fontSize: 18),
                ))
          ],
        ),
      ),
    );
  }
}
