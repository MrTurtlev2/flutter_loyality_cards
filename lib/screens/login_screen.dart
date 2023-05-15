import 'package:flutter/material.dart';
import 'package:flutter_loyality_card/screens/main_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  void handleLogin() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const MainScreen(title: 'Loyal.io',),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Text('Login'),
      MaterialButton(
        onPressed: handleLogin,
        child: Row(children: const [Icon(Icons.abc), Text('press')]),
      )
    ])));
  }
}
