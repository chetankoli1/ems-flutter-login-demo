import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:example/model/usermodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? user = FirebaseAuth.instance.currentUser;

  UserModel userModel = UserModel();

  @override
  void initState() {
    // TODO: implement initState
    FirebaseFirestore.instance
        .collection("Users")
        .doc(user!.uid)
        .get()
        .then((value) => () {
              this.userModel = UserModel.fromMap(value.data());
            });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            height: 100,
            width: 100,
            child: Center(
              child: CircleAvatar(
                radius: 60,
                child: CachedNetworkImage(
                  imageUrl: userModel.imgUrl!,
                  fit: BoxFit.fill,
                  imageBuilder: (context, imageProvider) => Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      // image: imageProvider,
                      // fit: BoxFit.fill
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            '${userModel.name}',
            style: theme.textTheme.bodyText1,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
           '${userModel.email}',
            style: theme.textTheme.bodyText1,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            '${userModel.gender}',
            style: theme.textTheme.bodyText1,
          ),
        ],
      ),
    );
  }
}
