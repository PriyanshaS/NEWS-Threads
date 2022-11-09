import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';


class MyWidget extends StatelessWidget {
  MyWidget({Key? key}) : super(key: key);
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/img.jpg'),fit: BoxFit.cover),),
      child: 
      
      Column(
        children: [
          SizedBox(height: 40,), 
           Card(
            color: Colors.black.withOpacity(4),
           child: Form(child: TextFormField(
                      controller: emailController,
                      cursorColor: Colors.black,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(labelText:'Email'),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator:(email) {
                        if(email !=  null && !EmailValidator.validate(email))
                        return 'Enter a valid email';
                        else
                        return null;
                      }
                      
                    ),),
           )
          ,
          ],
    ),);
  }
}