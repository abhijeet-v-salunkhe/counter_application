import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:couter_application/authentication/data/register_user.dart';
import 'package:couter_application/authentication/view/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AuthenticationService {
  final _auth = FirebaseAuth.instance;

  Future<String> signUp(RegisteredUser user) async {
    try {
      print("In try block.........");

      try {
        FirebaseFirestore db = FirebaseFirestore.instance;

        Map<String, dynamic> userData = <String, dynamic>{};

        userData = {
          "firstName": user.firstName,
          "lastName": user.lastName,
          "email": user.email,
        };

        await db.collection("User").doc(user.email).set(userData);
      } catch (e) {
        print("Error during storing Data : Error : $e");
        return e.toString();
      }

      await _auth.createUserWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );
      print("Complete ................");
      return "Registered";
    } on FirebaseAuthException catch (e) {
      print(
        "on FirebaseAuthException ${e.code} **************************************",
      );

      if (e.code == 'weak-password') {
        print('The password provided is too weak..................');
        return "The password provided is too weak, Please enter the strong password";
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email..............');
        return "The account already exists for that Email";
      } else {
        return "Not able to register please, enter valid Email";
      }
    } catch (e) {
      print("ERROR : $e ......................");
      return "Something went wrong, Please after some time";
    }
  }

  Future<String> logIn({var emailAddress, var password}) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      return "Logined";
    } on FirebaseAuthException catch (e) {
      print(
        "On FirebaseAuthException : ${e.code} *******************************************",
      );

      print("No user found for that Email");
      return "Invalid credentials, please check Email and password";
    } catch (e) {
      print("Error : $e");
      return "Something went wrong, please try again or try after some time";
    }
  }

  Future<String> resetPassword({required String email}) async {
    String status = "";
    await _auth
        .sendPasswordResetEmail(email: email)
        .then(
          (value) =>
              status =
                  "Reset password Email is sent to your Email Please check.",
        )
        .catchError(
          (e) =>
              status =
                  "We are not able to sent the reset password Email, Please try later.",
        );
    return status;
  }

  Future<void> logOut(BuildContext context) async {
    try {
      await _auth.signOut().then(
        (value) => Navigator.of(
          context,
        ).pushReplacement(MaterialPageRoute(builder: (context) => Login())),
      );
      print("Log out successfully");
    } catch (e) {
      print("Log out exception : $e ..........................");
    }
  }
}
