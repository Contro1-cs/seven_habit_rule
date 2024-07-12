import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:seven_habit_rule/modules/onboarding/screens/onboarding.dart';
import 'package:seven_habit_rule/modules/home/screens/home_screen.dart';
import 'package:seven_habit_rule/modules/shared/widgets/buttons.dart';
import 'package:seven_habit_rule/modules/shared/widgets/custom_textfield.dart';
import 'package:seven_habit_rule/modules/shared/widgets/snackbars.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  Future<void> signUpNewUser() async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: 'admin@admin.com', password: '123123')
        .then((response) {
      if (response.user != null) {
        print('User: ${response.user!.email}');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const UserOnboarding(),
          ),
        );
      }
    }).onError((FirebaseException exception, stackTrace) {
      errorSnackBar(context, exception.message);
      print('Error: ${exception.message}');
    });
  }

  Future<void> signInWithEmail() async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: 'admin@admin.com', password: '123123')
        .then((response) {
      if (response.user != null) {
        print('User: ${response.user!.email}');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
      }
    }).catchError((error) {
      try {
        signUpNewUser();
      } catch (e) {
        print('Error: $error');
        errorSnackBar(context, error.toString());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      "Sign in",
                      style:
                          TextStyle(fontSize: 64, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "It’s time for you to realize you are the main character of your story!",
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.normal),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Column(
                        children: [
                          CustomTextField(
                            label: 'Email',
                            textInputType: TextInputType.emailAddress,
                            controller: _emailController,
                          ),
                          CustomTextField(
                            label: 'Password',
                            textInputType: TextInputType.visiblePassword,
                            controller: _passwordController,
                            obscureText: true,
                          ),
                        ],
                      ),
                    ),
                    const Expanded(child: SizedBox(height: 40)),
                    GeneralButton(
                      onPressed: () {
                        HapticFeedback.vibrate();
                        // _googleSignIn();
                        signInWithEmail();
                      },
                      icon: SvgPicture.asset(
                        'assets/icons/login.svg',
                        height: 20,
                        width: 20,
                      ),
                      title: 'Sign in',
                    ),
                    const SizedBox(height: 10)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
