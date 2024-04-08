import 'package:flutter/material.dart';
import 'package:mini_blog/models/blog_model.dart';
import 'package:http/http.dart' as http;

class BlogDetailsScreen extends StatelessWidget {
  final BlogModel blogModel;
  const BlogDetailsScreen({
    super.key,
    required this.blogModel,
  });

  Future<void> _deletePost(
    BuildContext context,
    String postId,
  ) async {
    Uri url =
        Uri.parse("https://tobetoapi.halitkalayci.com/api/Articles/$postId");

    http.Response response = await http.delete(url);

    if (response.statusCode == 200) {
      if (context.mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Post Silindi!'),
          ),
        );
      }
    } else {
      print('hata kodu : ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.edit,
            ),
          ),
          IconButton(
            onPressed: () async {
              _deletePost(context, blogModel.id!);
            },
            icon: const Icon(
              Icons.delete_forever,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: Column(
          children: [
            // resim
            Image.network(
              blogModel.thumbnail!,
              fit: BoxFit.contain,
              height: 250,
            ),
            // başlık
            Text(
              blogModel.title!,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            // yazar
            Text(
              blogModel.author!,
            ),
            // içerik
            Text(
              blogModel.content!,
            ),
          ],
        ),
      ),
    );
  }
}
