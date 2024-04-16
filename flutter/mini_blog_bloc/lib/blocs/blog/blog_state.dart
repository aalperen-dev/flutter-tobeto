part of 'blog_bloc.dart';

@immutable
sealed class BlogState {}

class BlogNotLoaded extends BlogState {}

class BlogLoading extends BlogState {}

class BlogLoaded extends BlogState {
  final List<BlogModel> blogs;

  BlogLoaded({
    required this.blogs,
  });
}

class BlogLoadFailed extends BlogState {}

class BlogRemove extends BlogState {}
