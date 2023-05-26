// ignore_for_file: prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/responsive/mobile_screen_layout.dart';
import 'package:instagram_clone/responsive/respnosive_layout.dart';
import 'package:instagram_clone/responsive/web_screen_layout.dart';
import 'package:instagram_clone/screens/login_screen.dart';
import 'package:instagram_clone/services/auth_services.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/global_variables.dart';
import 'package:instagram_clone/utils/utils.dart';
import 'package:instagram_clone/widgets/text_field.dart';
// import 'package:flutter_svg/flutter_svg.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController bioDetailsController = TextEditingController();
  Uint8List? image;
  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    userNameController.dispose();
    bioDetailsController.dispose();
    super.dispose();
  }

  void addImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      image = img;
    });
  }

  void signUpUser() async {
    setState(() {
      isLoading = true;
    });
    String result = await AuthServices().userSignUp(
      email: emailController.text,
      password: passwordController.text,
      userName: userNameController.text,
      bioDetails: bioDetailsController.text,
      file: image!,
    );
    if (result != successMessage) {
      showSnackBar(context, result);
    } else {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const ResponsiveLayout(
          mobileScreenLayout: MobileScreenLayout(),
          webScreenLayout: WebScreenLayout(),
        ),
      ));
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Logo
              const SizedBox(height: 12),

              Center(
                child: Image.asset(
                  'assets/insta_logo.png',
                  color: primaryColor,
                  height: 50,
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: Stack(
                  children: [
                    image != null
                        ? CircleAvatar(
                            radius: 58, backgroundImage: MemoryImage(image!))
                        : const CircleAvatar(
                            radius: 58,
                            backgroundImage: NetworkImage(
                              'https://t4.ftcdn.net/jpg/03/46/93/61/360_F_346936114_RaxE6OQogebgAWTalE1myseY1Hbb5qPM.jpg',
                            ),
                          ),
                    Positioned(
                      bottom: -8,
                      left: 70,
                      child: IconButton(
                        onPressed: () {
                          addImage();
                        },
                        icon: const Icon(Icons.add_a_photo_outlined, size: 35),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 12),

              TextFieldWidget(
                controller: userNameController,
                hintText: 'Username',
                keyBoard: TextInputType.name,
              ),
              const SizedBox(height: 12),

              TextFieldWidget(
                controller: bioDetailsController,
                hintText: 'Enter bio details',
                keyBoard: TextInputType.name,
              ),
              const SizedBox(height: 12),

              // Email Textfield
              TextFieldWidget(
                controller: emailController,
                hintText: 'Email address',
                keyBoard: TextInputType.emailAddress,
              ),
              const SizedBox(height: 12),

              // Password Textfield
              TextFieldWidget(
                controller: passwordController,
                hintText: 'Password',
                keyBoard: TextInputType.name,
                isPassword: true,
              ),
              // Submit button

              const SizedBox(height: 32),

              InkWell(
                onTap: () async {
                  signUpUser();
                },
                child: Container(
                  height: 42,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: blueColor,
                  ),
                  child: isLoading
                      ? const Center(
                          child: CircularProgressIndicator(color: primaryColor),
                        )
                      : const Center(child: Text('Sign Up')),
                ),
              ),
              const SizedBox(height: 24),

              // Signup options
              const Divider(color: secondaryColor, thickness: 1),
              const SizedBox(height: 8),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already a member? ",
                    style: TextStyle(
                      color: secondaryColor,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                      );
                    },
                    child: const Text(
                      'Log in.',
                      style: TextStyle(
                        color: blueColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
