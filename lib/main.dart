import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:seven_habit_rule/modules/onboarding/screens/login.dart';
import 'package:seven_habit_rule/modules/shared/widgets/colors.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");

  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON']!,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '7 Habit rule',
      theme: ThemeData(
        fontFamily: 'RG',
        colorScheme: ColorScheme.fromSeed(
            seedColor: CustomColors.darkBlue, background: CustomColors.white),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}
