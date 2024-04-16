import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_blog/repositories/blog_repository.dart';
import '../../models/blog_model.dart';
import 'package:http/http.dart' as http;

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
    on<FetchBlogs>((event, emit) async {
      emit(BlogLoading());
      try {
        final blogs = await blogRepository.fetchAllBlogs();
        emit(BlogLoaded(blogs: blogs));
      } catch (e) {
        emit(BlogLoadFailed());
      }
    });

    // post silme
    on<RemoveBlog>((event, emit) async {
      try {
        Uri url = Uri.parse(
            "https://tobetoapi.halitkalayci.com/api/Articles/${event.postId}");
        final http.Response response = await http.delete(url);

        if (response.statusCode == 200) {
          print('başarılı');
        } else {}
      } catch (e) {}
    });
  }
}
