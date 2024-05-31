import 'dart:convert';

class BlogModel {
  final String blogId;
  final String blogTitle;
  final String blogContent;
  final String blogThumbnailUrl;
  final String blogPictureUrl;
  final DateTime blogCreatedAt;
  BlogModel({
    required this.blogId,
    required this.blogTitle,
    required this.blogContent,
    required this.blogThumbnailUrl,
    required this.blogPictureUrl,
    required this.blogCreatedAt,
  });

  BlogModel copyWith({
    String? blogId,
    String? blogTitle,
    String? blogContent,
    String? blogThumbnailUrl,
    String? blogPictureUrl,
    DateTime? blogCreatedAt,
  }) {
    return BlogModel(
      blogId: blogId ?? this.blogId,
      blogTitle: blogTitle ?? this.blogTitle,
      blogContent: blogContent ?? this.blogContent,
      blogThumbnailUrl: blogThumbnailUrl ?? this.blogThumbnailUrl,
      blogPictureUrl: blogPictureUrl ?? this.blogPictureUrl,
      blogCreatedAt: blogCreatedAt ?? this.blogCreatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'blogId': blogId,
      'blogTitle': blogTitle,
      'blogContent': blogContent,
      'blogThumbnailUrl': blogThumbnailUrl,
      'blogPictureUrl': blogPictureUrl,
      'blogCreatedAt': blogCreatedAt.millisecondsSinceEpoch,
    };
  }

  factory BlogModel.fromMap(Map<String, dynamic> map) {
    return BlogModel(
      blogId: map['blogId'] ?? '',
      blogTitle: map['blogTitle'] ?? '',
      blogContent: map['blogContent'] ?? '',
      blogThumbnailUrl: map['blogThumbnailUrl'] ?? '',
      blogPictureUrl: map['blogPictureUrl'] ?? '',
      blogCreatedAt: DateTime.fromMillisecondsSinceEpoch(map['blogCreatedAt']),
    );
  }

  String toJson() => json.encode(toMap());

  factory BlogModel.fromJson(String source) =>
      BlogModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'BlogModel(blogId: $blogId, blogTitle: $blogTitle, blogContent: $blogContent, blogThumbnailUrl: $blogThumbnailUrl, blogPictureUrl: $blogPictureUrl, blogCreatedAt: $blogCreatedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BlogModel &&
        other.blogId == blogId &&
        other.blogTitle == blogTitle &&
        other.blogContent == blogContent &&
        other.blogThumbnailUrl == blogThumbnailUrl &&
        other.blogPictureUrl == blogPictureUrl &&
        other.blogCreatedAt == blogCreatedAt;
  }

  @override
  int get hashCode {
    return blogId.hashCode ^
        blogTitle.hashCode ^
        blogContent.hashCode ^
        blogThumbnailUrl.hashCode ^
        blogPictureUrl.hashCode ^
        blogCreatedAt.hashCode;
  }
}
