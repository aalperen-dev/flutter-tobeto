class BlogModel {
  String? id;
  String? title;
  String? content;
  String? thumbnail;
  String? author;
  BlogModel({
    this.id,
    this.title,
    this.content,
    this.thumbnail,
    this.author,
  });

  BlogModel copyWith({
    String? id,
    String? title,
    String? content,
    String? thumbnail,
    String? author,
  }) {
    return BlogModel(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      thumbnail: thumbnail ?? this.thumbnail,
      author: author ?? this.author,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'thumbnail': thumbnail,
      'author': author,
    };
  }

  factory BlogModel.fromMap(Map<String, dynamic> map) {
    return BlogModel(
      id: map['id'],
      title: map['title'],
      content: map['content'],
      thumbnail: map['thumbnail'],
      author: map['author'],
    );
  }
}
