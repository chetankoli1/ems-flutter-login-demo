import 'package:example/screens/registrationScreen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({ Key? key }) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Form(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "FACI",
                      style: TextStyle(fontSize: 25),
                    ),
                    Text(
                      "O",
                      style: TextStyle(fontSize: 25, color: Colors.green),
                    )
                  ],
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  width: 400,
                  child: TextFormField(
                    decoration: const InputDecoration(
                      label: Text("Enter Email"),
                      prefixIcon: Icon(Icons.mail),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  width: 400,
                  child: TextFormField(
                    obscureText: true,
                    decoration: const InputDecoration(
                      focusColor: Colors.lightGreenAccent,
                      prefixIcon: Icon(Icons.lock),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 400,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: Colors.green[300],
                    ),
                    const Text("Remember Me"),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const RegistrationScreen()));
                  },
                  child: Text(
                    "Forgot password?",
                    style: TextStyle(color: Colors.green[300]),
                  ),
                )
              ],
            ),
          ),
          ElevatedButton(onPressed: () {}, child: const Text("LOGIN")),
          SizedBox(
            width: 400,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Don't have an account?"),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const RegistrationScreen()));
                  },
                  child: const Text(
                    "Signup here",
                    style: TextStyle(color: Colors.green),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}