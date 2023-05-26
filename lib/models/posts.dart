import 'package:cloud_firestore/cloud_firestore.dart';

class PostsModel {
  final String caption;
  final String userName;
  final String uid;
  final String postId;
  final DateTime datePublished;
  final String postURL;
  final String profileImg;
  final likes;

  PostsModel({
    required this.caption,
    required this.userName,
    required this.uid,
    required this.postId,
    required this.datePublished,
    required this.postURL,
    required this.profileImg,
    required this.likes,
  });
  Map<String, dynamic> toJson() => {
        'username': userName,
        'caption': caption,
        'uid': uid,
        'postId': postId,
        'datePublished': datePublished,
        'postURL': postURL,
        'profileImg': profileImg,
        'likes': likes,
      };

  static PostsModel fromSnap(DocumentSnapshot documentSnapshot) {
    var snapshot = documentSnapshot.data() as Map<String, dynamic>;
    return PostsModel(
      caption: snapshot['caption'],
      userName: snapshot['username'],
      uid: snapshot['uid'],
      postId: snapshot['postId'],
      postURL: snapshot['postURL'],
      profileImg: snapshot['profileImg'],
      datePublished: snapshot['datePublished'],
      likes: snapshot['likes'],
    );
  }
}
