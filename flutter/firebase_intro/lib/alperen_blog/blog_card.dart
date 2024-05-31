import 'package:flutter/material.dart';
import 'package:firebase_intro/alperen_blog/blog_fake_data.dart';
import 'package:firebase_intro/alperen_blog/blog_model.dart';

class BlogCardDesign extends StatelessWidget {
  const BlogCardDesign({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlogCard(
        blogModel: fakeBlog,
        onTap: () {},
      ),
    );
  }
}

//TODO: başık ve içerik stillendirilecek
class BlogCard extends StatelessWidget {
  final Function()? onTap;
  final BlogModel blogModel;
  const BlogCard({
    super.key,
    this.onTap,
    required this.blogModel,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        height: 450,
        width: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          // border: Border.all(),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              height: 210,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: const BorderRadius.all(
                  Radius.circular(25),
                ),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    blogModel.blogThumbnailUrl,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 180,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // tarih
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      blogModel.blogCreatedAt.toString(),
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ),
                  // başlık
                  Text(
                    blogModel.blogTitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  // içerik
                  Text(
                    blogModel.blogContent,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
