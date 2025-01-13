import 'package:cloud_firestore/cloud_firestore.dart';

class RegisteredUser {
  String firstName;
  String lastName;
  String email;
  String password;

  RegisteredUser({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
  });


}
