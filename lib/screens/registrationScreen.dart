import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:example/model/usermodel.dart';
import 'package:example/screens/homeScreen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final List<String> _genderItems = <String>["Male", "Female"];

  String? _selectedGender;

  bool _obscureText1 = true;
  bool _obscureText2 = true;

  final firebaseStorage = FirebaseStorage.instance;
  final firebaseAuth = FirebaseAuth.instance;

  final formKey = GlobalKey<FormState>();

  String? imageUrl;
  String? errorMessage;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  String? imgUrl;

  hidePassword() {
    setState(() {
      _obscureText1 = !_obscureText1;
    });
  }

  hideConfirmPassword() {
    setState(() {
      _obscureText2 = !_obscureText2;
    });
  }

  String? get selectedGender => _selectedGender;

  set selectedGender(String? item) {
    setState(() {
      _selectedGender = item;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              alignment: Alignment.center,
              child: UserImage(context),
            ),
            Form(
              key: formKey,
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: TextFormField(
                      controller: nameController,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Name";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        nameController.text = value!;
                      },
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        hintText: "Name",
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Email";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        emailController.text = value!;
                      },
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.email_outlined),
                        hintText: "Email Address",
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: DropdownButtonFormField(
                      validator: ((value) => value == null ? "required" : null),
                      value: selectedGender,
                      isExpanded: true,
                      icon: const Icon(Icons.person),
                      // underline: Container(),
                      hint: const Text('Select Gender'),
                      items: _genderItems
                          .map<DropdownMenuItem<String>>(
                              (e) => DropdownMenuItem<String>(
                                    value: e,
                                    child: Text(e),
                                  ))
                          .toList(),
                      onChanged: (dynamic value) => selectedGender = value,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      obscureText: _obscureText1,
                      controller: passwordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Password";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        passwordController.text = value!;
                      },
                      decoration: InputDecoration(
                        prefixIcon: IconButton(
                          icon: Icon(_obscureText1
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () {
                            hidePassword();
                          },
                        ),
                        hintText: "Password",
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      controller: confirmPasswordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Conform Password";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        confirmPasswordController.text = value!;
                      },
                      obscureText: _obscureText2,
                      decoration: InputDecoration(
                        prefixIcon: IconButton(
                          onPressed: () {
                            hideConfirmPassword();
                          },
                          icon: Icon(_obscureText2
                              ? Icons.visibility_off
                              : Icons.visibility),
                        ),
                        hintText: "Confirm Password",
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: ElevatedButton(
                      onPressed: () {
                        signUpUser();
                      },
                      // onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));},
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: const Text(
                      'Already have an account?',
                      style: TextStyle(),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void signUpUser() async {
    if (formKey.currentState!.validate()) {
      if (imageUrl == null) {
        Fluttertoast.showToast(msg: "Please select Imgae");
      } else {
        try {
          await firebaseAuth
              .createUserWithEmailAndPassword(
                  email: emailController.text,
                  password: passwordController.text)
              .then((value) => {toFirestore()})
              .catchError((e) {
            Fluttertoast.showToast(msg: e!.message);
          });
        } on FirebaseAuthException catch (error) {
          switch (error.code) {
            case "invalid-email":
              errorMessage = "Email is invalid";
              break;

            case "wrong-password":
              errorMessage = "Password is Wrong";
              break;

            case "user-not-found":
              errorMessage = "User does not exist";
              break;

            default:
              errorMessage = "Invalid error";
          }

          Fluttertoast.showToast(msg: errorMessage!);
        }
      }
    }
  }

  toFirestore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = firebaseAuth.currentUser;

    UserModel userModel = UserModel();
    userModel.name = nameController.text;
    userModel.email = user!.email;
    userModel.gender = selectedGender;
    userModel.uid = user.uid;
    userModel.imgUrl = imageUrl;

    firebaseFirestore.collection("Users").doc(user.uid).set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account created!");
    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => const HomeScreen()),
        (route) => false);
  }

  Container UserImage(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: 100,
      height: 100,
      child: Center(
        child: Stack(
          children: [
            CircleAvatar(
              radius: 60,
              backgroundColor: theme.primaryColor,
            ),
            InkWell(
              borderRadius: BorderRadius.circular(120),
              onTap: () {
                showUserImageFilePicker(FileType.image);
              },
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: theme.primaryColorLight.withOpacity(.5),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.camera_alt_outlined,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  showUserImageFilePicker(FileType fileType) async {
    final picker = ImagePicker();
    File _imageFile;
    final pickFile = await picker.getImage(source: ImageSource.gallery);
    _imageFile = File(pickFile!.path);
    UploadTask uploadTask = firebaseStorage
        .ref('profileImage/')
        .child(DateTime.now().toString())
        .putFile(_imageFile);
    var pictureUrl =
        await (await uploadTask).ref.getDownloadURL().then((value) => () {});
    setState(() {
      imageUrl = pictureUrl.toString();
    });
    print(imageUrl);
    Fluttertoast.showToast(msg: 'Image uploaded');
  }
}
