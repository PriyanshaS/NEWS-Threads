import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_threads/home_folder.dart/news_view.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Sliders extends StatefulWidget {
  @override
  State<Sliders> createState() => _SlidersState();
}

class _SlidersState extends State<Sliders> {
@override
 List newsList=[];
 void initState() {
    ApiNews();
    super.initState();
  }
Widget build(BuildContext context) {
	return  ListView(
		children: [
		CarouselSlider(

			items: newsList.length>0 ? [
        
				GestureDetector(
                  onTap: () {
                    Navigator.push(context,MaterialPageRoute(builder: ((context) 
              => NewsView(url:newsList[0]['url']))));
                  },
                  
                  child: Container(
                
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                    image: NetworkImage(newsList[0]['urlToImage']),
                    fit: BoxFit.cover,
                    ),
                  ),
            
                  ),
                ),
				
				//2nd Image of Slider
				GestureDetector(
                  onTap: () {
                    Navigator.push(context,MaterialPageRoute(builder: ((context) 
              => NewsView(url:newsList[1]['url']))));
                  },
                  child: Container(
              
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                    image: NetworkImage(newsList[1]['urlToImage']),
                    fit: BoxFit.cover,
                    ),
                  ),
            
                  ),
                ),
				
				
				//3rd Image of Slider
			GestureDetector(
                  onTap: () {
                    Navigator.push(context,MaterialPageRoute(builder: ((context) 
              => NewsView(url:newsList[2]['url']))));
                  },
                  child: Container(
              
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                    image: NetworkImage(newsList[2]['urlToImage']),
                    fit: BoxFit.cover,
                    ),
                  ),
            
                  ),
                ),
				
				
				//4th Image of Slider
			GestureDetector(
                  onTap: () {
                    Navigator.push(context,MaterialPageRoute(builder: ((context) 
              => NewsView(url:newsList[3]['url']))));
                  },
                  child: Container(
              
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                    image: NetworkImage(newsList[3]['urlToImage']),
                    fit: BoxFit.cover,
                    ),
                  ),
            
                  ),
                ),
				
				
				//5th Image of Slider
				GestureDetector(
                  onTap: () {
                    Navigator.push(context,MaterialPageRoute(builder: ((context) 
              => NewsView(url:newsList[4]['url']))));
                  },
                  child: Container(
              
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                    image: NetworkImage(newsList[4]['urlToImage']),
                    fit: BoxFit.cover,
                    ),
                  ),
            
                  ),
                ),
				
		]: [SizedBox(
            height: 30, // Set the desired height
            
          ),],
			
			//Slider Container properties
			options: CarouselOptions(
				height: 180.0,
				enlargeCenterPage: true,
				autoPlay: true,
				aspectRatio: 16 / 9,
				autoPlayCurve: Curves.fastOutSlowIn,
				enableInfiniteScroll: true,
				autoPlayAnimationDuration: Duration(milliseconds: 800),
				viewportFraction: 0.8,
			),
		),
		],
	);
}

  Future <void> ApiNews() async{
    
    const url ='https://newsapi.org/v2/top-headlines?country=us&apiKey=5ced74cd44b84d9cbd7e4bac32259a3a';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if(response.statusCode==200)
    {
    final json = jsonDecode(response.body);
    final articles = json['articles'];
     List<dynamic> filteredList = [];

      for (var source in articles) {
        if (source['title'] != null &&
           source['urlToImage'] != null &&
            source['description'] != null &&
           source['url'] != null
          ) {
          filteredList.add(source);
        }
      }
    
    setState(() {
      newsList= filteredList;
    });
   }
   
    
    }
}
