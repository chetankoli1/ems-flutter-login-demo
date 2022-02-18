import 'package:example/screens/homeScreen.dart';
import 'package:example/screens/registrationScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  get kPrimaryColor => null;

  final fAuth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    fAuth.authStateChanges().listen((User? user) {
      if (user != null) {
        Get.to(const HomeScreen());
      }
    });
  }

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _loginKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'FACI',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                      fontSize: 50,
                    ),
                  ),
                  Text(
                    'O',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 50,
                    ),
                  ),
                ],
              ),
            ),
            Form(
              key: _loginKey,
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.email_outlined),
                        hintText: "Enter Email",
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Email";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _emailController.text = value!;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: TextFormField(
                      controller: _passwordController,
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        hintText: "Enter Password",
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Password";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _passwordController.text = value!;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: ElevatedButton(
                      onPressed: () {
                        startLogin();
                        // Get.to(() => const HomeScreen());
                      },
                      // onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));},
                      child: const Text(
                        "Login",
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
                  const SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          (context),
                          MaterialPageRoute(
                              builder: (context) =>
                                  const RegistrationScreen()));
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

  void startLogin() async {
    if (_loginKey.currentState!.validate()) {
      try {
        await fAuth
            .signInWithEmailAndPassword(
                email: _emailController.text,
                password: _passwordController.text)
            .then(
              (value) => {
                Get.to(const HomeScreen()),
                Fluttertoast.showToast(msg: 'user abc'),
              },
            )
            .catchError((e) {
          Fluttertoast.showToast(msg: e!.message);
        });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          Fluttertoast.showToast(msg: 'No user found for that email.');
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          Fluttertoast.showToast(msg: 'Wrong password provided for that user.');
          print('Wrong password provided for that user.');
        }
      }
    }
  }
}
