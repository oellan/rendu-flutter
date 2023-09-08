import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:rendu_flutter/models/user.dart';
import 'package:rendu_flutter/widgets/login_snackbar.dart';

import '../database/db.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  onCreatePressed(BuildContext context) => () {
        if (!_formKey.currentState!.validate()) return;

        ScaffoldMessengerState scaffoldMessenger =
            ScaffoldMessenger.of(context);
        scaffoldMessenger.showSnackBar(
          LoginSnackBar.create(
            context,
            Icons.save,
            "Saving...",
          ),
        );
        String? insertResult = DB.insertUser(
          User(
            username: _usernameController.text,
            password: _passwordController.text,
          ),
        );
        if (insertResult != null) {
          scaffoldMessenger.clearSnackBars();
          scaffoldMessenger.showSnackBar(
            LoginSnackBar.create(
              context,
              Icons.error,
              insertResult,
            ),
          );
          return;
        }
        scaffoldMessenger.clearSnackBars();
        scaffoldMessenger.showSnackBar(
          LoginSnackBar.create(
            context,
            Icons.check,
            "User created with success",
          ),
        );
      };

  void onUpdatePressed() {}

  String? isUsernameValid(String? value) {
    if (value == null || value.isEmpty) {
      return "This field is required";
    }

    if (value.length < 4) {
      return "The username must be longer than 4 characters";
    }

    return null;
  }

  String? isPasswordValid(String? value) {
    if (value == null || value.isEmpty) {
      return "This field is required";
    }

    if (value.length < 4) {
      return "The password must be longer than 4 characters";
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Rendu Flutter"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FractionallySizedBox(
                  widthFactor: .75,
                  child: Image.asset(
                    "assets/profile.png",
                  ),
                ),
                TextFormField(
                  controller: _usernameController,
                  validator: isUsernameValid,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    labelText: "Username",
                  ),
                ),
                const Gap(16),
                TextFormField(
                  obscureText: true,
                  controller: _passwordController,
                  validator: isPasswordValid,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.lock),
                    labelText: "Password",
                  ),
                ),
                const Gap(16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: onCreatePressed(context),
                        child: const Text("Register"),
                      ),
                    ),
                    const Gap(16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: onUpdatePressed,
                        child: const Text("Login"),
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
