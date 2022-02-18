import 'package:example/screens/homeScreen.dart';
import 'package:example/screens/registrationScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
              child: const Text(
                'FACIO',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                  fontSize: 50,
                ),
              ),
            ),
           Form(
             child: Column(
               children: [
                 Container(
                   width: MediaQuery.of(context).size.width * 0.6,
                   child: TextFormField(
                     keyboardType: TextInputType.emailAddress,
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
                   child: TextFormField(
                     keyboardType: TextInputType.text,
                     obscureText: true,
                     decoration: const InputDecoration(
                       prefixIcon: Icon(Icons.lock),
                       hintText: "Password",
                     ),
                   ),
                 ),
                 const SizedBox(
                   height: 10,
                 ),
                 Container(
                   width: MediaQuery.of(context).size.width * 0.6,
                   child: ElevatedButton(
                     onPressed: (){Get.to(() => HomeScreen());},
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
                   onTap: () {Navigator.push((context), MaterialPageRoute(builder: (context) => RegistrationScreen()));},
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
}