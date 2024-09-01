class articles{
  String author;
  String title;
  String description;
  String url;
  String imgurl;
  String publishedat;
  String content;
  articles({required this.author,
  required this.title,
  required this.description,
  required this.url,
  required this.imgurl,
  required this.publishedat,
  required this.content});


    factory articles.fromJson(Map<String, dynamic> json) {
    return articles(
      title: json['title']??'No title',
      author: json['author']??'no author data',
      description: json['description']??'no description data',
      url: json['url']??'no url avilable' ,
      imgurl: json['imgurl']??'',
      publishedat: json['publishedat']??'no published data',
      content: json['content']??'no content avilable',
   
    );
  }
  

}