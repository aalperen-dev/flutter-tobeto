import 'package:flutter/foundation.dart';
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

  Future<void> deleteBlog({
    required String postId,
  }) async {
    Uri url =
        Uri.parse("https://tobetoapi.halitkalayci.com/api/Articles/$postId");

    final http.Response response = await http.delete(url);

    if (response.statusCode == 200) {
      if (kDebugMode) {
        print('Delete Başarılı!');
      }
    } else {
      if (kDebugMode) {
        print('Delete Hata Kodu : ${response.statusCode}');
      }
    }
  }

  Future<void> updateBlog({
    required BlogModel blogModel,
  }) async {
    Uri url = Uri.parse("https://tobetoapi.halitkalayci.com/api/Articles/");

    http.Response response = await http.put(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: blogModel.toJson(),
    );

    if (response.statusCode == 200) {
      if (kDebugMode) {
        print('Update Başarılı!');
      }
    } else {
      if (kDebugMode) {
        print('Update Hata Kodu : ${response.statusCode}');
      }
    }
  }

  Future<void> submitBlog({
    required String blogTitle,
    required String blogContent,
    required String blogAuthor,
    required String imagePath,
  }) async {
    Uri url = Uri.parse("https://tobetoapi.halitkalayci.com/api/Articles");

    var request = http.MultipartRequest('POST', url);
    // içerik ekleme
    request.fields['Title'] = blogTitle;
    request.fields['Content'] = blogContent;
    request.fields['Author'] = blogAuthor;

    // dosya ekleme
    final file = await http.MultipartFile.fromPath('File', imagePath);
    request.files.add(file);

    // gönderme
    final response = await request.send();

    if (response.statusCode == 201) {
      if (kDebugMode) {
        print('Submit Başarılı!');
      }
    } else {
      if (kDebugMode) {
        print('Submit Hata Kodu : ${response.statusCode}');
      }
    }
  }

  // 400 hatası veriyor.
  // Future<void> _submitTest(
  //   BlogModel blogModel,
  // ) async {
  //   Uri url = Uri.parse("https://tobetoapi.halitkalayci.com/api/Articles");

  //   http.Response response = await http.post(
  //     url,
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //     body: blogModel.toJson(),
  //   );

  //   if (response.statusCode == 200) {
  //     if (kDebugMode) {
  //       print('Başarılı!!!');
  //     }
  //   } else {
  //     if (kDebugMode) {
  //       print('Hata Kodu : ${response.statusCode}');
  //     }
  //   }
  // }
}
