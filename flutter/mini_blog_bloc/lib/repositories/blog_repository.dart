import 'package:mini_blog/models/blog_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class BlogRepository {
  Future<List<BlogModel>> fetchAllBlogs() async {
    Uri url = Uri.parse("https://tobetoapi.halitkalayci.com/api/Articles");

    final http.Response response = await http.get(url);

    final List jsonBody = convert.jsonDecode(response.body);
    List<BlogModel> reversedList =
        jsonBody.map((e) => BlogModel.fromMap(e)).toList();
    return reversedList.reversed.toList();
  }

  // Future<void> deletePost(
  //   String postId,
  // ) async {
  //   Uri url =
  //       Uri.parse("https://tobetoapi.halitkalayci.com/api/Articles/$postId");

  //   final http.Response response = await http.delete(url);
  // }
}
