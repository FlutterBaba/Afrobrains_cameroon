import 'package:cloud_firestore/cloud_firestore.dart';

class UserModels {
  final String? fullName;
  final String? email;
  final String? password;
  final String? phone;
  final String? dateOfBirth;
  final String? gender;
  final String? placeOfBirth;
  final String? neighborhood;
  final String? town;
  final String? region;
  final String? country;
  UserModels({
    this.fullName,
    this.email,
    this.password,
    this.phone,
    this.dateOfBirth,
    this.gender,
    this.placeOfBirth,
    this.neighborhood,
    this.town,
    this.region,
    this.country,
  });
  factory UserModels.fromDocument(DocumentSnapshot doc) {
    return UserModels(
      fullName: doc["fullName"],
      email: doc["email"],
      password: doc["password"],
      phone: doc["phone"],
      dateOfBirth: doc["dateOfBirth"],
      gender: doc["gender"],
      placeOfBirth: doc["placeOfBirth"],
      neighborhood: doc["neighborhood"],
      town: doc["town"],
      region: doc["region"],
      country: doc["country"],
    );
  }
}