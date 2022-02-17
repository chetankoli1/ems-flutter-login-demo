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
  final formKey = GlobalKey<FormState>();
  final List<String> _genderItems = <String>["Male", "Female"];
  bool _absucurText1 = true;
  bool _absucurText2 = true;

  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  String? errMsg;

  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final genderController = TextEditingController();
  final passwordController = TextEditingController();
  String? imgUrl;

  hidepass() {
    setState(() {
      _absucurText1 = !_absucurText1;
    });
  }

  String? _selectedGender;

  String? get selectedGender => _selectedGender;
  set selectedGender(String? item) {
    setState(() {
      _selectedGender = item;
      print(selectedGender);
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
              padding: EdgeInsets.all(15),
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
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          hintText: "Name",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Name";
                          }
                          return null;
                        },
                        onFieldSubmitted: (value) {}),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.email_outlined),
                        hintText: "Email Address",
                      ),
                      controller: emailController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Email";
                        }
                        return null;
                      },
                      onFieldSubmitted: (value) {},
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: DropdownButton(
                      value: selectedGender,
                      isExpanded: true,
                      icon: Icon(Icons.person),
                      underline: Container(),
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
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Password";
                        }
                        return null;
                      },
                      onFieldSubmitted: (value) {},
                      onSaved: (value) {},
                      keyboardType: TextInputType.text,
                      obscureText: _absucurText1,
                      decoration: InputDecoration(
                        prefixIcon: IconButton(
                          icon: Icon(
                            _absucurText1
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () => hidepass(),
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
                      obscureText: true,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.lock),
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
                        registerUser();
                        // Navigator.pushNamed(context, '/home');
                      },
                      // onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));},
                      child: const Text(
                        "Login",
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
                      Fluttertoast.showToast(msg: 'Forgot Password Clicked!!');
                    },
                    child: const Text(
                      'Forgot Password?',
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

  void registerUser() async {
    if (formKey.currentState!.validate()) {
      try {
        await auth
            .createUserWithEmailAndPassword(
                email: emailController.text, password: passwordController.text)
            .then((value) => {toFirestore()})
            .catchError((onError) {
          Fluttertoast.showToast(msg: onError!.message);
        });
      } on FirebaseAuthException catch (err) {
        switch (err.code) {
          case "invalid email":
            errMsg = "Email is invalid";
            break;

          case "invalid-email":
            errMsg = "Email is invalid";
            break;

          case "wrong-password":
            errMsg = "wrong password";
            break;

          case "user-not-found":
            errMsg = "user not fond";
            break;
          default:
            errMsg = "Invalid Error";
        }

        Fluttertoast.showToast(msg: errMsg!);
      }
    }
  }

  toFirestore() async {
    FirebaseFirestore store = FirebaseFirestore.instance;
    User? user = auth.currentUser;

    UserModel model = UserModel();
    model.name = nameController.text;
    model.email = user!.email;
    model.gender = selectedGender;
    model.uid = user.uid;
    model.imgUrl = imgUrl;
    store.collection("Users").doc(user.uid).set(model.toMap());
    Fluttertoast.showToast(msg: "Account Created");
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
              onTap: () => showUserImageWithFilePicked(FileType.image),
              borderRadius: BorderRadius.circular(120),
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

  showUserImageWithFilePicked(FileType fileType) async {
    final picker = ImagePicker();
    File imageFile;
    final pickFile = await picker.getImage(source: ImageSource.gallery);
    imageFile = File(pickFile!.path);

    UploadTask uploadTask = firebaseStorage.ref("images").putFile(imageFile);

    var pUrl = await (await uploadTask).ref.getDownloadURL();
    setState(() {
      imgUrl = pUrl.toString();
    });
    Fluttertoast.showToast(msg: "image uploaded");
    print(imgUrl);
  }
}
