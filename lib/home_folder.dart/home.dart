import 'package:flutter/material.dart';
import 'package:news_threads/home_folder.dart/news_card.dart';
import 'package:news_threads/home_folder.dart/slider.dart';

class Home extends StatelessWidget {
   Home({key}); 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 30,),
            SizedBox(
              height: 210,
             child: Sliders(),
            ),
            Text('HEADLINES' , style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold) ,textAlign: TextAlign.left,),
            Flexible(
             
              child: NewsCard()),
          ],
        ),
      ));
  }
}