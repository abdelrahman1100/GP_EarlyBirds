class news_model {
  String id;
  String? url;
  String? title;
  String? image;
  String? content;
  String? author;
  String? date;
  int likes = 0;
  int comments = 0;
  bool isLiked = false;
  news_model(
      {required this.id, this.title,  this.image,  this.content, required this.likes, required this.comments, required this.isLiked, this.author, this.date, this.url});

}