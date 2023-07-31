import 'package:flutter/material.dart';
import 'package:news_threads/home_folder.dart/news_card.dart';
import 'package:news_threads/news_stand_folder.dart/search.dart';

class NewsStand extends StatefulWidget {
   NewsStand({key}); 

  @override
  State<NewsStand> createState() => _NewsStandState();
}

class _NewsStandState extends State<NewsStand> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Search());
  }
}