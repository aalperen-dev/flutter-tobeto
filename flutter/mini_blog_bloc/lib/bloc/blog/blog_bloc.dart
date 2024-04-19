import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_blog/repositories/blog_repository.dart';
import '../../models/blog_model.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  // repository çektik
  final BlogRepository blogRepository;

  //super'e temel state verilir.
  BlogBloc({
    required this.blogRepository,
  }) : super(BlogNotLoaded()) {
    // her bir event için on fonksiyonu yazılması lazım.

    // bütün datayı çekme
    on<FetchAllBlogs>((event, emit) async {
      emit(BlogLoading());
      try {
        final blogs = await blogRepository.fetchAllBlogs();
        emit(BlogLoaded(blogs: blogs));
      } catch (e) {
        emit(BlogLoadFailed());
      }
    });

    // post silme
    on<DeleteBlog>((event, emit) async {
      try {
        await blogRepository.deleteBlog(postId: event.postId);

        emit(DeleteBlogSuccess());
      } catch (e) {
        emit(DeleteBlogFailed());
      }
    });

    // blog ekleme
    on<AddBlog>((event, emit) async {
      try {
        await blogRepository.submitBlog(
          blogTitle: event.blogTitle,
          blogContent: event.blogContent,
          blogAuthor: event.blogAuthor,
          imagePath: event.imagePath,
        );

        emit(AddBlogSuccess());
      } catch (e) {
        emit(AddBlogFailed());
      }
    });

    // update blog
    on<UpdateBlog>((event, emit) async {
      try {
        await blogRepository.updateBlog(blogModel: event.blogModel);

        emit(UpdateBlogSuccess());
      } catch (e) {
        emit(UpdateBlogFailed());
      }
    });
  }
}
