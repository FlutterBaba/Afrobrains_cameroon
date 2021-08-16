import 'package:afrobrains_cameroon/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

class ProfileScreen extends StatefulWidget {
  static Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  final UserModels? userModels;
  ProfileScreen({this.userModels});
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  RegExp regExp = RegExp(ProfileScreen.pattern.toString());
  TextEditingController fullName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  String dateOfBirth = '';
  TextEditingController town = TextEditingController();
  bool edit = false;
  AppBar buildAppBar() {
    return AppBar(
      elevation: 0.70,
      centerTitle: true,
      backgroundColor: Colors.white,
      leading: edit == false
          ? IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
              ),
            )
          : IconButton(
              onPressed: () {
                setState(() {
                  edit = false;
                });
              },
              icon: Icon(
                Icons.close,
              ),
            ),
      title: Text(
        "Account",
        style: TextStyle(
          color: Colors.black,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            setState(() {
              edit = true;
            });
          },
          icon: Icon(Icons.edit),
        )
      ],
    );
  }

  Widget buildlistTileWidget({String? leading, String? trailing}) {
    return ListTile(
      leading: Text(
        leading!,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: Text(
        trailing!,
        style: TextStyle(
          fontSize: 16,
        ),
      ),
    );
  }

  Widget buildBottomListTile({String leading = '', String trailing = ''}) {
    return ListTile(
      onTap: () {},
      leading: Text(
        leading,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: Wrap(
        spacing: 5,
        children: [
          Text(
            trailing,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          Icon(
            Icons.arrow_forward_ios_outlined,
            size: 20,
          ),
        ],
      ),
    );
  }

  void validation() {
    if (fullName.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("fullName is Empty"),
          duration: Duration(milliseconds: 300),
        ),
      );
      return;
    } else if (email.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("email is Empty"),
          duration: Duration(milliseconds: 300),
        ),
      );
      return;
    } else if (!regExp.hasMatch(email.text.trim())) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("invalid email address"),
          duration: Duration(milliseconds: 300),
        ),
      );
      return;
    } else if (phone.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("phone is Empty"),
          duration: Duration(milliseconds: 300),
        ),
      );
      return;
    } else if (dateOfBirthController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("dateOfBirth is Empty"),
          duration: Duration(milliseconds: 300),
        ),
      );
      return;
    } else if (town.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("town is Empty"),
          duration: Duration(milliseconds: 300),
        ),
      );
      return;
    } else {
      updateProfile();
    }
  }

  Widget buildTextFormField(
      {required String? hintText, required TextEditingController? controller}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    fullName.text = widget.userModels!.fullName.toString();
    email.text = widget.userModels!.email.toString();
    phone.text = widget.userModels!.phone.toString();
    dateOfBirthController.text = dateOfBirth == ""
        ? widget.userModels!.dateOfBirth.toString()
        : dateOfBirth;
    town.text = widget.userModels!.town.toString();

    return Scaffold(
      appBar: buildAppBar(),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Container(
            height: 200,
            margin: EdgeInsets.only(bottom: 10),
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Center(
                    child: CircleAvatar(
                      radius: 35,
                      backgroundColor: Colors.transparent,
                      backgroundImage: AssetImage("images/non_profile.jpg"),
                    ),
                  ),
                  Text(
                    widget.userModels!.fullName.toString(),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.userModels!.country.toString(),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          ),
          edit == false
              ? Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: Column(
                    children: [
                      buildlistTileWidget(
                        leading: "Full name",
                        trailing: widget.userModels!.fullName.toString(),
                      ),
                      Divider(),
                      buildlistTileWidget(
                        leading: "Email",
                        trailing: widget.userModels!.email.toString(),
                      ),
                      Divider(),
                      buildlistTileWidget(
                        leading: "Phone",
                        trailing: widget.userModels!.phone.toString(),
                      ),
                      Divider(),
                      buildlistTileWidget(
                        leading: "DateOfBirth",
                        trailing: widget.userModels!.dateOfBirth.toString(),
                      ),
                      Divider(),
                      buildlistTileWidget(
                        leading: "Town",
                        trailing: widget.userModels!.town.toString(),
                      ),
                      Divider(),
                    ],
                  ),
                )
              : Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: Column(
                    children: [
                      buildTextFormField(
                        hintText: "fullName",
                        controller: fullName,
                      ),
                      buildTextFormField(
                        hintText: "email",
                        controller: email,
                      ),
                      buildTextFormField(
                        hintText: "phone",
                        controller: phone,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: dateOfBirthController,
                          decoration: InputDecoration(
                            hintText: "dateOfBirth",
                            // hintText: this.dateOfBirth == ""
                            //     ? widget.userModels!.dateOfBirth.toString()
                            //     : this.dateOfBirth,
                            suffixIcon: IconButton(
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
                              icon: Icon(
                                Icons.calendar_today_rounded,
                              ),
                            ),
                          ),
                        ),
                      ),
                      buildTextFormField(
                        hintText: widget.userModels!.town.toString(),
                        controller: town,
                      ),
                    ],
                  ),
                ),
          edit == false
              ? Container()
              : Container(
                  margin: EdgeInsets.all(20),
                  child: MaterialButton(
                    height: 55,
                    color: Color(0xff008448),
                    child: Text(
                      'Update',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    onPressed: () {
                      validation();
                    },
                  ),
                )
        ],
      ),
    );
  }

  updateProfile() {
    FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      "fullName": fullName.text,
      "email": email.text,
      "phone": phone.text,
      "dateOfBirth": dateOfBirthController.text,
      "town": town.text,
    });
    setState(() {
      edit = false;
    });
  }
}
