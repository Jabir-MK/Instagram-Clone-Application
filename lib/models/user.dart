import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String email;
  final String userName;
  final String uid;
  final String imageURL;
  final String bioDetails;
  final List following;
  final List followers;

  UserModel({
    required this.email,
    required this.userName,
    required this.uid,
    required this.imageURL,
    required this.bioDetails,
    required this.following,
    required this.followers,
  });
  Map<String, dynamic> toJson() => {
        'username': userName,
        'email': email,
        'uid': uid,
        'imageURL': imageURL,
        'bioDetails': bioDetails,
        'following': following,
        'followers': followers,
      };

  static UserModel fromSnap(DocumentSnapshot documentSnapshot) {
    var snapshot = documentSnapshot.data() as Map<String, dynamic>;
    return UserModel(
      email: snapshot['email'],
      userName: snapshot['username'],
      uid: snapshot['uid'],
      imageURL: snapshot['imageURL'],
      bioDetails: snapshot['biodetails'],
      following: snapshot['following'],
      followers: snapshot['followers'],
    );
  }
}
