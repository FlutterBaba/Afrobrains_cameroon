import 'package:afrobrains_cameroon/screen/signup.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class IntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff4aaa6d),
      body: SafeArea(
        child: ListView(
          children: [
            SizedBox(
              height: 30,
            ),
            Center(
              child: Column(
                children: [
                  Text(
                    'Welcome to Afro',
                    style: TextStyle(
                      fontSize: 35,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Text(
                    'Brains',
                    style: TextStyle(
                      fontSize: 35,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Explore Us',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white60,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Column(
              children: [
                Container(
                  height: 240,
                  width: 240,
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
                SizedBox(
                  height: 30,
                ),
                MaterialButton(
                  minWidth: 300,
                  height: 50,
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                    );
                  },
                  color: Colors.white,
                  elevation: 0,
                  child: Text(
                    'LOGIN',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff4ea76d),
                    ),
                  ),
                  shape: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(30)),
                ),
                SizedBox(
                  height: 30,
                ),
                MaterialButton(
                    minWidth: 300,
                  height: 50,
              
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Signup(),
                      ),
                    );
                  },
                  elevation: 0,
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  shape: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(20)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
