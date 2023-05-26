// ignore_for_file: use_build_context_synchronously

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/models/user.dart';
import 'package:instagram_clone/providers/user_provider.dart';
import 'package:instagram_clone/services/firestore_services.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/global_variables.dart';
import 'package:instagram_clone/utils/utils.dart';
import 'package:provider/provider.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  Uint8List? imgFile;
  final TextEditingController captionController = TextEditingController();
  bool isLoading = false;

  void savePosts(
    String uid,
    String userName,
    String profileImage,
  ) async {
    setState(() {
      isLoading = true;
    });
    try {
      String response = await FirestoreServices().uploadPost(
        captionController.text,
        imgFile!,
        uid,
        userName,
        profileImage,
      );
      if (response == successMessage) {
        setState(() {
          isLoading = false;
        });
        showSnackBar(context, 'Post uploaded successfully');
        clearImage();
      } else {
        setState(() {
          isLoading = false;
        });
        showSnackBar(context, response);
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  selectImage(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: const Text('New post'),
          children: [
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text('Take a Photo'),
              onPressed: () async {
                Navigator.pop(context);
                Uint8List cameraImage = await pickImage(ImageSource.camera);
                setState(() {
                  imgFile = cameraImage;
                });
              },
            ),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text('Choose from Gallery'),
              onPressed: () async {
                Navigator.pop(context);
                Uint8List galleryImage = await pickImage(ImageSource.gallery);
                setState(() {
                  imgFile = galleryImage;
                });
              },
            ),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void clearImage() {
    setState(() {
      imgFile = null;
    });
  }

  @override
  void dispose() {
    super.dispose();
    captionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final UserModel user = Provider.of<UserProvider>(context).getUser;
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: imgFile == null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => selectImage(context),
                    child: const CircleAvatar(
                      radius: 40,
                      backgroundColor: mobileSearchColor,
                      child: Icon(
                        Icons.upload_outlined,
                        size: 60,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Upload a new post.',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w100,
                    ),
                  ),
                ],
              )
            : Scaffold(
                appBar: AppBar(
                  backgroundColor: mobileBackgroundColor,
                  leading: IconButton(
                    onPressed: clearImage,
                    icon: const Icon(
                      Icons.close_outlined,
                      size: 35,
                    ),
                  ),
                  title: const Text('New post'),
                  actions: [
                    IconButton(
                      onPressed: () {
                        savePosts(
                          user.uid,
                          user.userName,
                          user.imageURL,
                        );
                      },
                      icon: const Icon(
                        Icons.check_rounded,
                        size: 35,
                      ),
                    ),
                    const SizedBox(width: 15)
                  ],
                ),
                body: Column(
                  children: [
                    const SizedBox(height: 10),
                    isLoading
                        ? const LinearProgressIndicator()
                        : const Padding(padding: EdgeInsets.only(top: 0)),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const SizedBox(width: 20),
                        CircleAvatar(
                          backgroundImage: NetworkImage(user.imageURL),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: TextField(
                            controller: captionController,
                            decoration: const InputDecoration(
                              hintText: 'Write a caption...',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Container(
                          height: 42,
                          width: 42,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: MemoryImage(imgFile!),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Divider(thickness: 1),
                  ],
                ),
              ));
  }
}
