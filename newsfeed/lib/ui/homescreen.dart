
import 'package:flutter/material.dart';
import 'package:newsfeed/models/thewallstreetjournalmodel.dart';
import 'package:newsfeed/services/the-wall-street-journal-services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});



  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
    late Future<NewsResponse> futureNews;
  Thewallstreetjournal thewallstreetjournal=Thewallstreetjournal();
    bool showAddToFavorites = false;
  int? selectedArticleIndex;
    bool onLongPress = false;
    bool isnews=true;
    bool isfav=false;
    List<int> favindex=[];
      List<int> favindex1=[];

@override
  void initState() {
    futureNews = thewallstreetjournal.fetchdata();
   
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 218, 237, 241).withOpacity(0.95),
      appBar: AppBar(
        
      
          backgroundColor: Color.fromARGB(255, 218, 237, 241).withOpacity(0.95),
        actions:[
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: (){
                    setState(() {
                      isfav=false;
                      isnews=true;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width*0.4,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                      color: isnews?Color.fromARGB(255, 189, 233, 242): Color.fromARGB(255, 218, 237, 241).withOpacity(0.95)),
                      child:Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(children: [
                           SizedBox(width: 10,),
                        const  Icon(Icons.menu, color: Colors.black,size: 28,),
                        SizedBox(width: 10,),
                          Text('News',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 23),)
                                      ],),
                      )),
                  ),
                ),
                 GestureDetector(
                  onTap: (){
                    setState(() {
                      isnews=false;
                      isfav=true;
                    });
                  },
                   child: Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 10.0),
                     child: Container(
                          width: MediaQuery.of(context).size.width*0.4,
                         decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                           color: isfav?Color.fromARGB(255, 189, 233, 242): Color.fromARGB(255, 218, 237, 241).withOpacity(0.95),),
                      child:Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(children: [
                            SizedBox(width: 10,),
                          Icon(Icons.favorite, color: Colors.red,size: 28,),
                          SizedBox(width: 10,),
                          Text('Fav',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 23),)
                                      ],),
                      )),
                   ),
                 )
              ],
            ),
          )
        ]
      ),
      body: FutureBuilder<NewsResponse>(
        future: futureNews,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData) {
            return Center(child: Text("No news available"));
          }

          final articles = snapshot.data!.articles;
          
       return isnews?
           ListView.builder(
            itemCount: articles.length,
            itemBuilder: (context, index) {
              final article = articles[index];
              return cards(article,index);
            },
          ):!favindex.isEmpty? ListView.builder(
            itemCount: favindex.length,
            itemBuilder: (context,favindex ) {
              final article = articles[favindex];
              return cards(article,favindex);
            },
          ):Center(child: Text('You dont have any Favorite News',style: TextStyle(color: Colors.blueAccent),));
        },
      ),
    );
    }

cards(article, index) {

  return GestureDetector(
    onDoubleTap: () {
      print('Double tap detected');
    },
    onLongPress: () {
      setState(() {
       toggleAddToFavorites(index);
        onLongPress = true;
        print('onLongPress: true');
      });
      // Automatically hide the option after 4 seconds
      Future.delayed(Duration(seconds: 3), () {
        setState(() {
          onLongPress = false;
          print('onLongPress: false');
        });
      });
    },
    child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Stack(
        children: [
          
          // Main content (article image, title, description)
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  offset: const Offset(6, 6),
                  blurRadius: 8,
                ),
                BoxShadow(
                  color: Colors.white.withOpacity(0.8),
                  offset: const Offset(-4, -4),
                  blurRadius: 8,
                ),
              ],
            ),
            child: Expanded(
              child: Row(
                children: [
                  // Article image
                  article.urlToImage.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0,horizontal: 6),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              article.urlToImage,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      : SizedBox.shrink(),
                  SizedBox(width: 10), // Spacing between image and text
              
                  // Article title and description
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            article.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 5),
                          Text(
                            article.description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 5,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                             children: [
                              
                               Icon(Icons.calendar_month, color: Colors.grey,size: 20,),
                               SizedBox(width: 10,),
                               Text(article.publishedAt,style: TextStyle(color: Colors.grey, overflow: TextOverflow.ellipsis,fontSize: 12),),
                             ]
                          )
                        
                        ],
                      ),
                    ),
                  ),
                     if(selectedArticleIndex==index)
                     onLongPress?
                        // Sliding "Add to Favorites" section
                        AnimatedPositioned(
              duration: Duration(milliseconds: 600),
              right: onLongPress ? 0 : -100, // Slide in from the right
              top: 0,
              bottom: 0,
              child: GestureDetector(
                onTap: () {
              
                        // Add to favorite functionality
                        print('Added to favorites');
                         setState(() {
                      favindex.contains(selectedArticleIndex)? favindex.remove(selectedArticleIndex): favindex.add(selectedArticleIndex!);
                        
                        });
                      },
                child: Container(
                  width: 100,
                  height: 140,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 246, 26, 10).withOpacity(0.6),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.favorite, color:favindex.contains(selectedArticleIndex)? Colors.red:Colors.white,size: 25,),
                      
                        Center(
                          child: Text(!isfav?
                            "Add to\nFavorite":'Remove\n Favorite',
                            style: TextStyle(color: Colors.black, fontSize: 12,fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
                        ):SizedBox.shrink()
                ],
              ),
            ),
          ),
 
        ],
      ),
    ),
  );
}


    
      void toggleAddToFavorites(int index) {
    setState(() {
      selectedArticleIndex = index;
     showAddToFavorites = !showAddToFavorites;
    });
  }
   
      }
         
