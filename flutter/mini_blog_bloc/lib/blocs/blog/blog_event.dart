part of 'blog_bloc.dart';

@immutable
sealed class BlogEvent {}

final class FetchAllBlogs extends BlogEvent {}

// blog silme
final class DeleteBlog extends BlogEvent {
  final String postId;

  DeleteBlog({required this.postId});
}

//  blog ekleme
final class AddBlog extends BlogEvent {
  final String blogTitle;
  final String blogContent;
  final String blogAuthor;
  final String imagePath;

  AddBlog({
    required this.blogTitle,
    required this.blogContent,
    required this.blogAuthor,
    required this.imagePath,
  });
}

// blog update
final class UpdateBlog extends BlogEvent {
  final BlogModel blogModel;

  UpdateBlog({required this.blogModel});
}
