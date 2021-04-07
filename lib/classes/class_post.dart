class Post {
  String contentHtml;
  String featuredMedia;
  String title;
  String excerptHtml;
  int id;
  DateTime date;
  String link;
  int authorId;
  List<int> categoriesId;

  Post({
    this.categoriesId,
    this.authorId,
    this.title,
    this.id,
    this.date,
    this.link,
    this.featuredMedia,
    this.contentHtml,
    this.excerptHtml,
  });
}
