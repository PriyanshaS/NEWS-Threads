import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      body: Center(
        child: Padding(padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Signed In As',
            style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8,),
            Text(
              user.email! , 
              style: TextStyle(fontSize: 20, fontWeight:FontWeight.bold),

            ),
            SizedBox(height: 40,),
            ElevatedButton.icon(onPressed: () => FirebaseAuth.instance.signOut(), icon: Icon(Icons.arrow_back,size:32), label: Text('Sign Out', style:TextStyle(fontSize:24)))
          ],
        ),),
      ),
    );
  }
}