import 'package:afrobrains_cameroon/provider/firebase_data_provider.dart';
import 'package:afrobrains_cameroon/screen/signup.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FirebaseDataProvider? firebaseDataProvider;
  bool showPassword = false;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    firebaseDataProvider = Provider.of<FirebaseDataProvider>(context);
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Column(
              children: [
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        'images/logo/logo.jpg',
                      ),
                    ),
                  ),
                ),
                Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: email,
                        decoration: InputDecoration(
                          hintText: 'Email',
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextField(
                        controller: password,
                        obscureText: showPassword ? false : true,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          suffixIcon: IconButton(
                            icon: showPassword
                                ? Icon(Icons.visibility)
                                : Icon(
                                    Icons.visibility_off,
                                  ),
                            onPressed: () {
                              setState(() {
                                showPassword
                                    ? showPassword = false
                                    : showPassword = true;
                              });
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      firebaseDataProvider!.loginLoading == false
                          ? MaterialButton(
                              height: 60,
                              shape: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              minWidth: double.infinity,
                              color: Color(0xff008448),
                              onPressed: () {
                                firebaseDataProvider!.buildLoginValidation(
                                  context: context,
                                  email: email,
                                  password: password,
                                );
                              },
                              child: Text(
                                'LOG IN',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          : Center(
                              child: CircularProgressIndicator(),
                            ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Dont\' have an account?',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => Signup(),
                                ),
                              );
                            },
                            child: Text(
                              'SIGN UP',
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
