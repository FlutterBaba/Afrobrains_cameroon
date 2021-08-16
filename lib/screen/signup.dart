import 'package:afrobrains_cameroon/provider/firebase_data_provider.dart';
import 'package:afrobrains_cameroon/screen/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool showPassword = false;

  String dateOfBirth = "";
  String placeOfBirth = "";

  TextEditingController fullName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController neighborhood = TextEditingController();
  TextEditingController town = TextEditingController();
  TextEditingController region = TextEditingController();
  TextEditingController country = TextEditingController();

  FirebaseDataProvider? firebaseDataProvider;

  @override
  Widget build(BuildContext context) {
    firebaseDataProvider = Provider.of<FirebaseDataProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'Signup',
              style: TextStyle(
                fontSize: 25,
                color: Colors.black,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  controller: fullName,
                  decoration: InputDecoration(
                    hintText: 'Full Name',
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: email,
                  decoration: InputDecoration(
                    hintText: 'Email:',
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: password,
                  obscureText: showPassword ? false : true,
                  decoration: InputDecoration(
                    hintText: 'Password:',
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
                  height: 15,
                ),
                TextField(
                  controller: phone,
                  decoration: InputDecoration(
                    hintText: 'Phone:',
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      dateOfBirth == "" ? "DateOfBirth" : dateOfBirth,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.calendar_today_rounded,
                          color: Colors.grey),
                      onPressed: () {
                        DatePicker.showDatePicker(
                          context,
                          showTitleActions: true,
                          minTime: DateTime(1888, 3, 5),
                          maxTime: DateTime(2021, 6, 7),
                          onChanged: (date) {
                            setState(() {
                              this.dateOfBirth =
                                  DateFormat('MM/dd/yyyy').format(date);
                            });
                          },
                          locale: LocaleType.en,
                        );
                      },
                    )
                  ],
                ),
                Divider(
                  thickness: 3,
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: gender,
                  decoration: InputDecoration(
                    hintText: 'Gender:',
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      placeOfBirth == "" ? "PlaceOfBirth" : placeOfBirth,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.calendar_today_rounded,
                          color: Colors.grey),
                      onPressed: () {
                        DatePicker.showDatePicker(
                          context,
                          showTitleActions: true,
                          minTime: DateTime(1888, 3, 5),
                          maxTime: DateTime(2021, 6, 7),
                          onChanged: (date) {
                            setState(() {
                              this.placeOfBirth =
                                  DateFormat('MM/dd/yyyy').format(date);
                            });
                            print(placeOfBirth);
                          },
                          locale: LocaleType.en,
                        );
                      },
                    )
                  ],
                ),
                Divider(
                  thickness: 3,
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: neighborhood,
                  decoration: InputDecoration(
                    hintText: 'Neighborhood:',
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: town,
                  decoration: InputDecoration(
                    hintText: 'Town:',
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: region,
                  decoration: InputDecoration(
                    hintText: 'Region:',
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: country,
                  decoration: InputDecoration(
                    hintText: 'Country',
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                firebaseDataProvider!.loadding == false
                    ? MaterialButton(
                        height: 60,
                        shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        minWidth: double.infinity,
                        color: Color(0xff008448),
                        onPressed: () {
                          firebaseDataProvider!.validation(
                            context: context,
                            country: country,
                            dateOfBirth: dateOfBirth,
                            email: email,
                            fullName: fullName,
                            gender: gender,
                            neighborhood: neighborhood,
                            password: password,
                            phone: phone,
                            placeOfBirth: placeOfBirth,
                            region: region,
                            town: town,
                          );
                        },
                        child: Text(
                          'SIGN UP',
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
                            builder: (context) => LoginScreen(),
                          ),
                        );
                      },
                      child: Text(
                        'SIGN IN',
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
    );
  }
}
