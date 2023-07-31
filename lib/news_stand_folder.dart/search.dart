import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:news_threads/home_folder.dart/news_view.dart';
class Search extends StatefulWidget {
  @override
  Search({key});
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
 
  List<dynamic> _searchResults = [];
  
  void _performSearch(String query) {
   searchNews(query).then((results) {
     List<dynamic> filteredList = [];
    
      for (var source in results) {
        if (source['title'] != null &&
            source['description'] != null
           &&
            source['urlToImage'] != null&&
           source['url'] != null
          ) {
          filteredList.add(source);
        }
      }
      setState(() {
        _searchResults = filteredList;
      });
    }).catchError((error) {
      print('Error: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        
        body: Padding(
          padding: const EdgeInsets.fromLTRB(8.0,8.0,8,8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Search for any news\nFind 500+ news articles in seconds' ,style: TextStyle(color:  Colors.grey.shade500 , ),
                textAlign: TextAlign.left,),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Colors.grey.shade200)),
                    

                    labelText: 'Search News ',
                    prefixIcon: Icon(Icons.search),

                  ),
                  onChanged: (value) {
                    _performSearch(value);
                  },
                ),
              ),
              SizedBox(height: 30,),

              
              Expanded(
                
                child: ListView.builder(
                  
                  itemCount: _searchResults.length,
                  itemBuilder: (context, index) {
                    final article = _searchResults[index];
                    return GestureDetector(
                      onTap: () {
                         Navigator.push(context,MaterialPageRoute(builder: ((context) 
                => NewsView(url:article['url']))));
                      },
                      child: Container(
                        height: 100,
                        child: ListTile(
                          leading:Image.network(article['urlToImage'] , height: 100,
                          width: 60,fit: BoxFit.fill,),
                          title: Text(article['title'],maxLines: 2,),
                          subtitle: Text(article['description'] ,maxLines: 2),
                        ),
                      ),
                    );
                  },
                ),
              ),

            ],
          ),
        ),
      );
    
  }
  Future<List<dynamic>> searchNews(String query) async {
    final url =
        'https://newsapi.org/v2/everything?q=$query&sortBy=relevance&apiKey=5ced74cd44b84d9cbd7e4bac32259a3a';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
   
      return result['articles'];
    } else {
      throw Exception('Failed to search news');
    }
  }
}

