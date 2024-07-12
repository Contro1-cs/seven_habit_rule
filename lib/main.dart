import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:seven_habit_rule/modules/home/screens/bot_nav_bar.dart';
import 'package:seven_habit_rule/modules/onboarding/screens/login.dart';
import 'package:seven_habit_rule/modules/shared/widgets/colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool loggedIn = false;
  Future.wait([Firebase.initializeApp(), dotenv.load(fileName: ".env")])
      .then((value) {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        loggedIn = false;
      } else {
        loggedIn = true;
      }
    });
  });

  runApp(MyApp(loggedIn: loggedIn));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.loggedIn});
  final bool loggedIn;
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: '7 Habit rule',
        theme: ThemeData(
          fontFamily: 'RG',
          colorScheme: ColorScheme.fromSeed(
              seedColor: CustomColors.darkBlue, background: CustomColors.white),
          useMaterial3: true,
        ),
        home: loggedIn ? const LoginScreen() : const BotNavBar(),
      ),
    );
  }
}
