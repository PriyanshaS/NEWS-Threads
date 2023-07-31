import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../main.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'utils.dart';
class Signup extends StatefulWidget {
  const Signup({Key? key, required this.onClickedSignUp}) : super(key: key);
  final VoidCallback onClickedSignUp;


  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
   final TextEditingController nameController = TextEditingController();
   String name = '';
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Container(),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        scrollDirection:Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15 , 15, 15, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20,),
              Text('WELCOME' , textAlign:TextAlign.left,style: TextStyle(fontSize:22),),
                          SizedBox(height: 10,),
      
              Text('Find Relevant News And Explore' , style: TextStyle(fontSize: 14) ),
                            SizedBox(height: 20,),

              Container(
                height: 600,
                child: Form(
      
                  key: formKey,
                  child: Column(
                    children: [
                      SizedBox(height: 20,),
                       TextFormField(
                        controller: nameController,
                        cursorColor: Colors.white,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(labelText:'Name' , border: OutlineInputBorder()),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if(value!.isEmpty)
                          return 'Enter a name';
                          else
                          return null;
                        },
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        controller: emailController,
                        cursorColor: Colors.white,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(labelText:'Email' , border: OutlineInputBorder()),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator:(email) {
                          if(email !=  null && !EmailValidator.validate(email))
                          return 'Enter a valid email';
                          else
                          return null;
                        }
                        
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        controller: passwordController,
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(labelText:'Password',border: OutlineInputBorder()),
                        obscureText: true,
                        validator: (value) {
                          if(value != null && value.length <6)
                          {  return 'Enter min. 6 characters';
                      }
                          else
                          {return null;}
                        },
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      ElevatedButton.icon(
                        onPressed: signUp,
                        icon: Icon(
                          Icons.lock_open,
                          size: 32,
                        ),
                        label: Text(
                          'Sign In',
                          style: TextStyle(fontSize: 24),
                        ),
                        style: ElevatedButton.styleFrom(minimumSize: Size.fromHeight(50),backgroundColor: Color.fromRGBO(17, 64, 103, 1),),
                      ),


                      
                      SizedBox(
                        height: 24,
                      ),



                      RichText(
                          text: TextSpan(
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                              text: 'Already a user?  ',
                              children: [
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = widget.onClickedSignUp,
                              text: 'LogIn',
                              style: TextStyle(
                                decorationStyle: TextDecorationStyle.double,
                                  color: Color.fromARGB(255, 17, 64, 103),
                            ))
                          ]))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      
    );
  }

  Future signUp() async {
    setState(() {
      name= nameController.text;
    });
    
    final isValid = formKey.currentState!.validate();
    if(!isValid)
    return ;

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(child: CircularProgressIndicator()));
    UserCredential ?userCredential;
    try {
       userCredential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
    } 
    
    on FirebaseAuthException catch (e) {
      print(e);
      Utils.showSnackBar(e.message);
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
     await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential!.user!.uid)
          .set({
        'name': nameController.text.trim(),
        'email': emailController.text.trim(),
      });
  }
}
