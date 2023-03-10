import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterdemo/controllers/signup_provider.dart';
import 'package:flutterdemo/screens/complete_profile/complete_profile.dart';
import 'package:flutterdemo/screens/home/home.dart';
import 'package:flutterdemo/screens/signup/widgets/social_card.dart';
import 'package:flutterdemo/screens/widgets/custom_button.dart';
import 'package:flutterdemo/screens/widgets/suffix_icon.dart';
import 'package:provider/provider.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  bool enabled = true;

  FirebaseAuth firebaseauth = FirebaseAuth.instance;

  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  TextEditingController controllerRePassword = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    bool passwordVisible = context.watch<SignupProvider>().passwordVisible;
    bool rePasswordVisible = context.watch<SignupProvider>().rePasswordVisible;

    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(13.0),
        child: Column(
          children: [
            TextFormField(
                decoration: InputDecoration(
                  labelText: "Email",
                  hintText: "Enter your email",
                  enabled: enabled,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  suffixIcon: SuffixIcon(icon: Icons.email),
                ),
                controller: controllerEmail,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  } else if (!RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
                autovalidateMode: AutovalidateMode.onUserInteraction),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: "Password",
                hintText: "Enter your password",
                enabled: enabled,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                suffixIcon: IconButton(
                  icon: Icon(passwordVisible
                      ? Icons.visibility
                      : Icons.visibility_off),
                  onPressed: () {
                    context.read<SignupProvider>().changePasswordVisible();
                  },
                ),
              ),
              controller: controllerPassword,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                } else if (value.length < 6) {
                  return 'Password should be at least 6 characters long';
                }
                return null;
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
              obscureText: !passwordVisible,
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: "Confirm Password",
                hintText: "Re-enter password",
                enabled: enabled,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                suffixIcon: IconButton(
                  icon: Icon(rePasswordVisible
                      ? Icons.visibility
                      : Icons.visibility_off),
                  onPressed: () {
                    context.read<SignupProvider>().changeRePasswordVisible();
                  },
                ),
              ),
              controller: controllerRePassword,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please re-enter your password';
                }
                if (value != controllerPassword.text) {
                  return 'Please make sure your passwords match';
                }
                return null;
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
              obscureText: !rePasswordVisible,
            ),
            SizedBox(
              height: 15,
            ),
            CustomButton(
                text: "Continue",
                pressed: () async {
                  if (_formKey.currentState!.validate()) {
                    try {
                      User? user = await context.read<SignupProvider>().signUp(
                          controllerEmail.text, controllerPassword.text);

                      if (user != null) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => CompleteProfile(user: user),
                          ),
                        );
                      }
                    } catch (e) {
                      print(e);
                    }
                  }
                }),
            SizedBox(height: 5),
            Text(
              'By continuing, you confirm that you agree \nwith our Terms and Conditions',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.caption,
            ),
            SizedBox(height: 15),
            Text(
              "or signin with",
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 15),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              SocialCard(
                icon: 'assets/icons/google-icon.svg',
                onPressed: () async {
                  UserCredential? user =
                      await context.read<SignupProvider>().googleLogin();

                  if (user!.additionalUserInfo!.isNewUser) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CompleteProfile(
                          user: user.user,
                        ),
                      ),
                    );
                  } else {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Home(),
                      ),
                    );
                  }
                },
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
