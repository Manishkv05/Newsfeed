import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:newsfeed/models/thewallstreetjournalmodel.dart';

class Thewallstreetjournal{
  Future<NewsResponse> fetchdata() async{
    
    final apiUrl=Uri.parse('https://newsapi.org/v2/everything?domains=wsj.com&apiKey=d2d971f38ef04752bf8888fde368eecf');
       try {
      final response = await http.get(apiUrl);
     
        
        if (response.statusCode == 200) {
      return NewsResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load news');
    }
      
    } catch (e) {
      throw Exception('Error fetching courses: $e');
    }
  }
}