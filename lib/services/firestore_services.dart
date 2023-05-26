import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/models/posts.dart';
import 'package:instagram_clone/services/storage_services.dart';
import 'package:instagram_clone/utils/global_variables.dart';
import 'package:uuid/uuid.dart';

class FirestoreServices {
  //
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  Future<String> uploadPost(
    String caption,
    Uint8List file,
    String uid,
    String userName,
    String profileImg,
  ) async {
    String responseMessage = '';
    try {
      String imageUrl =
          await StorageServices().uploadImage('posts', file, true);
      String postId = const Uuid().v1();
      PostsModel post = PostsModel(
        caption: caption,
        userName: userName,
        uid: uid,
        postId: postId,
        datePublished: DateTime.now(),
        postURL: imageUrl,
        profileImg: profileImg,
        likes: [],
      );

      fireStore.collection('posts').doc(postId).set(post.toJson());
      responseMessage = successMessage;
    } catch (error) {
      responseMessage = error.toString();
    }
    return responseMessage;
  }
}
