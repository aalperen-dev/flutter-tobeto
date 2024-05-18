import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mini_blog/models/blog_model.dart';
import 'package:mini_blog/screens/edit_screen.dart';
import 'package:mini_blog/screens/homepage.dart';

import '../bloc/blog/blog_bloc.dart';

class BlogDetailsScreen extends StatefulWidget {
  // final BlogModel blogModel;

  const BlogDetailsScreen({
    super.key,
    // required this.blogModel,
  });

  @override
  State<BlogDetailsScreen> createState() => _BlogDetailsScreenState();
}

class _BlogDetailsScreenState extends State<BlogDetailsScreen> {
  late bool selected;

  @override
  void initState() {
    super.initState();

    selected = false;
  }

  @override
  Widget build(BuildContext context) {
    final blogModel = ModalRoute.of(context)?.settings.arguments as BlogModel;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              // geçici çözüm

              Navigator.of(context)
                  .pushReplacementNamed('edit', arguments: blogModel);
            },
            icon: const Icon(
              Icons.edit,
            ),
          ),
          IconButton(
            onPressed: () async {
              // _deletePost(
              //   context,
              //   widget.blogModel.id!,
              // );

              context.read<BlogBloc>().add(DeleteBlog(postId: blogModel.id!));

              // Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.delete_forever,
            ),
          ),
        ],
      ),
      body: BlocListener<BlogBloc, BlogState>(
        listener: (context, state) async {
          if (state is UpdateBlogSuccess) {
            setState(() {});
          }

          if (state is DeleteBlogSuccess && context.mounted) {
            context.read<BlogBloc>().add(FetchAllBlogs());

            await Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const HomePage(),
            ));
          }
          if (state is DeleteBlogFailed && context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Ekleme Hatalı'),
              ),
            );
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // resim
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selected = !selected;
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(seconds: 2),
                    curve: Curves.fastOutSlowIn,
                    height: selected
                        ? MediaQuery.of(context).size.height - 200
                        : 200,
                    width: double.infinity,
                    alignment: selected
                        ? Alignment.center
                        : AlignmentDirectional.topCenter,
                    child: Image.network(
                      blogModel.thumbnail,
                      fit: BoxFit.cover,

                      // scale: 2.0,
                    ),
                  ),
                ),

                // başlık
                Text(
                  blogModel.title,
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
                // yazar
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  child: Text(
                    blogModel.author,
                    textAlign: TextAlign.center,
                  ),
                ),
                // içerik
                Text(
                  blogModel.content,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
