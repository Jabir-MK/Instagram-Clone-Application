// ignore_for_file: unnecessary_null_comparison

import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/models/user.dart' as model;
import 'package:instagram_clone/services/storage_services.dart';
import 'package:instagram_clone/utils/global_variables.dart';

class AuthServices {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  //
  Future<model.UserModel> getUserDetails() async {
    User currentUser = firebaseAuth.currentUser!;
    DocumentSnapshot documentSnapshot =
        await firestore.collection('users').doc(currentUser.uid).get();
    return model.UserModel.fromSnap(documentSnapshot);
  }

  // Method for sign up
  Future<String> userSignUp({
    required String email,
    required String password,
    required String userName,
    required String bioDetails,
    required Uint8List file,
  }) async {
    String responseMessage = 'Error';

    try {
      if (email.isNotEmpty ||
          userName.isNotEmpty ||
          password.isNotEmpty ||
          bioDetails.isNotEmpty ||
          file != null) {
        // Register user
        UserCredential credential =
            await firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        String imageURL =
            await StorageServices().uploadImage('profilePics', file, false);

        model.UserModel userModel = model.UserModel(
          email: email,
          userName: userName,
          uid: credential.user!.uid,
          imageURL: imageURL,
          bioDetails: bioDetails,
          following: [],
          followers: [],
        );
        // add user details to firestore database
        await firestore.collection('users').doc(credential.user!.uid).set(
              userModel.toJson(),
            );

        responseMessage = successMessage;
      }
    } on FirebaseAuthException catch (error) {
      if (error.code == 'invalid-email') {
        responseMessage = 'Invalid Email Format';
      } else if (error.code == 'weak-password') {
        responseMessage = 'Password is too short';
      }
    }
    return responseMessage;
  }

  // Method for Login
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String responseMessage = 'response';
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);

        responseMessage = successMessage;
      } else {
        responseMessage = 'Please enter valid inputs';
      }
    } on FirebaseException catch (error) {
      responseMessage = error.toString();
    }

    return responseMessage;
  }
}
