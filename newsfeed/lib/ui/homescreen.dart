
import 'package:flutter/material.dart';
import 'package:newsfeed/models/thewallstreetjournalmodel.dart';
import 'package:newsfeed/services/the-wall-street-journal-services.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});



  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  Thewallstreetjournal thewallstreetjournal=Thewallstreetjournal();

@override
  void initState() {
    // TODO: implement initState
 
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(
      
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      
        title: Text(widget.title),
      ),
      body: FutureBuilder (
        future:thewallstreetjournal.fetchdata(),
        builder:(context, snapshot)  {
         

          if(snapshot.connectionState==ConnectionState.waiting){
            return  CircularProgressIndicator();

          }
          else if(snapshot.connectionState==ConnectionState.done) {
            print(snapshot.data);
            return Text('hi');
           
          }return Text('no');
        }
        ,) 
    );
  }
}
