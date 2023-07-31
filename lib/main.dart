import 'package:flutter/material.dart';
import 'package:news_threads/auth.dart/auth_page.dart';
import 'package:news_threads/auth.dart/verify_email.dart';
import 'package:news_threads/category.dart/business.dart';
import 'package:news_threads/category.dart/general.dart';
import 'package:news_threads/category.dart/health.dart';
import 'package:news_threads/category.dart/science.dart';
import 'package:news_threads/category.dart/sports.dart';
import 'package:news_threads/category.dart/technology.dart';
import 'package:news_threads/home_folder.dart/home.dart';
import 'package:news_threads/news_stand_folder.dart/news_stand.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_core/firebase_core.dart';
Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MyApp());
}
  final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}
class MyHomePage extends StatelessWidget {
   MyHomePage({ Key? key }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot){
          if(snapshot.connectionState==ConnectionState.waiting)
          return Center(child: CircularProgressIndicator(),);
          else if(snapshot.hasError){
            return Center(child: Text('Something went wrong'),);
          }
          else if(snapshot.hasData)
          {return VerifyEmail();}
          else
          {return 
          AuthPage();
         
          }
        },
      ),
    );}}

