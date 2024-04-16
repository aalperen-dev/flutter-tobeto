part of 'blog_bloc.dart';

@immutable
sealed class BlogEvent {}

final class FetchBlogs extends BlogEvent {}

final class AddBlog extends BlogEvent {}

final class RemoveBlog extends BlogEvent {
  final String postId;

  RemoveBlog({required this.postId});
}
