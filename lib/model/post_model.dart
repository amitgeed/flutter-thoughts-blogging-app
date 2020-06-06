class Post {
  final String postedBy;
  final String postDate;
  final String postTime;
  final String postText;
  final int likes;

  Post({
    this.likes,
    this.postDate,
    this.postText,
    this.postTime,
    this.postedBy,
  });

  factory Post.fromMap(Map<String, dynamic> data) {
    return Post(
      likes: data['likes'],
      postDate: data['date'],
      postText: data['posText'],
      postTime: data['time'],
      postedBy: data['sender'],
    );
  }
}
