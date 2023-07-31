import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_threads/home_page.dart';
import 'utils.dart';
import 'package:intl/date_time_patterns.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({Key? key}) : super(key: key);

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  bool isEmailVerified = false;
  Timer? timer;
  bool canResendEmail = false;

  @override
  void initState() {
    super.initState();

    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isEmailVerified) {
      sendVerificationEmail();

      timer = Timer.periodic(
        Duration(seconds: 3),
        (_) => checkEmailVerified(),
      );
    }
  }

  @override
  void dispose() {
    timer?.cancel();

    super.dispose();
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isEmailVerified) timer?.cancel();
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      await user!.sendEmailVerification();

      setState(() {
        canResendEmail = false;
      });
      await Future.delayed(Duration(seconds: 5));
      setState(() {
        canResendEmail=true;
      });

    } catch (e) {
      showDialog(context: context, builder: (context) {
        return Dialog(child:Text(e.toString()));
      },);
    }
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? HomePage() //the place where we land 
      : Scaffold(
          appBar: AppBar(
            title: Text('Verify Email'),
            backgroundColor:  Color.fromARGB(255, 17, 64, 103),
          ),
          body: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'A verification email has been sent to your email',
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 24,
                ),
                ElevatedButton.icon(
                  onPressed: sendVerificationEmail,
                  icon: Icon(
                    Icons.email,
                    size: 32,
                  ),
                  label: Text(
                    'Resent Email',
                    style: TextStyle(fontSize: 24),
                  ),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(50),
                    backgroundColor:  Color.fromARGB(255, 17, 64, 103),
                  ),
                ),
                SizedBox(height: 8,),
                TextButton(onPressed: () =>FirebaseAuth.instance.signOut(), child:
                Text('Cancel' , style: TextStyle(fontSize: 24 , color:  Color.fromARGB(255, 17, 64, 103)),),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(50),
                ),)
              ],
            ),
          ),
        );
}
