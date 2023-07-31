import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'utils.dart';
class ForgotPassword extends StatefulWidget {
  const ForgotPassword({ Key? key }) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
final formKey = GlobalKey<FormState>();
final emailController = TextEditingController();

@override
void dispose(){
  emailController.dispose();
  super.dispose();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(padding: EdgeInsets.all(16),
        child: Center(
          child: Form(key: formKey,child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Text(
                'Receive an email to\nreset your password',
               
                style: TextStyle(fontSize: 24),
      
              ),
              SizedBox(height: 20,),
              Container(
                width: 350,
                child: TextFormField(
                  
                  controller: emailController,
                  cursorColor: Colors.white,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(labelText: 'Email' , 
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (email)=>
                  email!=null && !EmailValidator.validate(email) ? 
                  'Enter a valid email' : null,
                ),
              ),
              SizedBox(height: 20,),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(backgroundColor:Color.fromARGB(255, 17, 64, 103) ),
                onPressed: resetPassword, icon: Icon(Icons.email_outlined), label:Text('Reset Password' , style: TextStyle(
                fontSize: 24
              ),
              ),
              ),
            ],
          ),),
        )
        ,
          ),
      )) ;
  }

  Future resetPassword() async{
    showDialog(context: context, builder: (context) => Center(child:CircularProgressIndicator() ,
    ), barrierDismissible: false,
    );
    try {
          await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text.trim());
          Utils.showSnackBar('Password Reset Email Sent');
          Navigator.of(context).popUntil((route) => route.isFirst);
          
    } on FirebaseAuthException catch (e) {
      print(e);
      Utils.showSnackBar(e.message);
      Navigator.of(context).pop();
    }
  }
}