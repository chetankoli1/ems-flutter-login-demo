import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final List<String> _genderItems = <String>["Male", "Female"];
  String? _selectedGender;

  String? get selectedGender => _selectedGender;
  set selectedGender(String? item){
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
                    ),
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
                        Navigator.pushNamed(context, '/homepage');
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
}
