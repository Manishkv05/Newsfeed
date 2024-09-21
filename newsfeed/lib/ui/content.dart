import 'package:flutter/material.dart';
import 'package:newsfeed/models/thewallstreetjournalmodel.dart';
import 'package:newsfeed/provider/favprovider.dart';
import 'package:newsfeed/ui/homescreen.dart';
import 'package:provider/provider.dart';

class Content extends StatefulWidget  {
  Article article;
  List<Article> favarticl;
   Content(BuildContext context, this.article, this.favarticl,  {super.key});

  @override
  State<Content> createState() => _ContentState();
}

 class _ContentState extends State<Content> {
  MyHomePage homes=MyHomePage();


  @override
  Widget build(BuildContext context) {
     final numberListProvider = Provider.of<favListProvider>(context);
    return  Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            children: [
             Stack(
               children:[ ClipRRect(
                 borderRadius: BorderRadius.circular(10),
                 child: Image.network(
                   widget.article.urlToImage,
                   width: MediaQuery.of(context).size.width*0.95,
                   height: MediaQuery.of(context).size.height*0.25,
                   fit: BoxFit.cover,
                 ),
               ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.favorite, color:numberListProvider.favarticl.contains(widget.article)? Colors.red:Colors.white,size: 25,),
                    ),
                  ],
                ),
               ]
             ),
             
              
             SizedBox(height: 10,),

                            Text(widget.article.title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                         
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                             children: [
                              
                               Icon(Icons.calendar_month, color: Colors.grey,size: 20,),
                               SizedBox(width: 10,),
                               Text(widget.article.publishedAt,style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontSize: 12),),
                             ]
                          ), 
                          SizedBox(height: 10,),Text(
                            widget.article.content,
                           style: TextStyle(fontWeight: FontWeight.bold),
                          ),
          ],),
        ),
      ),
    );
  }
}