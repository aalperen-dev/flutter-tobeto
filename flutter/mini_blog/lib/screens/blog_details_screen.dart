import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mini_blog/models/blog_model.dart';
import 'package:mini_blog/screens/edit_screen.dart';
import 'package:mini_blog/screens/homepage.dart';

class BlogDetailsScreen extends StatefulWidget {
  final BlogModel blogModel;

  const BlogDetailsScreen({
    super.key,
    required this.blogModel,
  });

  @override
  State<BlogDetailsScreen> createState() => _BlogDetailsScreenState();
}

Future<void> _deletePost(
  BuildContext context,
  String postId,
) async {
  Uri url =
      Uri.parse("https://tobetoapi.halitkalayci.com/api/Articles/$postId");

  http.Response response = await http.delete(url);

  if (response.statusCode == 200) {
    if (context.mounted) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const HomePage(),
      ));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Post Silindi!'),
        ),
      );
    }
  } else {
    if (kDebugMode) {
      print('hata kodu : ${response.statusCode}');
    }
  }
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
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => EditScreen(blogModel: widget.blogModel),
              ));
            },
            icon: const Icon(
              Icons.edit,
            ),
          ),
          IconButton(
            onPressed: () async {
              _deletePost(
                context,
                widget.blogModel.id!,
              );
            },
            icon: const Icon(
              Icons.delete_forever,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
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
                  height:
                      selected ? MediaQuery.of(context).size.height - 200 : 200,
                  width: double.infinity,
                  alignment: selected
                      ? Alignment.center
                      : AlignmentDirectional.topCenter,
                  child: Image.network(
                    widget.blogModel.thumbnail,
                    fit: BoxFit.cover,

                    // scale: 2.0,
                  ),
                ),
              ),

              // başlık
              Text(
                widget.blogModel.title,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              // yazar
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                ),
                child: Text(
                  widget.blogModel.author,
                  textAlign: TextAlign.center,
                ),
              ),
              // içerik
              Text(
                widget.blogModel.content,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
