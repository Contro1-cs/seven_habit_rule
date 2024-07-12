import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:seven_habit_rule/modules/onboarding/screens/login.dart';
import 'package:seven_habit_rule/modules/shared/widgets/colors.dart';
import 'package:seven_habit_rule/modules/shared/widgets/custom_textfield.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController goalController = TextEditingController();

  getProfileData() {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance.collection('users').doc(uid).get().then((value) {
      if (value.exists) {
        nameController.text = value['name'];
        goalController.text = value['goal'];
      }
    });
  }

  updateProfileData() {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance.collection('users').doc(uid).get().then((doc) {
      if (doc.exists) {
        FirebaseFirestore.instance.collection('users').doc(uid).update({
          "name": nameController.text.trim(),
          "goal": goalController.text.trim()
        });
      } else {
        FirebaseFirestore.instance.collection('users').doc(uid).set({
          "name": nameController.text.trim(),
          "goal": goalController.text.trim()
        });
      }
    });
  } 

  @override
  void initState() {
    getProfileData();
    super.initState();
  }

  @override
  void dispose() {
    updateProfileData();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut().then((value) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              });
            },
            icon: Icon(
              Icons.logout_rounded,
              color: CustomColors.red,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            CustomTextField(
              controller: nameController,
              label: 'Name',
              hintText: 'Enter your name',
            ),
            CustomTextField(
              controller: goalController,
              label: 'Goal',
              hintText: 'What is your aim for the next 6 months?',
              maxLines: 5,
            ),
          ],
        ),
      ),
    );
  }
}
