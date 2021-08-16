import 'package:afrobrains_cameroon/model/cart_model.dart';
import 'package:afrobrains_cameroon/model/user_model.dart';
import 'package:afrobrains_cameroon/screen/homescreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseDataProvider with ChangeNotifier {
  /////////////////////////////////// Signup Page //////////////////////////////////////////////////////

  static Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  
  RegExp regExp = RegExp(FirebaseDataProvider.pattern.toString());
  UserCredential? userCredential;
  bool loadding = false;
  bool loginLoading = false;
  void validation({
    TextEditingController? fullName,
    TextEditingController? email,
    TextEditingController? password,
    TextEditingController? phone,
    String? dateOfBirth,
    TextEditingController? gender,
    String? placeOfBirth,
    TextEditingController? neighborhood,
    TextEditingController? town,
    TextEditingController? region,
    TextEditingController? country,
    BuildContext? context,
  }) async {
    if (fullName!.text.trim().isEmpty) {
      ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(
          content: Text("fullName is Empty"),
          duration: Duration(milliseconds: 300),
        ),
      );
      return;
    } else if (email!.text.trim().isEmpty) {
      ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(
          content: Text("email is Empty"),
          duration: Duration(milliseconds: 300),
        ),
      );
      return;
    } else if (!regExp.hasMatch(email.text.trim())) {
      ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(
          content: Text("invalid email address"),
          duration: Duration(milliseconds: 300),
        ),
      );
      return;
    } else if (password!.text.trim().isEmpty) {
      ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(
          content: Text("password is Empty"),
          duration: Duration(milliseconds: 300),
        ),
      );
      return;
    } else if (phone!.text.trim().isEmpty) {
      ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(
          content: Text("phone is Empty"),
          duration: Duration(milliseconds: 300),
        ),
      );
      return;
    } else if (dateOfBirth == '') {
      ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(
          content: Text("dateOfBirth is Empty"),
          duration: Duration(milliseconds: 300),
        ),
      );
      return;
    } else if (gender!.text.trim().isEmpty) {
      ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(
          content: Text("gender is Empty"),
          duration: Duration(milliseconds: 300),
        ),
      );
      return;
    } else if (placeOfBirth == '') {
      ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(
          content: Text("placeOfBirth is Empty"),
          duration: Duration(milliseconds: 300),
        ),
      );
      return;
    } else if (neighborhood!.text.trim().isEmpty) {
      ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(
          content: Text("neighborhood is Empty"),
          duration: Duration(milliseconds: 300),
        ),
      );
      return;
    } else if (town!.text.trim().isEmpty) {
      ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(
          content: Text("town is Empty"),
          duration: Duration(milliseconds: 300),
        ),
      );
      return;
    } else if (region!.text.trim().isEmpty) {
      ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(
          content: Text("region is Empty"),
          duration: Duration(milliseconds: 300),
        ),
      );
      return;
    } else if (country!.text.trim().isEmpty) {
      ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(
          content: Text("country is Empty"),
          duration: Duration(milliseconds: 300),
        ),
      );
      return;
    } else {
      try {
        loadding = true;
        notifyListeners();
        userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.text,
          password: password.text,
        );
        loadding = true;
        notifyListeners();
        FirebaseFirestore.instance
            .collection("users")
            .doc(userCredential!.user!.uid)
            .set(
          {
            "fullName": fullName.text,
            "email": email.text,
            "password": password.text,
            "phone": phone.text,
            "dateOfBirth": dateOfBirth,
            "gender": gender.text,
            "placeOfBirth": placeOfBirth,
            "neighborhood": neighborhood.text,
            "town": town.text,
            "region": region.text,
            "country": country.text,
            "userUid": userCredential!.user!.uid,
          },
        ).then((value) async {
          loadding = false;
          notifyListeners();
          await Navigator.of(context!).push(
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
          );
        });
      } on FirebaseAuthException catch (e) {
        loadding = false;
        notifyListeners();
        if (e.code == 'weak-password') {
          ScaffoldMessenger.of(context!).showSnackBar(
            SnackBar(
              content: Text("The password provided is too weak."),
              duration: Duration(milliseconds: 300),
            ),
          );
        } else if (e.code == 'email-already-in-use') {
          ScaffoldMessenger.of(context!).showSnackBar(
            SnackBar(
              content: Text("The account already exists for that email."),
              duration: Duration(milliseconds: 300),
            ),
          );
        }
      }
    }
  }

///////////////////////////////////Login Auth //////////////////////////////////////////////////////

  void buildLoginValidation({
    TextEditingController? email,
    TextEditingController? password,
    BuildContext? context,
  }) async {
    if (email!.text.trim().isEmpty && password!.text.trim().isEmpty) {
      ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(
          content: Text("Fields are empty"),
          duration: Duration(milliseconds: 300),
        ),
      );
    } else if (email.text.trim().isEmpty) {
      ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(
          content: Text("Email is Empty"),
          duration: Duration(milliseconds: 300),
        ),
      );
      return;
    } else if (!regExp.hasMatch(email.text.trim())) {
      ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(
          content: Text("invalid email address"),
          duration: Duration(milliseconds: 300),
        ),
      );
      return;
    } else if (password!.text.trim().isEmpty) {
      ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(
          content: Text("Password is Empty"),
          duration: Duration(milliseconds: 300),
        ),
      );
      return;
    } else {
      try {
        loginLoading = true;
        notifyListeners();
        userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
          email: email.text,
          password: password.text,
        )
            .then((value) async {
          loginLoading = false;
          await Navigator.of(context!).pushReplacement(
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
          );
        });
        notifyListeners();
      } on FirebaseAuthException catch (e) {
        loginLoading = false;
        notifyListeners();
        if (e.code == 'user-not-found') {
          ScaffoldMessenger.of(context!).showSnackBar(
            SnackBar(
              content: Text('No user found for that email.'),
            ),
          );
        } else if (e.code == 'wrong-password') {
          ScaffoldMessenger.of(context!).showSnackBar(
            SnackBar(
              content: Text('Wrong password provided for that user.'),
            ),
          );
        }
      }
    }
  }

//////////////////////////////////////////////////////////////////

  UserModels? userModels;

  getUserData() async {
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    userModels = UserModels.fromDocument(documentSnapshot);
    notifyListeners();
  }

  get currentUserModel {
    return userModels;
  }
}