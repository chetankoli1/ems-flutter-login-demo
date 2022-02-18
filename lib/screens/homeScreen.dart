import 'package:example/model/usermodel.dart';
import 'package:example/screens/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? user = FirebaseAuth.instance.currentUser;

  UserModel userModel = UserModel();

  get kPrimaryColor => null;

  @override
  initState() {
    FirebaseFirestore.instance
        .collection("Users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.userModel = UserModel.fromMap(value.data());

      print(value.data());
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              height: 100,
              width: 100,
              child: userModel.imgUrl != null
                  ? CircleAvatar(
                      radius: 60,
                      child: CachedNetworkImage(
                        imageUrl: userModel.imgUrl!,
                        fit: BoxFit.fill,
                        imageBuilder: (context, imageProvider) => Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            image: DecorationImage(
                                image: imageProvider, fit: BoxFit.fill),
                          ),
                        ),
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                CircularProgressIndicator(
                          value: downloadProgress.progress,
                        ),
                        errorWidget: (context, url, error) => const Icon(
                          Icons.error,
                          size: 70,
                          color: Colors.red,
                        ),
                      ),
                    )
                  : const CircleAvatar(),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: Text(
              '${userModel.name}',
              style: theme.textTheme.bodyText1,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: Text(
              '${userModel.email}',
              style: theme.textTheme.bodyText1,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: Text(
              '${userModel.gender}',
              style: theme.textTheme.bodyText1,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.6,
            child: ElevatedButton(
              onPressed: () {
                FirebaseAuth.instance
                    .signOut()
                    .then((value) => {
                          Get.toEnd(() => {const LoginScreen()})
                        })
                    .catchError((onError) {
                  Fluttertoast.showToast(msg: "logout err");
                });
              },
              child: const Text(
                "Logout",
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: kPrimaryColor,
                fixedSize: const Size(200, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
