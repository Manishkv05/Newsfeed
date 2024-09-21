import 'package:flutter/material.dart';
import 'package:newsfeed/provider/favprovider.dart';
import 'package:newsfeed/ui/homescreen.dart';
import 'package:provider/provider.dart';

void main() {

  runApp(
      MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => favListProvider()),
      ],child:const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      title: 'NewsFeed',
      theme: ThemeData(
    
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}
