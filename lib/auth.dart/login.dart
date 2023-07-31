import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import '../main.dart';
import 'utils.dart';
import 'forgot_password.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Login extends StatefulWidget {
  const Login({Key? key, required this.onClickedSignUp}) : super(key: key);
  final VoidCallback onClickedSignUp;

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Future signIn() async {
    showDialog(
        context: context,
        builder: (context) => Center(child: CircularProgressIndicator()),
        barrierDismissible: false);

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      print(e);

      Utils.showSnackBar(e.message);
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15,15,15,0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Center(child: SvgPicture.asset('assets/images/top.svg' , height: 250,fit: BoxFit.cover,)),
               SizedBox(height: 20,),
               Text("WELCOME BACK", textAlign:TextAlign.left,style: TextStyle(fontSize:22), ),
                                         SizedBox(height: 40,),


              TextField(
                controller: emailController,
                cursorColor: Colors.white,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(labelText: 'Email',border: OutlineInputBorder()),
              ),
              SizedBox(height: 15),
              TextField(
                controller: passwordController,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(labelText: 'Password',border: OutlineInputBorder()),
                obscureText: true,
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton.icon(
                onPressed: signIn,
                icon: Icon(
                  Icons.lock_open,
                  size: 32,
                ),
                label: Text(
                  'Log In',
                  style: TextStyle(fontSize: 24,),
                ),
                style: ElevatedButton.styleFrom(minimumSize: Size.fromHeight(50),backgroundColor: Color.fromARGB(255, 17, 64, 103)),
              ),
              SizedBox(
                height: 24,
              ),
              GestureDetector(
                child: Center(
                  child: Text('Forgot Password? ',
                  style: TextStyle(
                    color:  Color.fromARGB(255, 17, 64, 103),
                    fontSize: 20,
                  ),
                  ),
                ),
                onTap: () =>Navigator.of(context).push(MaterialPageRoute(builder: (context) => 
                ForgotPassword(),)),
              )
      ,
      SizedBox(height: 5,),
              Center(
                child: RichText(
                    text:
                     TextSpan(
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                        text: 'No account?  ',
                        children: [
                      TextSpan(
      
                        recognizer: TapGestureRecognizer()..onTap =  widget.onClickedSignUp,      
                        text: 'Sign Up',
                        style: TextStyle(
                            color:  Color.fromARGB(255, 17, 64, 103)),
                      )
                    ])),
              )
            ],
          ),
        ),
      ),
    );
  }
}
