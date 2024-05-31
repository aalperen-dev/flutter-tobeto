import 'package:firebase_intro/alperen_blog/blog_model.dart';

String daglar =
    'https://images.unsplash.com/photo-1716847214623-c45b2db2d569?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw4fHx8ZW58MHx8fHx8';

String tokyo =
    'https://images.unsplash.com/photo-1716396484354-e90091645e0b?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxMnx8fGVufDB8fHx8fA%3D%3D';

final fakeBlog = BlogModel(
  blogId: '1',
  blogTitle: 'Başlık Deneme',
  blogContent: 'İçerik Deneme' * 10,
  blogThumbnailUrl: daglar,
  blogPictureUrl: tokyo,
  blogCreatedAt: DateTime.now(),
);
