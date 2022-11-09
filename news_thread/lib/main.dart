import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:news_thread/test.dart';
import 'utils.dart';
import 'verify_email.dart';
import 'authpage.dart';
Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MyApp());
}
  final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: Utils.getKey(),
      navigatorKey: navigatorKey,
      title: 'Flutter Demo',
      
      theme: ThemeData.light(
      ),
      home:  MyHomePage(),
    );
  }
}


class MyHomePage extends StatelessWidget {
   MyHomePage({ Key? key }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('flutter_app_1')),
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
    );
  }
}