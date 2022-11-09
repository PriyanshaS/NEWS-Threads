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
      body: Padding(padding: EdgeInsets.all(16),
      child: Form(key: formKey,child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Recieve an email to\nreset your password',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24),

          ),
          SizedBox(height: 20,),
          TextFormField(
            controller: emailController,
            cursorColor: Colors.white,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(labelText: 'Email'),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (email)=>
            email!=null && !EmailValidator.validate(email) ? 
            'Enter a valid email' : null,
          ),
          SizedBox(height: 20,),
          ElevatedButton.icon(onPressed: resetPassword, icon: Icon(Icons.email_outlined), label:Text('Reset Password' , style: TextStyle(
            fontSize: 24
          ),
          ),
          ),
        ],
      ),)
      ,
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