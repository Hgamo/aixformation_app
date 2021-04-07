class Comment {
  int id;
  int postId;
  String authorName;
  String content;
  String link;
  DateTime date;

  Comment({
    this.id,
    this.postId,
    this.authorName,
    this.content,
    this.link,
    this.date,
  });

  factory Comment.formMap(Map<String, dynamic> map) {
    return Comment(
      id: map['id'],
      postId: map['post'],
      authorName: map['author_name'],
      content: map['content']['rendered'],
      link: map['link'],
      date: DateTime.parse(map['date']),
    );
  }
}
