part of 'blog_bloc.dart';

@immutable
sealed class BlogState {}

// data çekme
class BlogNotLoaded extends BlogState {}

class BlogLoading extends BlogState {}

class BlogLoaded extends BlogState {
  final List<BlogModel> blogs;
  BlogLoaded({
    required this.blogs,
  });
}

class BlogLoadFailed extends BlogState {}

// blog silme

class DeleteBlogSuccess extends BlogState {}

class DeleteBlogFailed extends BlogState {}

// blog ekleme

class AddBlogSuccess extends BlogState {}

class AddBlogFailed extends BlogState {}

// blog update

class UpdateBlogSuccess extends BlogState {}

class UpdateBlogFailed extends BlogState {}
