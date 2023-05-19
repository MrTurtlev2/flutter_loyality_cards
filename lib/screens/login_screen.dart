import 'package:flutter/material.dart';
import 'package:flutter_loyality_card/screens/main_screen.dart';
import 'package:flutter_loyality_card/widgets/custom_button.dart';
import 'package:flutter_loyality_card/widgets/custom_input.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final usernameController = TextEditingController();
    final passwordController = TextEditingController();
    final formKeyUsername = GlobalKey<FormState>();
    final formKeyPassword = GlobalKey<FormState>();

    void signUserIn() {
      if (formKeyUsername.currentState?.validate() != true) {
        return;
      }
      if (formKeyPassword.currentState?.validate() != true) {
        return;
      }
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => MainScreen(title: 'Loyal.Io'),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                const Icon(
                  Icons.lock,
                  size: 100,
                ),
                const SizedBox(height: 50),
                Text(
                  'Log In',
                  style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 20,
                      fontWeight: FontWeight.w800
                  ),
                ),
                const SizedBox(height: 25),
                Form(
                  key: formKeyUsername,
                  child: CustomInput(
                    controller: usernameController,
                    hintText: 'Username',
                    obscureText: false,
                    validator: validateUsername,
                  ),
                ),
                const SizedBox(height: 10),

                Form(
                  key: formKeyPassword,
                  child: CustomInput(
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: true,
                    validator: validatePassword,
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                CustomButton(
                  text: 'sign in',
                  onTap: signUserIn,
                ),
                const SizedBox(height: 100),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not a member?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      'Register now',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

String? validateUsername(String? value) {
  if (value?.isEmpty != false) {
    return 'You need to pass username';
  }
  if (value!.length < 4 ) {
    return 'You need to pass 4 length username or more';
  }
  return null;
}
String? validatePassword(String? value) {
  if (value?.isEmpty != false) {
    return 'You need to pass password';
  }
  if (value!.length < 4 ) {
    return 'You need to pass 8 length password or more';
  }
  return null;
}