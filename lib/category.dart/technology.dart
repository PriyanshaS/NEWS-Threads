import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_threads/home_folder.dart/news_view.dart';
import 'package:webview_flutter/webview_flutter.dart';
class Technology extends StatefulWidget {
  Technology({key , String? value });
     String ? value;

   
  @override
  State<Technology> createState() => _TechnologyState();
}

class _TechnologyState extends State<Technology> {
 
 List newsList=[];
@override
  void initState() {
    ApiNews();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar:AppBar(
        
        centerTitle: true,
        title: Text("Technology News", style: TextStyle(color: Colors.white ,
        fontSize: 30),
        
        ),
        backgroundColor: Color.fromARGB(255, 17, 64, 103),
      ),
      body: ListView.builder(
        itemCount:newsList.length ,
        itemBuilder: (context, index) {
    
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context,MaterialPageRoute(builder: ((context) 
                => NewsView(url:newsList[index]['url']))));
              },
              child: Card(
                elevation: 0.5,
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(newsList[index]['urlToImage'],
                     height: 200 , width: 400, fit: BoxFit.cover),
                  ),
                  ListTile(title: Text(newsList[index]['title']),
                  subtitle: Text(newsList[index]['description']),)],),
                  ),
            ),
          );
        },
      ),
    )
    ;
  }

  Future <void> ApiNews() async{
   
    const url ='https://newsapi.org/v2/top-headlines?country=us&category=technology&apiKey=5ced74cd44b84d9cbd7e4bac32259a3a';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if(response.statusCode==200)
    {
    final json = jsonDecode(response.body);
    final articles = json['articles'];
      List<dynamic> filteredList = [];
      print(articles);
      for (var source in articles) {
        if (source['title'] != null &&
            source['description'] != null&&
            source['urlToImage'] != null&&
           source['url'] != null
          ) {
          filteredList.add(source);
        }
      }
      setState(() {
        newsList = filteredList;
      });

   }
    else{
      const CircularProgressIndicator(
        color:Color.fromARGB(255, 17, 64, 103),

      );
    }
    
    }
}