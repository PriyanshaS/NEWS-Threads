import 'package:flutter/material.dart';
import 'package:news_threads/category.dart/business.dart';
import 'package:news_threads/category.dart/general.dart';
import 'package:news_threads/category.dart/health.dart';
import 'package:news_threads/category.dart/science.dart';
import 'package:news_threads/category.dart/sports.dart';
import 'package:news_threads/category.dart/technology.dart';
import 'package:news_threads/home_folder.dart/home.dart';
import 'package:news_threads/news_stand_folder.dart/news_stand.dart';
import 'package:firebase_auth/firebase_auth.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {
  int _currentIndex=0;
 List _children =[
  Home(),
  NewsStand(),
 ]; 
 void onTabbed(int index){
  setState(() {
    _currentIndex = index;
  });
 }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        title: Text("News App", style: TextStyle(color: Colors.white)),
        backgroundColor: Color.fromARGB(255, 17, 64, 103),
      ),
      drawer: Drawer(
       child: ListView(
       
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
             color: Color.fromARGB(255, 17, 64, 103),
            ),
            child: Text('NEWS App',
            style: TextStyle(color: Colors.white),
            ),
            
          ),
          
          ListTile(
            leading: Icon(
              Icons.business,
            ),
            title: const Text('BUSINESS'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Business(),));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.newspaper,
            ),
            title: const Text('GENERAL'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => General(),));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.health_and_safety,
            ),
            title: const Text('HEALTH'),
            onTap: () {
             Navigator.push(context, MaterialPageRoute(builder: (context) => Health(),));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.science,
            ),
            title: const Text('SCIENCE'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Science(),));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.sports_cricket,
            ),
            title: const Text('SPORTS'),
            onTap: () {
             Navigator.push(context, MaterialPageRoute(builder: (context) => Sports(),));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.computer,
            ),
            title: const Text('TECHNOLOGY'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Technology(),));
            },
          ),
           SizedBox(height: 260,),
           
     Center(
       child: GestureDetector(
              onTap: () => FirebaseAuth.instance.signOut(),
              child: Container(
                height: 50,
                width:  100,   
                decoration: BoxDecoration(color: Colors.grey[200]),          
                child: Center(
                  child: Text('Log Out' ,style: TextStyle(color: Colors.black , backgroundColor: Colors.grey[200]
                  ),
            
                  ),
                ),
              )),
     ),

        
         
        ],
      ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap:onTabbed,
        items: [
         BottomNavigationBarItem(icon: Icon(Icons.home) , label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.newspaper) , label: 'News Stand'),]),
      body:_children[_currentIndex] ,
    );
  }
}
