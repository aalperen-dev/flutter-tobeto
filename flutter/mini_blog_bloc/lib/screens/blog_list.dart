import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/blog/blog_bloc.dart';

class BlogList extends StatefulWidget {
  const BlogList({super.key});

  @override
  State<BlogList> createState() => _BlogListState();
}

class _BlogListState extends State<BlogList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlogBloc, BlogState>(
      builder: (context, state) {
        if (state is BlogNotLoaded) {
          // context üzerinden ilgili bloc okundu, ve yeni event gönderildi.
          context.read<BlogBloc>().add(FetchAllBlogs());

          return const Center(
            child: Text('Yükleme işlemi başlamadı'),
          );
        }

        if (state is BlogLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is UpdateBlogSuccess) {
          context.read<BlogBloc>().add(FetchAllBlogs());
        }

        if (state is BlogLoaded) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: RefreshIndicator(
              onRefresh: () async {
                context.read<BlogBloc>().add(FetchAllBlogs());
              },
              child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: state.blogs.length,
                itemBuilder: (context, index) => ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, 'details',
                        arguments: state.blogs[index]);
                  },
                  leading: Image.network(
                    state.blogs[index].thumbnail,
                    width: 50,
                  ),
                  title: Text(state.blogs[index].title),
                  subtitle: Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(state.blogs[index].author),
                      Text(
                        state.blogs[index].content,
                        // maxLines: 3,
                        style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }

        if (state is BlogLoadFailed) {
          return const Center(
            child: Text('Yükleme işlemi başarısız!'),
          );
        }

        return const Center(
          child: Text('Bilinmedik Durum!'),
        );
      },
    );
  }
}
