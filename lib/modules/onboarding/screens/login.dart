import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:seven_habit_rule/modules/shared/screens/home_screen.dart';
import 'package:seven_habit_rule/modules/shared/widgets/buttons.dart';
import 'package:seven_habit_rule/modules/shared/widgets/custom_textfield.dart';
import 'package:seven_habit_rule/modules/shared/widgets/snackbars.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  var supabase = Supabase.instance.client;
  Future<void> signUpNewUser() async {
    await supabase.auth
        .signUp(email: 'admin1@admin.com', password: '123123')
        .then((AuthResponse response) {
      if (response.user != null) {
        print('User: ${response.user!.email}');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
      }
    }).onError((AuthException exception, stackTrace) {
      errorSnackBar(context, exception.message);
      print('Error: ${exception.message}');
    });
  }

  Future<void> signInWithEmail() async {
    await supabase.auth
        .signInWithPassword(email: 'admin1@admin.com', password: '123123')
        .then((AuthResponse response) {
      if (response.user != null) {
        print('User: ${response.user!.email}');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
      }
    }).onError((AuthException exception, stackTrace) {
      if (exception.message == 'Invalid login credentials') {
        signUpNewUser();
      }
      print('Error: ${exception.message}');
    });
  }

  Future<AuthResponse> _googleSignIn() async {
    const iosClientId =
        '888922130843-n8n809latvluvtf8edg9fq91hum0m855.apps.googleusercontent.com';

    final GoogleSignIn googleSignIn = GoogleSignIn(
      clientId: iosClientId,
    );
    final googleUser = await googleSignIn.signIn();
    final googleAuth = await googleUser!.authentication;
    final accessToken = googleAuth.accessToken;
    final idToken = googleAuth.idToken;

    if (accessToken == null) {
      throw 'No Access Token found.';
    }
    if (idToken == null) {
      throw 'No ID Token found.';
    }

    return supabase.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: accessToken,
    );
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
